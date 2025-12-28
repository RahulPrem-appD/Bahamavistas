import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_card.dart';
import '../../utils/constants.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                gradient: BahamaColors.seaGradient,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                          'My Favorites',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: BahamaColors.deepTeal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Tabs
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
                      padding: const EdgeInsets.all(4),
                      tabs: const [
                        Tab(text: 'Hotels'),
                        Tab(text: 'Experiences'),
                        Tab(text: 'Cars'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _FavoriteHotels(),
                  _FavoriteExperiences(),
                  _FavoriteCars(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteHotels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hotels = DemoData.hotels.take(3).toList();
    
    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          final hotel = hotels[index];
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
                    isFavorite: true,
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

class _FavoriteExperiences extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final experiences = DemoData.experiences.take(2).toList();
    
    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: experiences.length,
        itemBuilder: (context, index) {
          final exp = experiences[index];
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
                    subtitle: '${exp['location']} • ${exp['duration']}',
                    price: '\$${exp['price']}/person',
                    rating: exp['rating'] as double,
                    isFavorite: true,
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

class _FavoriteCars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: BahamaColors.islandBlue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.directions_car_outlined,
                size: 48,
                color: BahamaColors.islandBlue,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Saved Cars',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: BahamaColors.deepTeal,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Save cars you like to find them easily later',
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
    );
  }
}

