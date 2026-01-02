import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_card.dart';
import '../../utils/constants.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  List<Map<String, dynamic>> paymentMethods = List.from(DemoData.paymentMethods);

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
          'Payment Methods',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: BahamaColors.deepTeal),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                // Cards section
                const Text(
                  'Your Cards',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
                ),
                const SizedBox(height: 16),
                
                ...paymentMethods.asMap().entries.map((entry) {
                  final index = entry.key;
                  final card = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _PaymentCard(
                      type: card['type'] as String,
                      last4: card['last4'] as String,
                      expiry: card['expiry'] as String,
                      holder: card['holder'] as String,
                      isDefault: card['isDefault'] as bool,
                      onSetDefault: () {
                        setState(() {
                          for (var c in paymentMethods) {
                            c['isDefault'] = false;
                          }
                          paymentMethods[index]['isDefault'] = true;
                        });
                      },
                      onDelete: () => _showDeleteConfirmation(context, index),
                    ),
                  );
                }),

                const SizedBox(height: 24),

                // Add new card
                GestureDetector(
                  onTap: () => _showAddCardSheet(context),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: BahamaColors.whiteSand,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: BahamaColors.islandBlue, style: BorderStyle.solid, width: 2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: BahamaColors.islandBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.add_rounded, color: BahamaColors.islandBlue, size: 28),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Add New Card',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: BahamaColors.islandBlue),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Other payment methods
                const Text(
                  'Other Payment Methods',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
                ),
                const SizedBox(height: 16),
                _OtherPaymentTile(
                  icon: Icons.apple,
                  title: 'Apple Pay',
                  subtitle: 'Pay with Face ID or Touch ID',
                  isConnected: true,
                ),
                const SizedBox(height: 12),
                _OtherPaymentTile(
                  icon: Icons.payment_rounded,
                  title: 'PayPal',
                  subtitle: 'Connect your PayPal account',
                  isConnected: false,
                ),
                const SizedBox(height: 12),
                _OtherPaymentTile(
                  icon: Icons.g_mobiledata_rounded,
                  title: 'Google Pay',
                  subtitle: 'Connect your Google Pay',
                  isConnected: false,
                ),

                const SizedBox(height: 32),

                // Security note
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: BahamaColors.islandBlue.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.lock_outline_rounded, color: BahamaColors.islandBlue),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Secure Payments',
                              style: TextStyle(fontWeight: FontWeight.w600, color: BahamaColors.deepTeal),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'All your payment information is encrypted and securely stored.',
                              style: TextStyle(fontSize: 13, color: BahamaColors.greyPrimary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Remove Card?'),
        content: const Text('This card will be removed from your payment methods.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              setState(() => paymentMethods.removeAt(index));
              Navigator.pop(context);
            },
            child: const Text('Remove', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showAddCardSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: BahamaColors.whiteSand,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(width: 40, height: 4, decoration: BoxDecoration(color: BahamaColors.greyLight, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 24),
            const Text('Add New Card', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _FormField(label: 'Card Number', hint: '1234 5678 9012 3456', icon: Icons.credit_card),
                    const SizedBox(height: 20),
                    _FormField(label: 'Cardholder Name', hint: 'Name on card', icon: Icons.person_outline),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: _FormField(label: 'Expiry', hint: 'MM/YY', icon: Icons.calendar_today_outlined)),
                        const SizedBox(width: 16),
                        Expanded(child: _FormField(label: 'CVV', hint: '123', icon: Icons.lock_outline)),
                      ],
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
                        child: const Text('Add Card', style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final String type;
  final String last4;
  final String expiry;
  final String holder;
  final bool isDefault;
  final VoidCallback onSetDefault;
  final VoidCallback onDelete;

  const _PaymentCard({
    required this.type,
    required this.last4,
    required this.expiry,
    required this.holder,
    required this.isDefault,
    required this.onSetDefault,
    required this.onDelete,
  });

  Color get _cardColor {
    switch (type) {
      case 'visa':
        return const Color(0xFF1A1F71);
      case 'mastercard':
        return const Color(0xFFEB001B);
      case 'amex':
        return const Color(0xFF006FCF);
      default:
        return BahamaColors.deepTeal;
    }
  }

  String get _cardLogo {
    switch (type) {
      case 'visa':
        return 'VISA';
      case 'mastercard':
        return 'MC';
      case 'amex':
        return 'AMEX';
      default:
        return 'CARD';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_cardColor, _cardColor.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _cardColor.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _cardLogo,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Row(
                children: [
                  if (isDefault)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Default',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  const SizedBox(width: 8),
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    itemBuilder: (context) => [
                      if (!isDefault)
                        PopupMenuItem(
                          onTap: onSetDefault,
                          child: const Row(
                            children: [
                              Icon(Icons.check_circle_outline, size: 18),
                              SizedBox(width: 8),
                              Text('Set as Default'),
                            ],
                          ),
                        ),
                      PopupMenuItem(
                        onTap: onDelete,
                        child: const Row(
                          children: [
                            Icon(Icons.delete_outline, size: 18, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Remove', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            '•••• •••• •••• $last4',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white, letterSpacing: 2),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Card Holder', style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.7))),
                  Text(holder, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Expires', style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.7))),
                  Text(expiry, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OtherPaymentTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isConnected;

  const _OtherPaymentTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    return BahamaCard(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: BahamaColors.offWhiteMist,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: BahamaColors.deepTeal, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: BahamaColors.deepTeal)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: BahamaColors.greyPrimary)),
              ],
            ),
          ),
          if (isConnected)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: BahamaColors.islandBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('Connected', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: BahamaColors.islandBlue)),
            )
          else
            TextButton(
              onPressed: () {},
              child: const Text('Connect', style: TextStyle(color: BahamaColors.islandBlue, fontWeight: FontWeight.w600)),
            ),
        ],
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;

  const _FormField({required this.label, required this.hint, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: BahamaColors.deepTeal)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: BahamaColors.greyPrimary),
            prefixIcon: Icon(icon, color: BahamaColors.islandBlue),
            filled: true,
            fillColor: BahamaColors.offWhiteMist,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: BahamaColors.islandBlue),
            ),
          ),
        ),
      ],
    );
  }
}

