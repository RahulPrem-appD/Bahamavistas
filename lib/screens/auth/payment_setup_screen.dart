import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_button.dart';
import '../../widgets/bahama_text_field.dart';
import '../home/main_navigation.dart';

class PaymentSetupScreen extends StatefulWidget {
  const PaymentSetupScreen({super.key});

  @override
  State<PaymentSetupScreen> createState() => _PaymentSetupScreenState();
}

class _PaymentSetupScreenState extends State<PaymentSetupScreen> {
  int _selectedPaymentMethod = 0;

  final List<Map<String, dynamic>> _paymentMethods = [
    {'icon': Icons.credit_card_rounded, 'label': 'Credit/Debit Card'},
    {'icon': Icons.account_balance_rounded, 'label': 'Bank Account'},
    {'icon': Icons.account_balance_wallet_rounded, 'label': 'Digital Wallet'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: BahamaColors.seaGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: BahamaColors.deepTeal,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Payment Method',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: BahamaColors.deepTeal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              // Progress indicator
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: BahamaColors.islandBlue,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: BahamaColors.islandBlue,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),

                        // Header
                        const Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.payment_rounded,
                                size: 64,
                                color: BahamaColors.islandBlue,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Add Payment Method',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: BahamaColors.deepTeal,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Securely save your payment details\nfor faster checkout',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: BahamaColors.greyPrimary,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Payment method selection
                        const Text(
                          'Select Payment Type',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: BahamaColors.deepTeal,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...List.generate(_paymentMethods.length, (index) {
                          final method = _paymentMethods[index];
                          final isSelected = _selectedPaymentMethod == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPaymentMethod = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: BahamaColors.whiteSand,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected
                                      ? BahamaColors.islandBlue
                                      : BahamaColors.greyLight,
                                  width: isSelected ? 2 : 1,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: BahamaColors.islandBlue
                                              .withOpacity(0.15),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? BahamaColors.islandBlue
                                              .withOpacity(0.1)
                                          : BahamaColors.offWhiteMist,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      method['icon'],
                                      color: isSelected
                                          ? BahamaColors.islandBlue
                                          : BahamaColors.greyPrimary,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      method['label'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                        color: BahamaColors.deepTeal,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected
                                            ? BahamaColors.islandBlue
                                            : BahamaColors.greySecondary,
                                        width: 2,
                                      ),
                                      color: isSelected
                                          ? BahamaColors.islandBlue
                                          : Colors.transparent,
                                    ),
                                    child: isSelected
                                        ? const Icon(
                                            Icons.check,
                                            size: 16,
                                            color: BahamaColors.whiteSand,
                                          )
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),

                        const SizedBox(height: 24),

                        // Card details form
                        if (_selectedPaymentMethod == 0) ...[
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: BahamaColors.whiteSand,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      BahamaColors.deepTeal.withOpacity(0.06),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Column(
                              children: [
                                BahamaTextField(
                                  labelText: 'Card Number',
                                  hintText: '1234 5678 9012 3456',
                                  prefixIcon: Icons.credit_card_rounded,
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(height: 20),
                                BahamaTextField(
                                  labelText: 'Cardholder Name',
                                  hintText: 'Name on card',
                                  prefixIcon: Icons.person_outline,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: BahamaTextField(
                                        labelText: 'Expiry Date',
                                        hintText: 'MM/YY',
                                        keyboardType: TextInputType.datetime,
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: BahamaTextField(
                                        labelText: 'CVV',
                                        hintText: '123',
                                        keyboardType: TextInputType.number,
                                        obscureText: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],

                        const SizedBox(height: 32),

                        // Security notice
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: BahamaColors.islandBlue.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.lock_rounded,
                                color: BahamaColors.islandBlue,
                                size: 20,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Your payment information is encrypted and secure',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: BahamaColors.deepTeal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        BahamaButton(
                          text: 'Save & Continue',
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const MainNavigation(),
                              ),
                              (route) => false,
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const MainNavigation(),
                                ),
                                (route) => false,
                              );
                            },
                            child: const Text(
                              'Skip for now',
                              style: TextStyle(
                                color: BahamaColors.greyPrimary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

