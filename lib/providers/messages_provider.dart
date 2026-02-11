import 'package:flutter/foundation.dart';
import '../models/message.dart';
import '../services/message_service.dart';
import '../services/api_client.dart';
import '../utils/logger.dart';

const _tag = 'MessagesProvider';

class MessagesProvider extends ChangeNotifier {
  final MessageService _service;

  List<Conversation> _conversations = [];
  List<Message> _currentMessages = [];
  int _unreadCount = 0;
  bool _isLoading = false;
  String? _error;

  MessagesProvider(this._service);

  List<Conversation> get conversations => _conversations;
  List<Message> get currentMessages => _currentMessages;
  int get unreadCount => _unreadCount;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchConversations() async {
    AppLogger.info(_tag, 'fetchConversations');
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _conversations = await _service.getConversations();
      _unreadCount = _conversations.fold(0, (sum, c) => sum + c.unreadCount);
      AppLogger.info(_tag, 'fetchConversations: loaded ${_conversations.length} conversations');
    } catch (e) {
      _error = parseError(e);
      AppLogger.error(_tag, 'fetchConversations: error - $_error', e);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMessages(int participantId) async {
    AppLogger.info(_tag, 'fetchMessages: participantId=$participantId');
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _service.getConversation(participantId);
      _currentMessages = result.items;
      AppLogger.info(_tag, 'fetchMessages: loaded ${_currentMessages.length} messages');
    } catch (e) {
      _error = parseError(e);
      AppLogger.error(_tag, 'fetchMessages: error - $_error', e);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> sendMessage({
    required int receiverId,
    required String receiverType,
    String? subject,
    required String body,
  }) async {
    AppLogger.info(_tag, 'sendMessage: receiverId=$receiverId');
    try {
      final message = await _service.sendMessage(
        receiverId: receiverId,
        receiverType: receiverType,
        subject: subject,
        body: body,
      );
      _currentMessages.add(message);
      AppLogger.info(_tag, 'sendMessage: success');
      notifyListeners();
      return true;
    } catch (e) {
      _error = parseError(e);
      AppLogger.error(_tag, 'sendMessage: error - $_error', e);
      notifyListeners();
      return false;
    }
  }

  Future<void> markAsRead(int messageId) async {
    try {
      await _service.markAsRead(messageId);
      final index = _currentMessages.indexWhere((m) => m.id == messageId);
      if (index != -1) {
        // Refresh to get updated read status
        await fetchConversations();
      }
    } catch (e) {
      AppLogger.error(_tag, 'markAsRead: error', e);
    }
  }

  Future<void> fetchUnreadCount() async {
    try {
      _unreadCount = await _service.getUnreadCount();
      AppLogger.debug(_tag, 'fetchUnreadCount: $_unreadCount');
      notifyListeners();
    } catch (e) {
      AppLogger.error(_tag, 'fetchUnreadCount: error', e);
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
