import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_card.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
          'About BahamaVista',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: BahamaColors.deepTeal),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Logo and version
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: BahamaColors.whiteSand,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: BahamaColors.deepTeal.withOpacity(0.12),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(Icons.sailing_rounded, size: 48, color: BahamaColors.islandBlue),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'BahamaVista',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: BahamaColors.islandBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Version 1.0.0 (Build 1)',
                style: TextStyle(fontSize: 13, color: BahamaColors.islandBlue, fontWeight: FontWeight.w500),
              ),
            ),

            const SizedBox(height: 32),

            // Description
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: BahamaColors.seaGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    '🌴 Your Island Paradise Awaits',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'BahamaVista is your all-in-one travel companion for exploring the beautiful Bahamas. Book hotels, rent cars, discover experiences, and create unforgettable memories in paradise.',
                    style: TextStyle(fontSize: 14, color: BahamaColors.deepTeal.withOpacity(0.8), height: 1.6),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Stats
            BahamaCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatColumn(value: '500+', label: 'Hotels'),
                  Container(width: 1, height: 40, color: BahamaColors.greyLight),
                  _StatColumn(value: '200+', label: 'Experiences'),
                  Container(width: 1, height: 40, color: BahamaColors.greyLight),
                  _StatColumn(value: '50K+', label: 'Happy Travelers'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Features
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'What We Offer',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
              ),
            ),
            const SizedBox(height: 16),
            _FeatureTile(
              icon: Icons.hotel_rounded,
              title: 'Luxury Accommodations',
              description: 'From beachfront resorts to cozy boutique hotels',
            ),
            _FeatureTile(
              icon: Icons.directions_car_rounded,
              title: 'Car Rentals',
              description: 'Explore the islands at your own pace',
            ),
            _FeatureTile(
              icon: Icons.sailing_rounded,
              title: 'Unique Experiences',
              description: 'Swimming with pigs, snorkeling, and more',
            ),
            _FeatureTile(
              icon: Icons.flight_rounded,
              title: 'Flight Bookings',
              description: 'Easy flight search and booking',
            ),
            _FeatureTile(
              icon: Icons.verified_rounded,
              title: 'Verified Vendors',
              description: 'Trusted partners for peace of mind',
            ),
            _FeatureTile(
              icon: Icons.support_agent_rounded,
              title: '24/7 Support',
              description: 'We\'re here whenever you need us',
            ),

            const SizedBox(height: 24),

            // Social links
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Connect With Us',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SocialButton(icon: Icons.language_rounded, onTap: () {}),
                const SizedBox(width: 16),
                _SocialButton(icon: Icons.facebook_rounded, onTap: () {}),
                const SizedBox(width: 16),
                _SocialButton(icon: Icons.camera_alt_rounded, onTap: () {}),
                const SizedBox(width: 16),
                _SocialButton(icon: Icons.alternate_email_rounded, onTap: () {}),
              ],
            ),

            const SizedBox(height: 32),

            // Legal
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Legal',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
              ),
            ),
            const SizedBox(height: 16),
            _LegalTile(title: 'Terms of Service', onTap: () {}),
            _LegalTile(title: 'Privacy Policy', onTap: () {}),
            _LegalTile(title: 'Cookie Policy', onTap: () {}),
            _LegalTile(title: 'Open Source Licenses', onTap: () {}),

            const SizedBox(height: 32),

            // Footer
            Text(
              '© 2024 BahamaVista. All rights reserved.',
              style: TextStyle(fontSize: 12, color: BahamaColors.greyPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Made with ❤️ in the Bahamas',
              style: TextStyle(fontSize: 12, color: BahamaColors.islandBlue),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String value;
  final String label;

  const _StatColumn({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: BahamaColors.islandBlue)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: BahamaColors.greyPrimary)),
      ],
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureTile({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: BahamaCard(
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: BahamaColors.islandBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: BahamaColors.islandBlue, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: BahamaColors.deepTeal)),
                  const SizedBox(height: 2),
                  Text(description, style: const TextStyle(fontSize: 12, color: BahamaColors.greyPrimary)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: BahamaColors.whiteSand,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: BahamaColors.deepTeal.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: BahamaColors.islandBlue, size: 24),
      ),
    );
  }
}

class _LegalTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _LegalTile({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: BahamaColors.whiteSand,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(color: BahamaColors.deepTeal)),
                const Icon(Icons.chevron_right_rounded, color: BahamaColors.greyPrimary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

