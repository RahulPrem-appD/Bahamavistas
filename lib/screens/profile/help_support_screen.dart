import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../utils/constants.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  int? _expandedIndex;

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
          'Help & Support',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: BahamaColors.deepTeal),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick actions
            const Text(
              'Get Help',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.chat_bubble_outline_rounded,
                    label: 'Live Chat',
                    sublabel: 'Available 24/7',
                    color: BahamaColors.islandBlue,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.phone_outlined,
                    label: 'Call Us',
                    sublabel: '+1 (242) 555-0123',
                    color: BahamaColors.warmGold,
                    onTap: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    sublabel: 'support@bahamavista.com',
                    color: BahamaColors.deepTeal,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _QuickActionCard(
                    icon: Icons.location_on_outlined,
                    label: 'Locations',
                    sublabel: 'Find nearest office',
                    color: const Color(0xFF5C6BC0),
                    onTap: () {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // FAQs
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
            ),
            const SizedBox(height: 16),
            ...DemoData.faqs.asMap().entries.map((entry) {
              final index = entry.key;
              final faq = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _FAQItem(
                  question: faq['question'] as String,
                  answer: faq['answer'] as String,
                  isExpanded: _expandedIndex == index,
                  onTap: () {
                    setState(() {
                      _expandedIndex = _expandedIndex == index ? null : index;
                    });
                  },
                ),
              );
            }),

            const SizedBox(height: 32),

            // Help topics
            const Text(
              'Browse Help Topics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
            ),
            const SizedBox(height: 16),
            _HelpTopicTile(icon: Icons.calendar_today_outlined, title: 'Booking & Reservations', onTap: () {}),
            _HelpTopicTile(icon: Icons.payment_outlined, title: 'Payments & Refunds', onTap: () {}),
            _HelpTopicTile(icon: Icons.person_outline, title: 'Account & Profile', onTap: () {}),
            _HelpTopicTile(icon: Icons.star_outline, title: 'Rewards & Points', onTap: () {}),
            _HelpTopicTile(icon: Icons.security_outlined, title: 'Safety & Security', onTap: () {}),
            _HelpTopicTile(icon: Icons.policy_outlined, title: 'Terms & Policies', onTap: () {}),

            const SizedBox(height: 32),

            // Feedback
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [BahamaColors.islandBlue.withOpacity(0.1), BahamaColors.paleTurquoise.withOpacity(0.3)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(Icons.feedback_outlined, size: 40, color: BahamaColors.islandBlue),
                  const SizedBox(height: 12),
                  const Text(
                    'Share Your Feedback',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Help us improve BahamaVista by sharing your thoughts and suggestions.',
                    style: TextStyle(fontSize: 14, color: BahamaColors.greyPrimary, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _showFeedbackSheet(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: BahamaColors.islandBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Give Feedback', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showFeedbackSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: BahamaColors.whiteSand,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(width: 40, height: 4, decoration: BoxDecoration(color: BahamaColors.greyLight, borderRadius: BorderRadius.circular(2))),
              ),
              const SizedBox(height: 24),
              const Center(
                child: Text('Share Feedback', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal)),
              ),
              const SizedBox(height: 24),
              const Text('How was your experience?', style: TextStyle(fontWeight: FontWeight.w600, color: BahamaColors.deepTeal)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _EmojiButton(emoji: '😞', label: 'Poor'),
                  _EmojiButton(emoji: '😐', label: 'Okay'),
                  _EmojiButton(emoji: '🙂', label: 'Good'),
                  _EmojiButton(emoji: '😊', label: 'Great'),
                  _EmojiButton(emoji: '🤩', label: 'Amazing'),
                ],
              ),
              const SizedBox(height: 24),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Tell us more about your experience...',
                  hintStyle: const TextStyle(color: BahamaColors.greyPrimary),
                  filled: true,
                  fillColor: BahamaColors.offWhiteMist,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: BahamaColors.islandBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Submit Feedback', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String sublabel;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.sublabel,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: BahamaColors.whiteSand,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: BahamaColors.deepTeal.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 16),
            Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: BahamaColors.deepTeal)),
            const SizedBox(height: 4),
            Text(sublabel, style: const TextStyle(fontSize: 11, color: BahamaColors.greyPrimary)),
          ],
        ),
      ),
    );
  }
}

class _FAQItem extends StatelessWidget {
  final String question;
  final String answer;
  final bool isExpanded;
  final VoidCallback onTap;

  const _FAQItem({
    required this.question,
    required this.answer,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: BahamaColors.whiteSand,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isExpanded ? BahamaColors.islandBlue : Colors.transparent),
          boxShadow: [
            BoxShadow(
              color: BahamaColors.deepTeal.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    question,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isExpanded ? BahamaColors.islandBlue : BahamaColors.deepTeal,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: isExpanded ? BahamaColors.islandBlue : BahamaColors.greyPrimary,
                  ),
                ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 12),
              Text(
                answer,
                style: TextStyle(fontSize: 14, color: BahamaColors.greyPrimary, height: 1.5),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _HelpTopicTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _HelpTopicTile({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: BahamaColors.whiteSand,
        borderRadius: BorderRadius.circular(16),
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
                    color: BahamaColors.offWhiteMist,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: BahamaColors.islandBlue, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, color: BahamaColors.deepTeal)),
                ),
                const Icon(Icons.chevron_right_rounded, color: BahamaColors.greyPrimary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmojiButton extends StatelessWidget {
  final String emoji;
  final String label;

  const _EmojiButton({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: BahamaColors.offWhiteMist,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(child: Text(emoji, style: const TextStyle(fontSize: 24))),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11, color: BahamaColors.greyPrimary)),
      ],
    );
  }
}

