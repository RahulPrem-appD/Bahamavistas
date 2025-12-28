import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_card.dart';
import 'chat_detail_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

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
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  // Support chat
                  _ChatItem(
                    name: 'BahamaVista Support',
                    message: 'Hi! How can we help you today?',
                    time: 'Just now',
                    isSupport: true,
                    unreadCount: 1,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ChatDetailScreen(
                            name: 'BahamaVista Support',
                            isSupport: true,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),

                  // Vendor chats
                  _ChatItem(
                    name: 'Atlantis Paradise Island',
                    message: 'Your room is ready! We look forward to...',
                    time: '2h ago',
                    isVerified: true,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ChatDetailScreen(
                            name: 'Atlantis Paradise Island',
                            isSupport: false,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),

                  _ChatItem(
                    name: 'Bahamas Car Rentals',
                    message: 'Your Jeep Wrangler is confirmed for Dec 29',
                    time: 'Yesterday',
                    isVerified: true,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ChatDetailScreen(
                            name: 'Bahamas Car Rentals',
                            isSupport: false,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),

                  _ChatItem(
                    name: 'Exuma Adventures',
                    message: 'Thank you for booking! See you at the dock at 8 AM',
                    time: 'Dec 18',
                    isVerified: true,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ChatDetailScreen(
                            name: 'Exuma Adventures',
                            isSupport: false,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),

                  _ChatItem(
                    name: 'Nassau Tours',
                    message: 'Great! The sunset cruise is available',
                    time: 'Dec 15',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ChatDetailScreen(
                            name: 'Nassau Tours',
                            isSupport: false,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
                      name[0],
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

