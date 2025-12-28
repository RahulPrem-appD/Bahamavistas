import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class ChatDetailScreen extends StatefulWidget {
  final String name;
  final bool isSupport;

  const ChatDetailScreen({
    super.key,
    required this.name,
    required this.isSupport,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
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
                        widget.name[0],
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
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Date divider
                _DateDivider(date: 'Today'),
                const SizedBox(height: 16),

                // Messages
                if (widget.isSupport) ...[
                  _MessageBubble(
                    message: 'Hi! Welcome to BahamaVista support. How can I help you today?',
                    isMe: false,
                    time: '10:30 AM',
                  ),
                  const SizedBox(height: 12),
                  _MessageBubble(
                    message: 'Hi! I have a question about my upcoming booking at Atlantis.',
                    isMe: true,
                    time: '10:32 AM',
                  ),
                  const SizedBox(height: 12),
                  _MessageBubble(
                    message: 'Of course! I\'d be happy to help. Could you please share your confirmation number?',
                    isMe: false,
                    time: '10:33 AM',
                  ),
                  const SizedBox(height: 12),
                  _MessageBubble(
                    message: 'It\'s BV-2024-78542',
                    isMe: true,
                    time: '10:34 AM',
                  ),
                  const SizedBox(height: 12),
                  _MessageBubble(
                    message: 'Thank you! I can see your booking for Dec 29 - Jan 1 at Atlantis Paradise Island. What would you like to know?',
                    isMe: false,
                    time: '10:35 AM',
                  ),
                ] else ...[
                  _MessageBubble(
                    message: 'Hello! Thank you for booking with us.',
                    isMe: false,
                    time: '2:30 PM',
                  ),
                  const SizedBox(height: 12),
                  _MessageBubble(
                    message: 'Hi! I\'m excited for my stay. Is early check-in available?',
                    isMe: true,
                    time: '2:45 PM',
                  ),
                  const SizedBox(height: 12),
                  _MessageBubble(
                    message: 'We\'ll do our best to accommodate early check-in. Please let us know your arrival time and we\'ll confirm availability.',
                    isMe: false,
                    time: '3:00 PM',
                  ),
                  const SizedBox(height: 12),
                  _MessageBubble(
                    message: 'Great! I should arrive around 11 AM.',
                    isMe: true,
                    time: '3:15 PM',
                  ),
                  const SizedBox(height: 12),
                  _MessageBubble(
                    message: 'Perfect! Your room is ready! We look forward to welcoming you. 🌴',
                    isMe: false,
                    time: '3:20 PM',
                  ),
                ],

                const SizedBox(height: 16),

                // Quick replies (for support)
                if (widget.isSupport) ...[
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _QuickReply(text: 'Modify booking'),
                        _QuickReply(text: 'Cancel booking'),
                        _QuickReply(text: 'Request refund'),
                        _QuickReply(text: 'Other question'),
                      ],
                    ),
                  ),
                ],
              ],
            ),
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
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      gradient: BahamaColors.ctaGradient,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      color: BahamaColors.deepTeal,
                      size: 20,
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
                color: isMe ? BahamaColors.deepTeal : BahamaColors.deepTeal,
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

