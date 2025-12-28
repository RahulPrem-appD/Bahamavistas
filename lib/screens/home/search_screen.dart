import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_card.dart';
import '../../widgets/bahama_text_field.dart';
import '../../utils/constants.dart';
import '../booking/hotel_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BahamaColors.offWhiteMist,
      body: SafeArea(
        child: Column(
          children: [
            // Search header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: BahamaColors.seaGradient,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Find Your Perfect Stay',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: BahamaColors.deepTeal,
                    ),
                  ),
                  const SizedBox(height: 16),
                  BahamaSearchBar(
                    hintText: 'Search by island, hotel name...',
                    onFilterTap: () => _showFilterSheet(context),
                  ),
                  const SizedBox(height: 20),
                  // Tab bar
                  Container(
                    decoration: BoxDecoration(
                      color: BahamaColors.whiteSand,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        gradient: BahamaColors.ctaGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      labelColor: BahamaColors.deepTeal,
                      unselectedLabelColor: BahamaColors.greyPrimary,
                      labelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      padding: const EdgeInsets.all(4),
                      tabs: const [
                        Tab(text: 'Hotels'),
                        Tab(text: 'Cars'),
                        Tab(text: 'Flights'),
                        Tab(text: 'Experiences'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Results
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _HotelsTab(),
                  _CarsTab(),
                  _FlightsTab(),
                  _ExperiencesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _FilterSheet(),
    );
  }
}

class _HotelsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: DemoData.hotels.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${DemoData.hotels.length} Hotels Found',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: BahamaColors.deepTeal,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: BahamaColors.whiteSand,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: BahamaColors.greyLight),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.sort_rounded, size: 16, color: BahamaColors.islandBlue),
                        SizedBox(width: 4),
                        Text(
                          'Sort',
                          style: TextStyle(
                            fontSize: 13,
                            color: BahamaColors.islandBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          final hotel = DemoData.hotels[index - 1];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: BahamaImageCard(
                    imageUrl: hotel['image'] as String,
                    title: hotel['name'] as String,
                    subtitle: '${hotel['location']} • ${hotel['type']}',
                    price: '\$${hotel['price']}/night',
                    rating: hotel['rating'] as double,
                    reviews: hotel['reviews'] as int,
                    badge: hotel['isVerified'] == true
                        ? const BahamaVerifiedBadge()
                        : null,
                    onFavorite: () {},
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HotelDetailScreen(hotel: hotel),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CarsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: DemoData.cars.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                '${DemoData.cars.length} Cars Available',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: BahamaColors.deepTeal,
                ),
              ),
            );
          }

          final car = DemoData.cars[index - 1];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _CarCard(
                    name: car['name'] as String,
                    type: '${car['type']} • ${car['transmission']}',
                    price: '\$${car['price']}/day',
                    features: (car['features'] as List).cast<String>(),
                    imageUrl: car['image'] as String,
                    isPopular: car['isPopular'] as bool,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CarCard extends StatelessWidget {
  final String name;
  final String type;
  final String price;
  final List<String> features;
  final String imageUrl;
  final bool isPopular;

  const _CarCard({
    required this.name,
    required this.type,
    required this.price,
    required this.features,
    required this.imageUrl,
    this.isPopular = false,
  });

  @override
  Widget build(BuildContext context) {
    return BahamaCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: BahamaColors.greyLight,
                    highlightColor: BahamaColors.offWhiteMist,
                    child: Container(
                      height: 140,
                      color: BahamaColors.greyLight,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 140,
                    color: BahamaColors.offWhiteMist,
                    child: const Icon(
                      Icons.directions_car_rounded,
                      size: 64,
                      color: BahamaColors.greySecondary,
                    ),
                  ),
                ),
              ),
              if (isPopular)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: BahamaColors.ctaGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Popular',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: BahamaColors.deepTeal,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: BahamaColors.deepTeal,
                      ),
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: BahamaColors.islandBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  type,
                  style: const TextStyle(
                    fontSize: 13,
                    color: BahamaColors.greyPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: features.map((f) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: BahamaColors.offWhiteMist,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      f,
                      style: const TextStyle(
                        fontSize: 11,
                        color: BahamaColors.deepTeal,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FlightsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final flights = [
      {
        'airline': 'Bahamasair',
        'departure': '08:30 AM',
        'arrival': '10:45 AM',
        'from': 'MIA',
        'to': 'NAS',
        'price': 189,
        'duration': '2h 15m',
        'isDirect': true,
      },
      {
        'airline': 'American Airlines',
        'departure': '11:00 AM',
        'arrival': '01:20 PM',
        'from': 'JFK',
        'to': 'NAS',
        'price': 245,
        'duration': '2h 20m',
        'isDirect': true,
      },
      {
        'airline': 'Delta',
        'departure': '02:30 PM',
        'arrival': '04:50 PM',
        'from': 'ATL',
        'to': 'NAS',
        'price': 215,
        'duration': '2h 20m',
        'isDirect': false,
      },
    ];

    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: flights.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                '24 Flights Available',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: BahamaColors.deepTeal,
                ),
              ),
            );
          }

          final flight = flights[index - 1];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _FlightCard(
                    airline: flight['airline'] as String,
                    departure: flight['departure'] as String,
                    arrival: flight['arrival'] as String,
                    from: flight['from'] as String,
                    to: flight['to'] as String,
                    price: '\$${flight['price']}',
                    duration: flight['duration'] as String,
                    isDirect: flight['isDirect'] as bool,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FlightCard extends StatelessWidget {
  final String airline;
  final String departure;
  final String arrival;
  final String from;
  final String to;
  final String price;
  final String duration;
  final bool isDirect;

  const _FlightCard({
    required this.airline,
    required this.departure,
    required this.arrival,
    required this.from,
    required this.to,
    required this.price,
    required this.duration,
    this.isDirect = false,
  });

  @override
  Widget build(BuildContext context) {
    return BahamaCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                airline,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: BahamaColors.deepTeal,
                ),
              ),
              if (isDirect)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: BahamaColors.islandBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Direct',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: BahamaColors.islandBlue,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      departure,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: BahamaColors.deepTeal,
                      ),
                    ),
                    Text(
                      from,
                      style: const TextStyle(
                        fontSize: 14,
                        color: BahamaColors.greyPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      duration,
                      style: const TextStyle(
                        fontSize: 12,
                        color: BahamaColors.greyPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: BahamaColors.islandBlue,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 2,
                            color: BahamaColors.greyLight,
                          ),
                        ),
                        const Icon(
                          Icons.flight_rounded,
                          size: 16,
                          color: BahamaColors.islandBlue,
                        ),
                        Expanded(
                          child: Container(
                            height: 2,
                            color: BahamaColors.greyLight,
                          ),
                        ),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: BahamaColors.islandBlue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      arrival,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: BahamaColors.deepTeal,
                      ),
                    ),
                    Text(
                      to,
                      style: const TextStyle(
                        fontSize: 14,
                        color: BahamaColors.greyPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: BahamaColors.greyLight,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Economy',
                style: TextStyle(
                  fontSize: 13,
                  color: BahamaColors.greyPrimary,
                ),
              ),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: BahamaColors.islandBlue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExperiencesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: DemoData.experiences.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                '89 Experiences',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: BahamaColors.deepTeal,
                ),
              ),
            );
          }

          final exp = DemoData.experiences[index - 1];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: BahamaImageCard(
                    imageUrl: exp['image'] as String,
                    title: exp['name'] as String,
                    subtitle: '${exp['location']} • ${exp['duration']} • ${exp['type']}',
                    price: '\$${exp['price']}/person',
                    rating: exp['rating'] as double,
                    badge: exp['isVerified'] == true
                        ? const BahamaVerifiedBadge()
                        : null,
                    onFavorite: () {},
                    onTap: () {},
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FilterSheet extends StatefulWidget {
  const _FilterSheet();

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  RangeValues _priceRange = const RangeValues(50, 500);
  double _minRating = 4.0;
  bool _verifiedOnly = true;
  Set<String> _selectedIslands = {'Nassau', 'Paradise Island'};

  final List<String> _islands = [
    'Nassau',
    'Paradise Island',
    'Exuma',
    'Eleuthera',
    'Harbour Island',
    'Andros',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: BahamaColors.whiteSand,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
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
          const Text(
            'Filters',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: BahamaColors.deepTeal,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price Range
                  const Text(
                    'Price Range',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: BahamaColors.deepTeal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${_priceRange.start.toInt()} - \$${_priceRange.end.toInt()}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: BahamaColors.islandBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  RangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: 1000,
                    divisions: 20,
                    activeColor: BahamaColors.islandBlue,
                    inactiveColor: BahamaColors.greyLight,
                    onChanged: (values) {
                      setState(() {
                        _priceRange = values;
                      });
                    },
                  ),

                  const SizedBox(height: 24),

                  // Rating
                  const Text(
                    'Minimum Rating',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: BahamaColors.deepTeal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: BahamaColors.warmGold),
                      const SizedBox(width: 8),
                      Text(
                        _minRating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: BahamaColors.deepTeal,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _minRating,
                    min: 1,
                    max: 5,
                    divisions: 8,
                    activeColor: BahamaColors.warmGold,
                    inactiveColor: BahamaColors.greyLight,
                    onChanged: (value) {
                      setState(() {
                        _minRating = value;
                      });
                    },
                  ),

                  const SizedBox(height: 24),

                  // Verified vendors
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Verified Vendors Only',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: BahamaColors.deepTeal,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Show only trusted vendors',
                            style: TextStyle(
                              fontSize: 13,
                              color: BahamaColors.greyPrimary,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: _verifiedOnly,
                        onChanged: (value) {
                          setState(() {
                            _verifiedOnly = value;
                          });
                        },
                        activeColor: BahamaColors.islandBlue,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Islands
                  const Text(
                    'Islands',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: BahamaColors.deepTeal,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _islands.map((island) {
                      final isSelected = _selectedIslands.contains(island);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedIslands.remove(island);
                            } else {
                              _selectedIslands.add(island);
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? BahamaColors.islandBlue.withOpacity(0.1)
                                : BahamaColors.offWhiteMist,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? BahamaColors.islandBlue : BahamaColors.greyLight,
                            ),
                          ),
                          child: Text(
                            island,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              color: isSelected ? BahamaColors.islandBlue : BahamaColors.greyPrimary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: BahamaColors.islandBlue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        color: BahamaColors.islandBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: BahamaColors.ctaGradient,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(16),
                        child: const Center(
                          child: Text(
                            'Apply',
                            style: TextStyle(
                              color: BahamaColors.deepTeal,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
