class Message {
  final int id;
  final int senderId;
  final String senderType;
  final int receiverId;
  final String receiverType;
  final String? subject;
  final String body;
  final bool isRead;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.senderId,
    required this.senderType,
    required this.receiverId,
    required this.receiverType,
    this.subject,
    required this.body,
    this.isRead = false,
    required this.createdAt,
  });

  bool get isFromUser => senderType == 'user';

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as int,
      senderId: json['sender_id'] as int,
      senderType: json['sender_type'] as String,
      receiverId: json['receiver_id'] as int,
      receiverType: json['receiver_type'] as String,
      subject: json['subject'] as String?,
      body: json['body'] as String,
      isRead: json['is_read'] as bool? ?? false,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }
}

class Conversation {
  final int participantId;
  final String participantName;
  final Message lastMessage;
  final int unreadCount;

  Conversation({
    required this.participantId,
    required this.participantName,
    required this.lastMessage,
    this.unreadCount = 0,
  });
}
