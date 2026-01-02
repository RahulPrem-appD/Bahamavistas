import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_button.dart';
import '../../widgets/bahama_card.dart';
import 'confirmation_screen.dart';

class CarDetailScreen extends StatefulWidget {
  final Map<String, dynamic> car;

  const CarDetailScreen({super.key, required this.car});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  bool isFavorite = false;
  DateTime pickupDate = DateTime.now().add(const Duration(days: 3));
  DateTime returnDate = DateTime.now().add(const Duration(days: 6));
  String pickupLocation = 'Nassau International Airport';
  bool addInsurance = true;
  bool addGPS = false;

  @override
  Widget build(BuildContext context) {
    final car = widget.car;
    final days = returnDate.difference(pickupDate).inDays;
    final pricePerDay = car['price'] as int;
    int total = pricePerDay * days;
    if (addInsurance) total += 15 * days;
    if (addGPS) total += 10 * days;

    return Scaffold(
      body: Stack(
        children: [
          // Hero image
          SizedBox(
            height: 320,
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: car['image'] as String,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 320,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: BahamaColors.greyLight,
                    highlightColor: BahamaColors.offWhiteMist,
                    child: Container(color: BahamaColors.greyLight),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: BahamaColors.paleTurquoise,
                    child: const Icon(Icons.directions_car, size: 64, color: BahamaColors.islandBlue),
                  ),
                ),
                // Gradient overlay
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 120,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Top bar
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _CircleButton(
                              icon: Icons.arrow_back_ios_rounded,
                              onTap: () => Navigator.pop(context),
                            ),
                            Row(
                              children: [
                                _CircleButton(
                                  icon: Icons.share_outlined,
                                  onTap: () {},
                                ),
                                const SizedBox(width: 12),
                                _CircleButton(
                                  icon: isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
                                  iconColor: isFavorite ? Colors.red : null,
                                  onTap: () => setState(() => isFavorite = !isFavorite),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 190),

                    // Main content
                    Container(
                      decoration: const BoxDecoration(
                        color: BahamaColors.whiteSand,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badges
                            Row(
                              children: [
                                if (car['isPopular'] == true)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      gradient: BahamaColors.ctaGradient,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(Icons.trending_up_rounded, size: 14, color: BahamaColors.deepTeal),
                                        SizedBox(width: 4),
                                        Text('Popular', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: BahamaColors.deepTeal)),
                                      ],
                                    ),
                                  ),
                                if (car['isPopular'] == true) const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: BahamaColors.offWhiteMist,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    car['type'] as String,
                                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: BahamaColors.deepTeal),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Title & price
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        car['name'] as String,
                                        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${car['transmission']} • ${car['seats']} seats',
                                        style: const TextStyle(fontSize: 14, color: BahamaColors.greyPrimary),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\$$pricePerDay',
                                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: BahamaColors.islandBlue),
                                    ),
                                    const Text('/day', style: TextStyle(fontSize: 14, color: BahamaColors.greyPrimary)),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            // Description
                            const Text('About', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal)),
                            const SizedBox(height: 12),
                            Text(
                              car['description'] as String? ??
                                  'Experience the freedom of the open road in this well-maintained vehicle. Perfect for exploring the beautiful Bahamas at your own pace.',
                              style: const TextStyle(fontSize: 14, color: BahamaColors.greyPrimary, height: 1.6),
                            ),

                            const SizedBox(height: 24),

                            // Specs
                            const Text('Specifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal)),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(child: _SpecCard(icon: Icons.person_outline, label: '${car['seats']} Seats')),
                                const SizedBox(width: 12),
                                Expanded(child: _SpecCard(icon: Icons.settings_outlined, label: car['transmission'] as String)),
                                const SizedBox(width: 12),
                                Expanded(child: _SpecCard(icon: Icons.local_gas_station_outlined, label: car['fuelType'] ?? 'Gasoline')),
                              ],
                            ),

                            const SizedBox(height: 24),

