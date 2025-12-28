import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_button.dart';
import '../../widgets/bahama_card.dart';
import '../../widgets/date_picker.dart';
import '../../utils/constants.dart';
import 'confirmation_screen.dart';

class BookingScreen extends StatefulWidget {
  final Map<String, dynamic>? hotel;

  const BookingScreen({super.key, this.hotel});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _adults = 2;
  int _children = 0;
  int _rooms = 1;
  DateTime _checkIn = DateTime.now().add(const Duration(days: 7));
  DateTime _checkOut = DateTime.now().add(const Duration(days: 10));

  late Map<String, dynamic> hotel;

  @override
  void initState() {
    super.initState();
    hotel = widget.hotel ?? DemoData.hotels[0];
  }

  @override
  Widget build(BuildContext context) {
    final nights = _checkOut.difference(_checkIn).inDays;
    final pricePerNight = hotel['price'] as int;
    final subtotal = pricePerNight * nights * _rooms;
    final taxes = (subtotal * 0.12).round();
    final total = subtotal + taxes;

    return Scaffold(
      backgroundColor: BahamaColors.offWhiteMist,
      appBar: AppBar(
        backgroundColor: BahamaColors.whiteSand,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
        title: const Text(
          'Complete Booking',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: BahamaColors.deepTeal,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hotel summary
                  BahamaCard(
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: hotel['image'] as String,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              width: 80,
                              height: 80,
                              color: BahamaColors.paleTurquoise,
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 80,
                              height: 80,
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
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 16,
                                    color: BahamaColors.warmGold,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${hotel['rating']} (${hotel['reviews']} reviews)',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: BahamaColors.greyPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Dates
                  const Text(
                    'Select Dates',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: BahamaColors.deepTeal,
                    ),
                  ),
                  const SizedBox(height: 16),
                  BahamaDatePicker(
                    checkIn: _checkIn,
                    checkOut: _checkOut,
                    onCheckInChanged: (date) {
                      setState(() {
                        _checkIn = date;
                        if (_checkOut.isBefore(date.add(const Duration(days: 1)))) {
                          _checkOut = date.add(const Duration(days: 1));
                        }
                      });
                    },
                    onCheckOutChanged: (date) {
                      setState(() => _checkOut = date);
                    },
                  ),

                  const SizedBox(height: 24),

                  // Guests
                  const Text(
                    'Guests & Rooms',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: BahamaColors.deepTeal,
                    ),
                  ),
                  const SizedBox(height: 16),
                  BahamaGuestSelector(
                    adults: _adults,
                    children: _children,
                    rooms: _rooms,
                    onAdultsChanged: (v) => setState(() => _adults = v),
                    onChildrenChanged: (v) => setState(() => _children = v),
                    onRoomsChanged: (v) => setState(() => _rooms = v),
                  ),

                  const SizedBox(height: 24),

                  // Payment method
                  const Text(
                    'Payment Method',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: BahamaColors.deepTeal,
                    ),
                  ),
                  const SizedBox(height: 16),
                  BahamaCard(
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 32,
                          decoration: BoxDecoration(
                            color: BahamaColors.deepTeal,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Center(
                            child: Text(
                              'VISA',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '•••• •••• •••• 4242',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: BahamaColors.deepTeal,
                                ),
                              ),
                              Text(
                                'Expires 12/25',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: BahamaColors.greyPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Change',
                            style: TextStyle(
                              color: BahamaColors.islandBlue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Price breakdown
                  const Text(
                    'Price Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: BahamaColors.deepTeal,
                    ),
                  ),
                  const SizedBox(height: 16),
                  BahamaCard(
                    child: Column(
                      children: [
                        _PriceRow(
                          label: '\$$pricePerNight x $nights nights${_rooms > 1 ? ' x $_rooms rooms' : ''}',
                          value: '\$$subtotal',
                        ),
                        const SizedBox(height: 12),
                        const _PriceRow(
                          label: 'Taxes & fees (12%)',
                          value: '',
                        ),
                        _PriceRow(
                          label: '',
                          value: '\$$taxes',
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(height: 1),
                        ),
                        _PriceRow(
                          label: 'Total',
                          value: '\$$total',
                          isTotal: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Cancellation policy
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: BahamaColors.islandBlue.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          color: BahamaColors.islandBlue,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Free Cancellation',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: BahamaColors.deepTeal,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Cancel before ${DateFormat('MMM d, yyyy').format(_checkIn.subtract(const Duration(days: 2)))} for a full refund.',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: BahamaColors.greyPrimary,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // Bottom bar
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: BahamaColors.whiteSand,
              boxShadow: [
                BoxShadow(
                  color: BahamaColors.deepTeal.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: BahamaButton(
                text: 'Confirm & Pay \$$total',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ConfirmationScreen(
                        hotel: hotel,
                        checkIn: _checkIn,
                        checkOut: _checkOut,
                        guests: _adults + _children,
                        rooms: _rooms,
                        total: total,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _PriceRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w400,
            color: BahamaColors.deepTeal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? BahamaColors.islandBlue : BahamaColors.deepTeal,
          ),
        ),
      ],
    );
  }
}
