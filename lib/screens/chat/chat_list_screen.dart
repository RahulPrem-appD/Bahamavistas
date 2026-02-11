import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_card.dart';
import '../../providers/messages_provider.dart';
import 'chat_detail_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MessagesProvider>().fetchConversations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BahamaColors.offWhiteMist,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: BahamaColors.seaGradient,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Messages',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: BahamaColors.deepTeal,
                        ),
                      ),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: BahamaColors.whiteSand,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: BahamaColors.deepTeal.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.edit_outlined,
                          color: BahamaColors.islandBlue,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Chat with vendors and support',
                    style: TextStyle(
                      fontSize: 14,
                      color: BahamaColors.islandBlueDark,
                    ),
                  ),
                ],
              ),
            ),

            // Chat list
            Expanded(
              child: Consumer<MessagesProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading && provider.conversations.isEmpty) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(24),
                      itemCount: 4,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Shimmer.fromColors(
                          baseColor: BahamaColors.greyLight,
                          highlightColor: BahamaColors.offWhiteMist,
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: BahamaColors.greyLight,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  if (provider.conversations.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline_rounded,
                            size: 64,
                            color: BahamaColors.islandBlue.withOpacity(0.3),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No messages yet',
                            style: TextStyle(
                              fontSize: 16,
                              color: BahamaColors.greyPrimary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(24),
                    itemCount: provider.conversations.length,
                    itemBuilder: (context, index) {
                      final convo = provider.conversations[index];
                      final timeStr = _formatTime(convo.lastMessage.createdAt);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _ChatItem(
                          name: convo.participantName,
                          message: convo.lastMessage.body,
                          time: timeStr,
                          unreadCount: convo.unreadCount > 0 ? convo.unreadCount : null,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChatDetailScreen(
                                  name: convo.participantName,
                                  participantId: convo.participantId,
                                  isSupport: false,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 2) return 'Yesterday';
    return DateFormat('MMM d').format(dateTime);
  }
}

class _ChatItem extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final bool isSupport;
  final bool isVerified;
  final int? unreadCount;
  final VoidCallback onTap;

  const _ChatItem({
    required this.name,
    required this.message,
    required this.time,
    this.isSupport = false,
    this.isVerified = false,
    this.unreadCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BahamaCard(
      onTap: onTap,
      child: Row(
        children: [
          // Avatar
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: isSupport
                  ? BahamaColors.ctaGradient
                  : LinearGradient(
                      colors: [
                        BahamaColors.paleTurquoise,
                        BahamaColors.softSeafoam,
                      ],
                    ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: isSupport
                  ? const Icon(
                      Icons.support_agent_rounded,
                      color: BahamaColors.deepTeal,
                      size: 28,
                    )
                  : Text(
                      name.isNotEmpty ? name[0] : '?',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: BahamaColors.islandBlue,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 16),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              name,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: unreadCount != null
                                    ? FontWeight.bold
                                    : FontWeight.w600,
                                color: BahamaColors.deepTeal,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isVerified || isSupport) ...[
                            const SizedBox(width: 4),
                            Icon(
                              isSupport
                                  ? Icons.verified_rounded
                                  : Icons.verified_outlined,
                              size: 14,
                              color: BahamaColors.islandBlue,
                            ),
                          ],
                        ],
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 12,
                        color: unreadCount != null
                            ? BahamaColors.islandBlue
                            : BahamaColors.greyPrimary,
                        fontWeight: unreadCount != null
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(
                          fontSize: 13,
                          color: unreadCount != null
                              ? BahamaColors.deepTeal
                              : BahamaColors.greyPrimary,
                          fontWeight: unreadCount != null
                              ? FontWeight.w500
                              : FontWeight.normal,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (unreadCount != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          gradient: BahamaColors.ctaGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          unreadCount.toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: BahamaColors.deepTeal,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
