import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_button.dart';
import '../../widgets/bahama_card.dart';
import '../../utils/constants.dart';
import 'confirmation_screen.dart';

class FlightBookingScreen extends StatefulWidget {
  final Map<String, dynamic> flight;

  const FlightBookingScreen({super.key, required this.flight});

  @override
  State<FlightBookingScreen> createState() => _FlightBookingScreenState();
}

class _FlightBookingScreenState extends State<FlightBookingScreen> {
  int passengers = 1;
  String selectedClass = 'Economy';
  bool addBaggage = false;
  bool addMeal = false;
  bool addSeat = false;

  final List<String> classes = ['Economy', 'Premium Economy', 'Business', 'First Class'];

  @override
  Widget build(BuildContext context) {
    final flight = widget.flight;
    int basePrice = flight['price'] as int;
    
    // Price adjustments based on class
    if (selectedClass == 'Premium Economy') basePrice = (basePrice * 1.5).round();
    if (selectedClass == 'Business') basePrice = (basePrice * 2.5).round();
    if (selectedClass == 'First Class') basePrice = (basePrice * 4).round();
    
    int total = basePrice * passengers;
    if (addBaggage) total += 35 * passengers;
    if (addMeal) total += 25 * passengers;
    if (addSeat) total += 15 * passengers;

    return Scaffold(
      backgroundColor: BahamaColors.offWhiteMist,
      appBar: AppBar(
        backgroundColor: BahamaColors.whiteSand,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded, color: BahamaColors.deepTeal),
        ),
        title: const Text(
          'Book Flight',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: BahamaColors.deepTeal),
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
                  // Flight summary card
                  BahamaCard(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  flight['logo'] as String,
                                  style: const TextStyle(fontSize: 24),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      flight['airline'] as String,
                                      style: const TextStyle(fontWeight: FontWeight.w600, color: BahamaColors.deepTeal),
                                    ),
                                    Text(
                                      flight['aircraft'] ?? 'Aircraft TBD',
                                      style: const TextStyle(fontSize: 12, color: BahamaColors.greyPrimary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (flight['isDirect'] == true)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: BahamaColors.islandBlue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Direct',
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: BahamaColors.islandBlue),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    flight['departure'] as String,
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
                                  ),
                                  Text(
                                    flight['fromCity'] ?? flight['from'],
                                    style: const TextStyle(fontSize: 13, color: BahamaColors.greyPrimary),
                                  ),
                                  Text(
                                    flight['from'] as String,
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: BahamaColors.islandBlue),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    flight['duration'] as String,
                                    style: const TextStyle(fontSize: 12, color: BahamaColors.greyPrimary),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Container(width: 10, height: 10, decoration: const BoxDecoration(color: BahamaColors.islandBlue, shape: BoxShape.circle)),
                                      Expanded(child: Container(height: 2, color: BahamaColors.greyLight)),
                                      const Icon(Icons.flight_rounded, size: 20, color: BahamaColors.islandBlue),
                                      Expanded(child: Container(height: 2, color: BahamaColors.greyLight)),
                                      Container(width: 10, height: 10, decoration: const BoxDecoration(color: BahamaColors.islandBlue, shape: BoxShape.circle)),
                                    ],
                                  ),
                                  if (flight['stops'] != null) ...[
                                    const SizedBox(height: 4),
                                    Text(flight['stops'] as String, style: const TextStyle(fontSize: 10, color: BahamaColors.greyPrimary)),
                                  ],
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    flight['arrival'] as String,
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
                                  ),
                                  Text(
                                    flight['toCity'] ?? flight['to'],
                                    style: const TextStyle(fontSize: 13, color: BahamaColors.greyPrimary),
                                  ),
                                  Text(
                                    flight['to'] as String,
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: BahamaColors.islandBlue),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Passengers
                  const Text('Passengers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal)),
                  const SizedBox(height: 16),
                  BahamaCard(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Adults', style: TextStyle(fontWeight: FontWeight.w600, color: BahamaColors.deepTeal)),
                            Text('12+ years', style: TextStyle(fontSize: 12, color: BahamaColors.greyPrimary)),
                          ],
                        ),
                        Row(
                          children: [
                            _CounterButton(icon: Icons.remove, onTap: passengers > 1 ? () => setState(() => passengers--) : null),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text('$passengers', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal)),
                            ),
                            _CounterButton(icon: Icons.add, onTap: passengers < 9 ? () => setState(() => passengers++) : null),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Class selection
                  const Text('Cabin Class', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal)),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: classes.map((cls) {
                      final isSelected = cls == selectedClass;
                      return GestureDetector(
                        onTap: () => setState(() => selectedClass = cls),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            gradient: isSelected ? BahamaColors.ctaGradient : null,
                            color: isSelected ? null : BahamaColors.whiteSand,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: isSelected ? Colors.transparent : BahamaColors.greyLight),
                          ),
                          child: Text(
                            cls,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              color: BahamaColors.deepTeal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Add-ons
                  const Text('Extras', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal)),
                  const SizedBox(height: 16),
                  _AddOnTile(
                    icon: Icons.luggage_outlined,
                    title: 'Extra Checked Bag',
                    subtitle: '23kg checked baggage',
                    price: '\$35/person',
                    isSelected: addBaggage,
                    onChanged: (v) => setState(() => addBaggage = v),
                  ),
                  const SizedBox(height: 12),
                  _AddOnTile(
                    icon: Icons.restaurant_outlined,
                    title: 'In-Flight Meal',
                    subtitle: 'Premium meal selection',
                    price: '\$25/person',
                    isSelected: addMeal,
                    onChanged: (v) => setState(() => addMeal = v),
                  ),
                  const SizedBox(height: 12),
                  _AddOnTile(
                    icon: Icons.airline_seat_recline_extra_outlined,
                    title: 'Seat Selection',
                    subtitle: 'Choose your preferred seat',
                    price: '\$15/person',
                    isSelected: addSeat,
                    onChanged: (v) => setState(() => addSeat = v),
                  ),

                  const SizedBox(height: 24),

                  // Flight amenities
                  if (flight['amenities'] != null) ...[
                    const Text('Included', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal)),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: (flight['amenities'] as List<dynamic>).map((a) => _AmenityChip(text: a as String)).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Price breakdown
                  const Text('Price Breakdown', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal)),
                  const SizedBox(height: 16),
                  BahamaCard(
                    child: Column(
                      children: [
                        _PriceRow(label: '$selectedClass x $passengers', value: '\$${basePrice * passengers}'),
                        if (addBaggage) _PriceRow(label: 'Extra Baggage x $passengers', value: '\$${35 * passengers}'),
                        if (addMeal) _PriceRow(label: 'In-Flight Meal x $passengers', value: '\$${25 * passengers}'),
                        if (addSeat) _PriceRow(label: 'Seat Selection x $passengers', value: '\$${15 * passengers}'),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1)),
                        _PriceRow(label: 'Total', value: '\$$total', isTotal: true),
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
              boxShadow: [BoxShadow(color: BahamaColors.deepTeal.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -5))],
            ),
            child: SafeArea(
              top: false,
              child: BahamaButton(
                text: 'Book Flight • \$$total',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ConfirmationScreen(
                        hotel: {
                          'name': '${flight['from']} → ${flight['to']}',
                          'location': flight['airline'],
                          'image': AppImages.airplane,
                        },
                        checkIn: DateTime.now().add(const Duration(days: 7)),
                        checkOut: DateTime.now().add(const Duration(days: 7)),
                        guests: passengers,
                        rooms: 1,
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

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _CounterButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isEnabled ? BahamaColors.islandBlue.withOpacity(0.1) : BahamaColors.greyLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: isEnabled ? BahamaColors.islandBlue : BahamaColors.greyPrimary, size: 20),
      ),
    );
  }
}

