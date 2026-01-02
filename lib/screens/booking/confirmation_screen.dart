import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_button.dart';
import '../../widgets/bahama_card.dart';
import '../../utils/constants.dart';
import '../home/main_navigation.dart';

class ConfirmationScreen extends StatefulWidget {
  final Map<String, dynamic>? hotel;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final int guests;
  final int rooms;
  final int total;

  const ConfirmationScreen({
    super.key,
    this.hotel,
    this.checkIn,
    this.checkOut,
    this.guests = 2,
    this.rooms = 1,
    this.total = 1512,
  });

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  late Map<String, dynamic> hotel;
  late DateTime checkIn;
  late DateTime checkOut;

  @override
  void initState() {
    super.initState();
    hotel = widget.hotel ?? DemoData.hotels[0];
    checkIn = widget.checkIn ?? DateTime.now().add(const Duration(days: 7));
    checkOut = widget.checkOut ?? DateTime.now().add(const Duration(days: 10));

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('MMM d, yyyy');
    final confirmationCode = 'BV-${DateTime.now().year}-${(10000 + DateTime.now().millisecond * 7).toString().substring(0, 5)}';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: BahamaColors.seaGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Success animation
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: BahamaColors.whiteSand,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: BahamaColors.islandBlue.withOpacity(0.3),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.check_circle_rounded,
                            size: 80,
                            color: BahamaColors.islandBlue,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 32),

                // Success message
                AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Column(
                        children: [
                          const Text(
                            'Booking Confirmed!',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: BahamaColors.deepTeal,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Your island getaway is booked.\nGet ready for paradise! 🌴',
                            style: TextStyle(
                              fontSize: 16,
                              color: BahamaColors.islandBlueDark,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),

                // Booking details card
                AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: BahamaCard(
                        child: Column(
                          children: [
                            // Confirmation number
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: BahamaColors.offWhiteMist,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.confirmation_number_outlined,
                                    color: BahamaColors.islandBlue,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Confirmation #$confirmationCode',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: BahamaColors.deepTeal,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Hotel info
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl: hotel['image'] as String,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      width: 60,
                                      height: 60,
                                      color: BahamaColors.paleTurquoise,
                                    ),
                                    errorWidget: (context, url, error) => Container(
                                      width: 60,
                                      height: 60,
                                      color: BahamaColors.paleTurquoise,
                                      child: const Icon(Icons.hotel, color: BahamaColors.islandBlue),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        hotel['name'] as String,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: BahamaColors.deepTeal,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${hotel['location']}, Bahamas',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: BahamaColors.greyPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),
                            const Divider(),
                            const SizedBox(height: 16),

                            // Dates
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Check-in',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: BahamaColors.greyPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        formatter.format(checkIn),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: BahamaColors.deepTeal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_rounded,
                                  color: BahamaColors.islandBlue,
                                  size: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'Check-out',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: BahamaColors.greyPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        formatter.format(checkOut),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: BahamaColors.deepTeal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Guests
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Guests',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: BahamaColors.greyPrimary,
                                  ),
                                ),
                                Text(
                                  '${widget.guests} Guest${widget.guests > 1 ? 's' : ''}, ${widget.rooms} Room${widget.rooms > 1 ? 's' : ''}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: BahamaColors.deepTeal,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            // Total
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total Paid',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: BahamaColors.greyPrimary,
                                  ),
                                ),
                                Text(
                                  '\$${widget.total}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: BahamaColors.islandBlue,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),

                // Actions
                AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Column(
                        children: [
                          BahamaButton(
                            text: 'View My Trips',
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.share_outlined,
                                  color: BahamaColors.islandBlue,
                                  size: 20,
                                ),
                                label: const Text(
                                  'Share',
                                  style: TextStyle(
                                    color: BahamaColors.islandBlue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 24),
                              TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.calendar_today_outlined,
                                  color: BahamaColors.islandBlue,
                                  size: 20,
                                ),
                                label: const Text(
                                  'Add to Calendar',
                                  style: TextStyle(
                                    color: BahamaColors.islandBlue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
