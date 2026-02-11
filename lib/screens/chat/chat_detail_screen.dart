import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import '../../theme/colors.dart';
import '../../providers/messages_provider.dart';

class ChatDetailScreen extends StatefulWidget {
  final String name;
  final bool isSupport;
  final int? participantId;

  const ChatDetailScreen({
    super.key,
    required this.name,
    required this.isSupport,
    this.participantId,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    if (widget.participantId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<MessagesProvider>().fetchMessages(widget.participantId!);
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || widget.participantId == null) return;

    setState(() => _isSending = true);
    _messageController.clear();

    await context.read<MessagesProvider>().sendMessage(
      receiverId: widget.participantId!,
      receiverType: 'vendor',
      body: text,
    );

    if (mounted) setState(() => _isSending = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BahamaColors.offWhiteMist,
      appBar: AppBar(
        backgroundColor: BahamaColors.whiteSand,
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: BahamaColors.deepTeal,
          ),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: widget.isSupport
                    ? BahamaColors.ctaGradient
                    : LinearGradient(
                        colors: [
                          BahamaColors.paleTurquoise,
                          BahamaColors.softSeafoam,
                        ],
                      ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: widget.isSupport
                    ? const Icon(
                        Icons.support_agent_rounded,
                        color: BahamaColors.deepTeal,
                        size: 20,
                      )
                    : Text(
                        widget.name.isNotEmpty ? widget.name[0] : '?',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: BahamaColors.islandBlue,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          widget.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: BahamaColors.deepTeal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.verified_rounded,
                        size: 14,
                        color: BahamaColors.islandBlue,
                      ),
                    ],
                  ),
                  const Text(
                    'Online',
                    style: TextStyle(
                      fontSize: 12,
                      color: BahamaColors.islandBlue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_rounded,
              color: BahamaColors.deepTeal,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: widget.participantId != null
                ? Consumer<MessagesProvider>(
                    builder: (context, provider, _) {
                      if (provider.isLoading && provider.currentMessages.isEmpty) {
                        return ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: 5,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Align(
                              alignment: index % 2 == 0
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Shimmer.fromColors(
                                baseColor: BahamaColors.greyLight,
                                highlightColor: BahamaColors.offWhiteMist,
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                    color: BahamaColors.greyLight,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      final messages = provider.currentMessages;
                      if (messages.isEmpty) {
                        return const Center(
                          child: Text(
                            'No messages yet. Say hello!',
                            style: TextStyle(
                              color: BahamaColors.greyPrimary,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.all(16),
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final msg = messages[messages.length - 1 - index];
                          final timeStr = DateFormat('h:mm a').format(msg.createdAt);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _MessageBubble(
                              message: msg.body,
                              isMe: msg.isFromUser,
                              time: timeStr,
                            ),
                          );
                        },
                      );
                    },
                  )
                : _buildStaticMessages(),
          ),

          // Input area
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: BahamaColors.whiteSand,
              boxShadow: [
                BoxShadow(
                  color: BahamaColors.deepTeal.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: BahamaColors.offWhiteMist,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.attach_file_rounded,
                      color: BahamaColors.islandBlue,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: BahamaColors.offWhiteMist,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          hintStyle: TextStyle(
                            color: BahamaColors.greyPrimary,
                          ),
                        ),
                        style: const TextStyle(
                          color: BahamaColors.deepTeal,
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: _isSending ? null : _sendMessage,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        gradient: BahamaColors.ctaGradient,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isSending ? Icons.hourglass_top : Icons.send_rounded,
                        color: BahamaColors.deepTeal,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaticMessages() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _DateDivider(date: 'Today'),
        const SizedBox(height: 16),
        if (widget.isSupport) ...[
          _MessageBubble(
            message: 'Hi! Welcome to BahamaVista support. How can I help you today?',
            isMe: false,
            time: '10:30 AM',
          ),
          const SizedBox(height: 12),
          _MessageBubble(
            message: 'Hi! I have a question about my upcoming booking.',
            isMe: true,
            time: '10:32 AM',
          ),
        ] else ...[
          _MessageBubble(
            message: 'Hello! Thank you for booking with us.',
            isMe: false,
            time: '2:30 PM',
          ),
          const SizedBox(height: 12),
          _MessageBubble(
            message: 'Hi! I\'m excited for my stay.',
            isMe: true,
            time: '2:45 PM',
          ),
        ],
      ],
    );
  }
}

class _DateDivider extends StatelessWidget {
  final String date;

  const _DateDivider({required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: BahamaColors.greyLight,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            date,
            style: const TextStyle(
              fontSize: 12,
              color: BahamaColors.greyPrimary,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: BahamaColors.greyLight,
          ),
        ),
      ],
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String time;

  const _MessageBubble({
    required this.message,
    required this.isMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: isMe ? BahamaColors.ctaGradient : null,
          color: isMe ? null : BahamaColors.whiteSand,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isMe ? 20 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 20),
          ),
          boxShadow: [
            BoxShadow(
              color: BahamaColors.deepTeal.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                fontSize: 14,
                color: BahamaColors.deepTeal,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                fontSize: 10,
                color: isMe
                    ? BahamaColors.deepTeal.withOpacity(0.7)
                    : BahamaColors.greyPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickReply extends StatelessWidget {
  final String text;

  const _QuickReply({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: BahamaColors.whiteSand,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: BahamaColors.islandBlue),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          color: BahamaColors.islandBlue,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