                            // Features
                            const Text('Features', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal)),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                ...((car['features'] as List<dynamic>).map((f) => _FeatureChip(text: f as String))),
                              ],
                            ),

                            const SizedBox(height: 24),

                            // Rental dates
                            const Text('Rental Period', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal)),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: _DateCard(
                                    label: 'Pick-up',
                                    date: pickupDate,
                                    onTap: () => _selectDate(context, true),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Icon(Icons.arrow_forward_rounded, color: BahamaColors.islandBlue),
                                ),
                                Expanded(
                                  child: _DateCard(
                                    label: 'Return',
                                    date: returnDate,
                                    onTap: () => _selectDate(context, false),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            // Pickup location
                            const Text('Pick-up Location', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal)),
                            const SizedBox(height: 16),
                            BahamaCard(
                              onTap: () => _showLocationPicker(context),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: BahamaColors.islandBlue.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(Icons.location_on_rounded, color: BahamaColors.islandBlue),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Location', style: TextStyle(fontSize: 12, color: BahamaColors.greyPrimary)),
                                        Text(pickupLocation, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: BahamaColors.deepTeal)),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right_rounded, color: BahamaColors.greyPrimary),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Add-ons
                            const Text('Add-ons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal)),
                            const SizedBox(height: 16),
                            _AddOnTile(
                              title: 'Full Insurance Coverage',
                              subtitle: 'Zero liability for damages',
                              price: '\$15/day',
                              isSelected: addInsurance,
                              onChanged: (v) => setState(() => addInsurance = v),
                            ),
                            const SizedBox(height: 12),
                            _AddOnTile(
                              title: 'GPS Navigation',
                              subtitle: 'Never get lost on the island',
                              price: '\$10/day',
                              isSelected: addGPS,
                              onChanged: (v) => setState(() => addGPS = v),
                            ),

                            const SizedBox(height: 24),

                            // Terms
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: BahamaColors.offWhiteMist,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Rental Terms', style: TextStyle(fontWeight: FontWeight.w600, color: BahamaColors.deepTeal)),
                                  const SizedBox(height: 8),
                                  _TermItem(text: 'Minimum driver age: 25 years'),
                                  _TermItem(text: 'Valid driver\'s license required'),
                                  _TermItem(text: 'Credit card for deposit'),
                                  _TermItem(text: car['mileage'] ?? 'Unlimited mileage'),
                                ],
                              ),
                            ),

                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Bottom bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: BahamaColors.whiteSand,
                boxShadow: [BoxShadow(color: BahamaColors.deepTeal.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, -5))],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('$days days rental', style: const TextStyle(fontSize: 12, color: BahamaColors.greyPrimary)),
                          const SizedBox(height: 4),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '\$$total',
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
                                ),
                                const TextSpan(text: ' total', style: TextStyle(fontSize: 14, color: BahamaColors.greyPrimary)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 160,
                      child: BahamaButton(
                        text: 'Reserve',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ConfirmationScreen(
                                hotel: {'name': car['name'], 'location': pickupLocation, 'image': car['image']},
                                checkIn: pickupDate,
                                checkOut: returnDate,
                                guests: 1,
                                rooms: 1,
                                total: total,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isPickup) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isPickup ? pickupDate : returnDate,
      firstDate: isPickup ? DateTime.now() : pickupDate.add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: BahamaColors.islandBlue, onPrimary: Colors.white, surface: BahamaColors.whiteSand, onSurface: BahamaColors.deepTeal),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isPickup) {
          pickupDate = picked;
          if (returnDate.isBefore(picked.add(const Duration(days: 1)))) {
            returnDate = picked.add(const Duration(days: 1));
          }
        } else {
          returnDate = picked;
        }
      });
    }
  }

  void _showLocationPicker(BuildContext context) {
    final locations = [
      'Nassau International Airport',
      'Paradise Island Marina',
      'Downtown Nassau',
      'Baha Mar Resort',
      'Cable Beach',
    ];
    showModalBottomSheet(
      context: context,
      backgroundColor: BahamaColors.whiteSand,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: BahamaColors.greyLight, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 20),
          const Text('Select Pick-up Location', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal)),
          const SizedBox(height: 16),
          ...locations.map((loc) => ListTile(
                leading: const Icon(Icons.location_on_outlined, color: BahamaColors.islandBlue),
                title: Text(loc),
                trailing: loc == pickupLocation ? const Icon(Icons.check_rounded, color: BahamaColors.islandBlue) : null,
                onTap: () {
                  setState(() => pickupLocation = loc);
                  Navigator.pop(context);
                },
              )),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;

  const _CircleButton({required this.icon, required this.onTap, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: BahamaColors.whiteSand.withOpacity(0.9),
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: BahamaColors.deepTeal.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(22), child: Icon(icon, color: iconColor ?? BahamaColors.deepTeal, size: 20)),
      ),
    );
  }
}

class _SpecCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SpecCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: BahamaColors.offWhiteMist, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Icon(icon, color: BahamaColors.islandBlue, size: 28),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: BahamaColors.deepTeal), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final String text;

  const _FeatureChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: BahamaColors.islandBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Text(text, style: const TextStyle(fontSize: 13, color: BahamaColors.deepTeal, fontWeight: FontWeight.w500)),
    );
  }
}

class _DateCard extends StatelessWidget {
  final String label;
  final DateTime date;
  final VoidCallback onTap;

  const _DateCard({required this.label, required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: BahamaColors.offWhiteMist, borderRadius: BorderRadius.circular(16), border: Border.all(color: BahamaColors.greyLight)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: BahamaColors.greyPrimary)),
            const SizedBox(height: 4),
            Text('${months[date.month - 1]} ${date.day}, ${date.year}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: BahamaColors.deepTeal)),
          ],
        ),
      ),
    );
  }
}

class _AddOnTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final bool isSelected;
  final ValueChanged<bool> onChanged;

  const _AddOnTile({required this.title, required this.subtitle, required this.price, required this.isSelected, required this.onChanged});

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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: BahamaColors.deepTeal)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: BahamaColors.greyPrimary)),
              ],
            ),
          ),
          Text(price, style: const TextStyle(fontWeight: FontWeight.w600, color: BahamaColors.islandBlue)),
          const SizedBox(width: 12),
          Switch(value: isSelected, onChanged: onChanged, activeColor: BahamaColors.islandBlue),
        ],
      ),
    );
  }
}

class _TermItem extends StatelessWidget {
  final String text;

  const _TermItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          const Icon(Icons.check_rounded, size: 16, color: BahamaColors.islandBlue),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: BahamaColors.greyPrimary))),
        ],
      ),
    );
  }
}

