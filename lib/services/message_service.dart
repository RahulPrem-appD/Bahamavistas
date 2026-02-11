import '../models/message.dart';
import '../services/api_response.dart';
import '../utils/logger.dart';
import 'api_client.dart';

const _tag = 'MessageService';

class MessageService {
  final ApiClient _client;

  MessageService(this._client);

  Future<List<Conversation>> getConversations() async {
    AppLogger.info(_tag, 'getConversations');
    final response = await _client.get('/messages/conversations');
    final data = response.data['data'];
    final conversations = (data['conversations'] as List<dynamic>?)
            ?.map((j) {
              final map = j as Map<String, dynamic>;
              return Conversation(
                participantId: map['participant_id'] as int,
                participantName: map['participant_name'] as String,
                lastMessage: Message.fromJson(map['last_message'] as Map<String, dynamic>),
                unreadCount: map['unread_count'] as int? ?? 0,
              );
            })
            .toList() ??
        [];
    AppLogger.info(_tag, 'getConversations: returned ${conversations.length} conversations');
    return conversations;
  }

  Future<PaginatedResponse<Message>> getConversation(int participantId, {int page = 1, int limit = 50}) async {
    AppLogger.info(_tag, 'getConversation: participantId=$participantId, page=$page');
    final response = await _client.get('/messages/conversations/$participantId', queryParameters: {
      'page': page,
      'limit': limit,
    });
    final data = response.data['data'];
    final messages = (data['messages'] as List<dynamic>?)
            ?.map((j) => Message.fromJson(j as Map<String, dynamic>))
            .toList() ??
        [];
    AppLogger.info(_tag, 'getConversation: returned ${messages.length} messages');
    return PaginatedResponse(
      items: messages,
      total: data['total'] as int? ?? messages.length,
      page: data['page'] as int? ?? 1,
      limit: data['limit'] as int? ?? limit,
    );
  }

  Future<Message> sendMessage({
    required int receiverId,
    required String receiverType,
    String? subject,
    required String body,
  }) async {
    AppLogger.info(_tag, 'sendMessage: receiverId=$receiverId');
    final response = await _client.post('/messages', data: {
      'receiver_id': receiverId,
      'receiver_type': receiverType,
      if (subject != null) 'subject': subject,
      'body': body,
    });
    AppLogger.info(_tag, 'sendMessage: success');
    return Message.fromJson(response.data['data']);
  }

  Future<void> markAsRead(int messageId) async {
    AppLogger.info(_tag, 'markAsRead: id=$messageId');
    await _client.put('/messages/$messageId/read');
  }

  Future<int> getUnreadCount() async {
    AppLogger.info(_tag, 'getUnreadCount');
    final response = await _client.get('/messages/unread-count');
    final count = response.data['data']['count'] as int? ?? 0;
    AppLogger.info(_tag, 'getUnreadCount: $count');
    return count;
  }
}
