import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _darkMode = false;
  String _currency = 'USD';
  String _language = 'English';

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
          'Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: BahamaColors.deepTeal,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notifications Section
            _SectionHeader(title: 'Notifications'),
            const SizedBox(height: 12),
            _SettingsCard(
              children: [
                _SwitchTile(
                  icon: Icons.notifications_outlined,
                  title: 'Push Notifications',
                  subtitle: 'Receive booking updates and offers',
                  value: _pushNotifications,
                  onChanged: (value) => setState(() => _pushNotifications = value),
                ),
                const Divider(height: 1),
                _SwitchTile(
                  icon: Icons.email_outlined,
                  title: 'Email Notifications',
                  subtitle: 'Receive emails about your trips',
                  value: _emailNotifications,
                  onChanged: (value) => setState(() => _emailNotifications = value),
                ),
                const Divider(height: 1),
                _SwitchTile(
                  icon: Icons.sms_outlined,
                  title: 'SMS Notifications',
                  subtitle: 'Receive text messages',
                  value: _smsNotifications,
                  onChanged: (value) => setState(() => _smsNotifications = value),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Preferences Section
            _SectionHeader(title: 'Preferences'),
            const SizedBox(height: 12),
            _SettingsCard(
              children: [
                _SelectTile(
                  icon: Icons.attach_money_rounded,
                  title: 'Currency',
                  value: _currency,
                  onTap: () => _showCurrencyPicker(),
                ),
                const Divider(height: 1),
                _SelectTile(
                  icon: Icons.language_rounded,
                  title: 'Language',
                  value: _language,
                  onTap: () => _showLanguagePicker(),
                ),
                const Divider(height: 1),
                _SwitchTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  subtitle: 'Switch to dark theme',
                  value: _darkMode,
                  onChanged: (value) => setState(() => _darkMode = value),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Account Section
            _SectionHeader(title: 'Account'),
            const SizedBox(height: 12),
            _SettingsCard(
              children: [
                _ActionTile(
                  icon: Icons.lock_outline_rounded,
                  title: 'Change Password',
                  onTap: () {},
                ),
                const Divider(height: 1),
                _ActionTile(
                  icon: Icons.security_rounded,
                  title: 'Privacy Settings',
                  onTap: () {},
                ),
                const Divider(height: 1),
                _ActionTile(
                  icon: Icons.download_outlined,
                  title: 'Download My Data',
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Support Section
            _SectionHeader(title: 'Support'),
            const SizedBox(height: 12),
            _SettingsCard(
              children: [
                _ActionTile(
                  icon: Icons.help_outline_rounded,
                  title: 'Help Center',
                  onTap: () {},
                ),
                const Divider(height: 1),
                _ActionTile(
                  icon: Icons.chat_bubble_outline_rounded,
                  title: 'Contact Support',
                  onTap: () {},
                ),
                const Divider(height: 1),
                _ActionTile(
                  icon: Icons.bug_report_outlined,
                  title: 'Report a Bug',
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Legal Section
            _SectionHeader(title: 'Legal'),
            const SizedBox(height: 12),
            _SettingsCard(
              children: [
                _ActionTile(
                  icon: Icons.description_outlined,
                  title: 'Terms of Service',
                  onTap: () {},
                ),
                const Divider(height: 1),
                _ActionTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  onTap: () {},
                ),
                const Divider(height: 1),
                _ActionTile(
                  icon: Icons.gavel_rounded,
                  title: 'Licenses',
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Danger Zone
            _SettingsCard(
              children: [
                _ActionTile(
                  icon: Icons.delete_outline_rounded,
                  title: 'Delete Account',
                  isDestructive: true,
                  onTap: () => _showDeleteConfirmation(),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // App version
            Center(
              child: Column(
                children: [
                  const Text(
                    'BahamaVista',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: BahamaColors.deepTeal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Version 1.0.0 (Build 1)',
                    style: TextStyle(
                      fontSize: 12,
                      color: BahamaColors.greyPrimary,
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

  void _showCurrencyPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: BahamaColors.whiteSand,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _PickerSheet(
        title: 'Select Currency',
        options: const ['USD', 'EUR', 'GBP', 'CAD', 'AUD'],
        selected: _currency,
        onSelect: (value) {
          setState(() => _currency = value);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: BahamaColors.whiteSand,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _PickerSheet(
        title: 'Select Language',
        options: const ['English', 'Spanish', 'French', 'German', 'Portuguese'],
        selected: _language,
        onSelect: (value) {
          setState(() => _language = value);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete Account?'),
        content: const Text(
          'This action cannot be undone. All your data will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: BahamaColors.greyPrimary,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(children: children),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: BahamaColors.deepTeal,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: BahamaColors.greyPrimary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: BahamaColors.islandBlue,
          ),
        ],
      ),
    );
  }
}

class _SelectTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const _SelectTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
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
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: BahamaColors.deepTeal,
                  ),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: BahamaColors.greyPrimary,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right_rounded,
                color: BahamaColors.greySecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
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
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: isDestructive ? Colors.red : BahamaColors.islandBlue,
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
                    color: isDestructive ? Colors.red : BahamaColors.deepTeal,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: isDestructive ? Colors.red.withOpacity(0.5) : BahamaColors.greySecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PickerSheet extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelect;

  const _PickerSheet({
    required this.title,
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: BahamaColors.greySecondary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: BahamaColors.deepTeal,
          ),
        ),
        const SizedBox(height: 16),
        ...options.map((option) => ListTile(
              title: Text(option),
              trailing: option == selected
                  ? const Icon(Icons.check_rounded, color: BahamaColors.islandBlue)
                  : null,
              onTap: () => onSelect(option),
            )),
        const SizedBox(height: 24),
      ],
    );
  }
}