class _AddOnTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String price;
  final bool isSelected;
  final ValueChanged<bool> onChanged;

  const _AddOnTile({required this.icon, required this.title, required this.subtitle, required this.price, required this.isSelected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? BahamaColors.islandBlue.withOpacity(0.05) : BahamaColors.whiteSand,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isSelected ? BahamaColors.islandBlue : BahamaColors.greyLight),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: BahamaColors.offWhiteMist, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: BahamaColors.islandBlue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: BahamaColors.deepTeal)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: BahamaColors.greyPrimary)),
              ],
            ),
          ),
          Text(price, style: const TextStyle(fontWeight: FontWeight.w600, color: BahamaColors.islandBlue)),
          const SizedBox(width: 8),
          Switch(value: isSelected, onChanged: onChanged, activeColor: BahamaColors.islandBlue),
        ],
      ),
    );
  }
}

class _AmenityChip extends StatelessWidget {
  final String text;

  const _AmenityChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: BahamaColors.offWhiteMist, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_rounded, size: 16, color: BahamaColors.islandBlue),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontSize: 13, color: BahamaColors.deepTeal)),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _PriceRow({required this.label, required this.value, this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: isTotal ? 16 : 14, fontWeight: isTotal ? FontWeight.bold : FontWeight.w400, color: BahamaColors.deepTeal)),
          Text(value, style: TextStyle(fontSize: isTotal ? 20 : 14, fontWeight: isTotal ? FontWeight.bold : FontWeight.w500, color: isTotal ? BahamaColors.islandBlue : BahamaColors.deepTeal)),
        ],
      ),
    );
  }
}

