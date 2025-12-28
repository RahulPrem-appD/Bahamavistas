import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_button.dart';
import 'payment_setup_screen.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  String? _selectedCountry;
  String? _selectedTravelStyle;

  final List<String> _countries = [
    'United States',
    'Canada',
    'United Kingdom',
    'Germany',
    'France',
    'Australia',
    'Other',
  ];

  final List<Map<String, dynamic>> _travelStyles = [
    {'icon': Icons.beach_access_rounded, 'label': 'Beach Lover'},
    {'icon': Icons.explore_rounded, 'label': 'Explorer'},
    {'icon': Icons.spa_rounded, 'label': 'Relaxation'},
    {'icon': Icons.nightlife_rounded, 'label': 'Nightlife'},
    {'icon': Icons.family_restroom_rounded, 'label': 'Family'},
    {'icon': Icons.favorite_rounded, 'label': 'Romantic'},
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
                        'Complete Profile',
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
                          color: BahamaColors.greyLight,
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

                        // Profile photo
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: BahamaColors.offWhiteMist,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: BahamaColors.islandBlue,
                                    width: 3,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.person_rounded,
                                  size: 60,
                                  color: BahamaColors.greySecondary,
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(
                                    gradient: BahamaColors.ctaGradient,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_rounded,
                                    size: 20,
                                    color: BahamaColors.deepTeal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Center(
                          child: Text(
                            'Add Profile Photo',
                            style: TextStyle(
                              fontSize: 14,
                              color: BahamaColors.islandBlue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Country selection
                        const Text(
                          'Where are you from?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: BahamaColors.deepTeal,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: BahamaColors.whiteSand,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: BahamaColors.deepTeal.withOpacity(0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedCountry,
                              hint: const Text(
                                'Select your country',
                                style: TextStyle(color: BahamaColors.greyPrimary),
                              ),
                              isExpanded: true,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: BahamaColors.islandBlue,
                              ),
                              items: _countries.map((country) {
                                return DropdownMenuItem(
                                  value: country,
                                  child: Text(country),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedCountry = value;
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Travel style
                        const Text(
                          'What\'s your travel style?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: BahamaColors.deepTeal,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1,
                          ),
                          itemCount: _travelStyles.length,
                          itemBuilder: (context, index) {
                            final style = _travelStyles[index];
                            final isSelected =
                                _selectedTravelStyle == style['label'];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedTravelStyle = style['label'];
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? BahamaColors.islandBlue.withOpacity(0.1)
                                      : BahamaColors.whiteSand,
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
                                                .withOpacity(0.2),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      style['icon'],
                                      size: 32,
                                      color: isSelected
                                          ? BahamaColors.islandBlue
                                          : BahamaColors.greyPrimary,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      style['label'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                        color: isSelected
                                            ? BahamaColors.islandBlue
                                            : BahamaColors.greyPrimary,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 40),

                        BahamaButton(
                          text: 'Continue',
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const PaymentSetupScreen(),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PaymentSetupScreen(),
                                ),
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

