import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_card.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BahamaColors.offWhiteMist,
      appBar: AppBar(
        backgroundColor: BahamaColors.whiteSand,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded, color: BahamaColors.deepTeal),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: BahamaColors.deepTeal,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Mark all read',
              style: TextStyle(
                color: BahamaColors.islandBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: AnimationLimiter(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Today section
            const Text(
              'Today',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: BahamaColors.deepTeal,
              ),
            ),
            const SizedBox(height: 12),
            ...List.generate(2, (index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _NotificationItem(
                      icon: index == 0 ? Icons.confirmation_number_outlined : Icons.chat_bubble_outline,
                      iconColor: index == 0 ? BahamaColors.islandBlue : BahamaColors.warmGold,
                      title: index == 0 ? 'Booking Confirmed!' : 'New Message',
                      message: index == 0
                          ? 'Your reservation at Atlantis Paradise Island is confirmed for Dec 29.'
                          : 'BahamaVista Support: "Hi! How can we help you today?"',
                      time: index == 0 ? '2 hours ago' : '30 min ago',
                      isUnread: true,
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 24),

            // Yesterday section
            const Text(
              'Yesterday',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: BahamaColors.deepTeal,
              ),
            ),
            const SizedBox(height: 12),
            ...List.generate(3, (index) {
              final notifications = [
                {
                  'icon': Icons.local_offer_outlined,
                  'iconColor': BahamaColors.warmGold,
                  'title': 'Special Offer!',
                  'message': 'Get 20% off on your next booking. Use code BAHAMA20.',
                  'time': 'Yesterday',
                },
                {
                  'icon': Icons.star_outline_rounded,
                  'iconColor': BahamaColors.warmGold,
                  'title': 'Rate Your Stay',
                  'message': 'How was your experience at Grand Hyatt Baha Mar?',
                  'time': 'Yesterday',
                },
                {
                  'icon': Icons.payment_outlined,
                  'iconColor': BahamaColors.islandBlue,
                  'title': 'Payment Received',
                  'message': 'Payment of \$1,512 for Atlantis Paradise Island was successful.',
                  'time': 'Yesterday',
                },
              ];
              final n = notifications[index];
              return AnimationConfiguration.staggeredList(
                position: index + 2,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _NotificationItem(
                      icon: n['icon'] as IconData,
                      iconColor: n['iconColor'] as Color,
                      title: n['title'] as String,
                      message: n['message'] as String,
                      time: n['time'] as String,
                      isUnread: false,
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 24),

            // Earlier section
            const Text(
              'Earlier',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: BahamaColors.deepTeal,
              ),
            ),
            const SizedBox(height: 12),
            AnimationConfiguration.staggeredList(
              position: 5,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: _NotificationItem(
                    icon: Icons.celebration_outlined,
                    iconColor: BahamaColors.warmGold,
                    title: 'Welcome to BahamaVista!',
                    message: 'Start exploring the beautiful Bahamas. Your island adventure awaits!',
                    time: 'Dec 20',
                    isUnread: false,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String time;
  final bool isUnread;

  const _NotificationItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.time,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: BahamaCard(
        backgroundColor: isUnread ? BahamaColors.islandBlue.withOpacity(0.05) : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                            color: BahamaColors.deepTeal,
                          ),
                        ),
                      ),
                      if (isUnread)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: BahamaColors.islandBlue,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 13,
                      color: BahamaColors.greyPrimary,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 12,
                      color: BahamaColors.greySecondary,
                    ),
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

