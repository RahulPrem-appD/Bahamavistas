import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_button.dart';
import '../../widgets/bahama_card.dart';
import '../../utils/constants.dart';
import 'confirmation_screen.dart';

class ExperienceDetailScreen extends StatefulWidget {
  final Map<String, dynamic> experience;

  const ExperienceDetailScreen({super.key, required this.experience});

  @override
  State<ExperienceDetailScreen> createState() => _ExperienceDetailScreenState();
}

class _ExperienceDetailScreenState extends State<ExperienceDetailScreen> {
  bool isFavorite = false;
  DateTime selectedDate = DateTime.now().add(const Duration(days: 3));
  String selectedTime = '9:00 AM';
  int guests = 2;

  final List<String> availableTimes = [
    '8:00 AM',
    '9:00 AM',
    '10:00 AM',
    '1:00 PM',
    '2:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    final exp = widget.experience;

    return Scaffold(
      body: Stack(
        children: [
          // Hero image
          SizedBox(
            height: 320,
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: exp['image'] as String,
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
                    child: const Icon(Icons.image, size: 64, color: BahamaColors.islandBlue),
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
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.5),
                        ],
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
                                  onTap: () {
                                    setState(() => isFavorite = !isFavorite);
                                  },
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
                            // Badges row
                            Row(
                              children: [
                                if (exp['isVerified'] == true)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: BahamaColors.islandBlue,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.verified_rounded, size: 12, color: Colors.white),
                                        SizedBox(width: 4),
                                        Text(
                                          'Verified',
                                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: BahamaColors.warmGold.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.star_rounded, size: 12, color: BahamaColors.warmGold),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${exp['rating']}',
                                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: BahamaColors.deepTeal),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: BahamaColors.offWhiteMist,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    exp['type'] as String,
                                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: BahamaColors.deepTeal),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Title
                            Text(
                              exp['name'] as String,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: BahamaColors.deepTeal,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, size: 16, color: BahamaColors.greyPrimary),
                                const SizedBox(width: 4),
                                Text(
                                  '${exp['location']}, Bahamas',
                                  style: const TextStyle(fontSize: 14, color: BahamaColors.greyPrimary),
                                ),
                                const SizedBox(width: 16),
                                const Icon(Icons.schedule_outlined, size: 16, color: BahamaColors.greyPrimary),
                                const SizedBox(width: 4),
                                Text(
                                  exp['duration'] as String,
                                  style: const TextStyle(fontSize: 14, color: BahamaColors.greyPrimary),
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            // Description
                            const Text(
                              'About This Experience',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              exp['description'] as String? ??
                                  'An unforgettable adventure awaits you in the beautiful Bahamas. Join us for this amazing experience that combines adventure, relaxation, and the natural beauty of the islands.',
                              style: const TextStyle(fontSize: 14, color: BahamaColors.greyPrimary, height: 1.6),
                            ),

                            const SizedBox(height: 24),

                            // What's included
                            const Text(
                              'What\'s Included',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                ...((exp['includes'] as List<dynamic>?) ?? ['Equipment', 'Guide', 'Drinks']).map(
                                  (item) => _IncludedItem(text: item as String),
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            // Select date
                            const Text(
                              'Select Date & Time',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
                            ),
                            const SizedBox(height: 16),
                            BahamaCard(
                              onTap: () => _selectDate(context),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: BahamaColors.islandBlue.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(Icons.calendar_today_rounded, color: BahamaColors.islandBlue),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Date', style: TextStyle(fontSize: 12, color: BahamaColors.greyPrimary)),
                                        Text(
                                          '${_getMonthName(selectedDate.month)} ${selectedDate.day}, ${selectedDate.year}',
                                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: BahamaColors.deepTeal),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.chevron_right_rounded, color: BahamaColors.greyPrimary),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 44,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: availableTimes.length,
                                itemBuilder: (context, index) {
                                  final time = availableTimes[index];
                                  final isSelected = time == selectedTime;
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: GestureDetector(
                                      onTap: () => setState(() => selectedTime = time),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        decoration: BoxDecoration(
                                          gradient: isSelected ? BahamaColors.ctaGradient : null,
                                          color: isSelected ? null : BahamaColors.offWhiteMist,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: isSelected ? Colors.transparent : BahamaColors.greyLight,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            time,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                              color: BahamaColors.deepTeal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Guests
                            const Text(
                              'Number of Guests',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
                            ),
                            const SizedBox(height: 16),
                            BahamaCard(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Guests', style: TextStyle(fontSize: 12, color: BahamaColors.greyPrimary)),
                                      Text(
                                        '$guests ${guests == 1 ? 'person' : 'people'}',
                                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: BahamaColors.deepTeal),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      _CounterButton(
                                        icon: Icons.remove,
                                        onTap: guests > 1 ? () => setState(() => guests--) : null,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Text(
                                          '$guests',
                                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
                                        ),
                                      ),
                                      _CounterButton(
                                        icon: Icons.add,
                                        onTap: guests < (exp['maxGroupSize'] ?? 10)
                                            ? () => setState(() => guests++)
                                            : null,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Meeting point
                            const Text(
                              'Meeting Point',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
                            ),
                            const SizedBox(height: 12),
                            BahamaCard(
                              child: Row(
                                children: [
                                  const Icon(Icons.pin_drop_outlined, color: BahamaColors.islandBlue),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      exp['meetingPoint'] as String? ?? '${exp['location']} Marina',
                                      style: const TextStyle(color: BahamaColors.deepTeal),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text('View Map'),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Reviews
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Reviews',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: BahamaColors.greyLight,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        '${exp['reviews']}',
                                        style: const TextStyle(fontSize: 12, color: BahamaColors.greyPrimary),
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text('See All', style: TextStyle(color: BahamaColors.islandBlue, fontWeight: FontWeight.w500)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ...DemoData.reviews.take(2).map((review) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _ReviewCard(review: review),
                            )),

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

          // Bottom booking bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: BahamaColors.whiteSand,
                boxShadow: [
                  BoxShadow(
                    color: BahamaColors.deepTeal.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
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
                          const Text('Total', style: TextStyle(fontSize: 12, color: BahamaColors.greyPrimary)),
                          const SizedBox(height: 4),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '\$${(exp['price'] as int) * guests}',
                                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: BahamaColors.deepTeal),
                                ),
                                TextSpan(
                                  text: ' ($guests ${guests == 1 ? 'guest' : 'guests'})',
                                  style: const TextStyle(fontSize: 14, color: BahamaColors.greyPrimary),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 160,
                      child: BahamaButton(
                        text: 'Book Now',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ConfirmationScreen(
                                hotel: {
                                  'name': exp['name'],
                                  'location': exp['location'],
                                  'image': exp['image'],
                                },
                                checkIn: selectedDate,
                                checkOut: selectedDate,
                                guests: guests,
                                rooms: 1,
                                total: (exp['price'] as int) * guests,
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

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: BahamaColors.islandBlue,
              onPrimary: Colors.white,
              surface: BahamaColors.whiteSand,
              onSurface: BahamaColors.deepTeal,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
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
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Icon(icon, color: iconColor ?? BahamaColors.deepTeal, size: 20),
        ),
      ),
    );
  }
}

class _IncludedItem extends StatelessWidget {
  final String text;

  const _IncludedItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: BahamaColors.islandBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_rounded, size: 16, color: BahamaColors.islandBlue),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontSize: 13, color: BahamaColors.deepTeal, fontWeight: FontWeight.w500)),
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
        child: Icon(
          icon,
          color: isEnabled ? BahamaColors.islandBlue : BahamaColors.greyPrimary,
          size: 20,
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final Map<String, dynamic> review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return BahamaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: review['avatar'] as String,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(width: 40, height: 40, color: BahamaColors.greyLight),
                  errorWidget: (context, url, error) => Container(
                    width: 40,
                    height: 40,
                    color: BahamaColors.islandBlue.withOpacity(0.1),
                    child: Center(child: Text(review['name'][0], style: const TextStyle(fontWeight: FontWeight.bold, color: BahamaColors.islandBlue))),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review['name'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: BahamaColors.deepTeal)),
                    Text(review['date'] as String, style: const TextStyle(fontSize: 12, color: BahamaColors.greyPrimary)),
                  ],
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    Icons.star_rounded,
                    size: 16,
                    color: index < (review['rating'] as int) ? BahamaColors.warmGold : BahamaColors.greyLight,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review['review'] as String,
            style: const TextStyle(fontSize: 13, color: BahamaColors.greyPrimary, height: 1.5),
          ),
        ],
      ),
    );
  }
}

