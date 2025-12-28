import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_card.dart';
import '../../utils/constants.dart';
import '../auth/login_screen.dart';
import 'settings_screen.dart';
import 'favorites_screen.dart';
import 'notifications_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [BahamaColors.lightAqua, BahamaColors.whiteSand],
            stops: [0.0, 0.35],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),

                // Profile header
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: BahamaColors.islandBlue,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: BahamaColors.deepTeal.withOpacity(0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: AppImages.avatar1,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: BahamaColors.greyLight,
                            child: const Icon(
                              Icons.person,
                              size: 50,
                              color: BahamaColors.islandBlue,
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: BahamaColors.whiteSand,
                            child: const Icon(
                              Icons.person_rounded,
                              size: 50,
                              color: BahamaColors.islandBlue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          gradient: BahamaColors.ctaGradient,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          size: 16,
                          color: BahamaColors.deepTeal,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Sarah Mitchell',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: BahamaColors.deepTeal,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'sarah.mitchell@email.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: BahamaColors.greyPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: BahamaColors.islandBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        size: 16,
                        color: BahamaColors.islandBlue,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Verified Member',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: BahamaColors.islandBlue,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Stats
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: BahamaCard(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatItem(value: '12', label: 'Trips'),
                        Container(
                          width: 1,
                          height: 40,
                          color: BahamaColors.greyLight,
                        ),
                        _StatItem(value: '4.9', label: 'Rating'),
                        Container(
                          width: 1,
                          height: 40,
                          color: BahamaColors.greyLight,
                        ),
                        _StatItem(value: '\$2.4k', label: 'Saved'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Menu items
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      _ProfileMenuItem(
                        icon: Icons.person_outline_rounded,
                        title: 'Edit Profile',
                        onTap: () {},
                      ),
                      _ProfileMenuItem(
                        icon: Icons.credit_card_rounded,
                        title: 'Payment Methods',
                        onTap: () {},
                      ),
                      _ProfileMenuItem(
                        icon: Icons.notifications_outlined,
                        title: 'Notifications',
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: BahamaColors.warmGold,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            '3',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: BahamaColors.deepTeal,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationsScreen(),
                            ),
                          );
                        },
                      ),
                      _ProfileMenuItem(
                        icon: Icons.favorite_outline_rounded,
                        title: 'Saved Places',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FavoritesScreen(),
                            ),
                          );
                        },
                      ),
                      _ProfileMenuItem(
                        icon: Icons.settings_outlined,
                        title: 'Settings',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsScreen(),
                            ),
                          );
                        },
                      ),
                      _ProfileMenuItem(
                        icon: Icons.help_outline_rounded,
                        title: 'Help & Support',
                        onTap: () {},
                      ),
                      _ProfileMenuItem(
                        icon: Icons.info_outline_rounded,
                        title: 'About BahamaVista',
                        onTap: () {},
                      ),
                      const SizedBox(height: 16),
                      _ProfileMenuItem(
                        icon: Icons.logout_rounded,
                        title: 'Log Out',
                        isDestructive: true,
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // App version
                const Text(
                  'BahamaVista v1.0.0',
                  style: TextStyle(
                    fontSize: 12,
                    color: BahamaColors.greyPrimary,
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: BahamaColors.deepTeal,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: BahamaColors.greyPrimary,
          ),
        ),
      ],
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: BahamaColors.whiteSand,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: BahamaColors.deepTeal.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDestructive
                        ? Colors.red.withOpacity(0.1)
                        : BahamaColors.offWhiteMist,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: isDestructive
                        ? Colors.red
                        : BahamaColors.islandBlue,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: isDestructive
                          ? Colors.red
                          : BahamaColors.deepTeal,
                    ),
                  ),
                ),
                if (trailing != null)
                  trailing!
                else
                  Icon(
                    Icons.chevron_right_rounded,
                    color: BahamaColors.greySecondary,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
