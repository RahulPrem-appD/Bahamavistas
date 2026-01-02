import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_card.dart';
import '../../widgets/bahama_text_field.dart';
import '../../utils/constants.dart';
import '../booking/hotel_detail_screen.dart';
import 'notifications_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [BahamaColors.lightAqua, BahamaColors.whiteSand],
            stops: [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello, Traveler 👋',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: BahamaColors.islandBlueDark,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Discover Paradise',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: BahamaColors.deepTeal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              _HeaderButton(
                                icon: Icons.favorite_border_rounded,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const FavoritesScreen(),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 12),
                              _HeaderButton(
                                icon: Icons.notifications_outlined,
                                badge: 3,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const NotificationsScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const BahamaSearchBar(
                        hintText: 'Search islands, hotels, experiences...',
                        onFilterTap: null,
                      ),
                    ],
                  ),
                ),
              ),

              // Category tabs
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: const [
                      _CategoryItem(
                        icon: Icons.hotel_rounded,
                        label: 'Hotels',
                        isSelected: true,
                      ),
                      _CategoryItem(
                        icon: Icons.directions_car_rounded,
                        label: 'Cars',
                      ),
                      _CategoryItem(
                        icon: Icons.flight_rounded,
                        label: 'Flights',
                      ),
                      _CategoryItem(
                        icon: Icons.sailing_rounded,
                        label: 'Experiences',
                      ),
                    ],
                  ),
                ),
              ),

              // Popular Islands
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Popular Islands',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: BahamaColors.deepTeal,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            color: BahamaColors.islandBlue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: DemoData.islands.length,
                    itemBuilder: (context, index) {
                      final island = DemoData.islands[index];
                      return _IslandCard(
                        name: island['name'] as String,
                        properties: '${island['properties']} Properties',
                        imageUrl: island['image'] as String,
                      );
                    },
                  ),
                ),
              ),

              // Featured Hotels
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Featured Hotels',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: BahamaColors.deepTeal,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            color: BahamaColors.islandBlue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index >= DemoData.hotels.length) return null;
                      final hotel = DemoData.hotels[index];
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
                                      builder: (context) => HotelDetailScreen(
                                        hotel: hotel,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: DemoData.hotels.length,
                  ),
                ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final int? badge;

  const _HeaderButton({
    required this.icon,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: BahamaColors.whiteSand,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: BahamaColors.deepTeal.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(24),
              child: Icon(icon, color: BahamaColors.islandBlue),
            ),
          ),
        ),
        if (badge != null)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: BahamaColors.warmGold,
                shape: BoxShape.circle,
              ),
              child: Text(
                badge.toString(),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: BahamaColors.deepTeal,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const _CategoryItem({
    required this.icon,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              gradient: isSelected ? BahamaColors.ctaGradient : null,
              color: isSelected ? null : BahamaColors.whiteSand,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? BahamaColors.warmGold.withOpacity(0.3)
                      : BahamaColors.deepTeal.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: isSelected
                  ? BahamaColors.deepTeal
                  : BahamaColors.islandBlue,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected
                  ? BahamaColors.deepTeal
                  : BahamaColors.greyPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _IslandCard extends StatelessWidget {
  final String name;
  final String properties;
  final String imageUrl;

  const _IslandCard({
    required this.name,
    required this.properties,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: BahamaColors.deepTeal.withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: BahamaColors.greyLight,
                highlightColor: BahamaColors.offWhiteMist,
                child: Container(color: BahamaColors.greyLight),
              ),
              errorWidget: (context, url, error) => Container(
                color: BahamaColors.paleTurquoise,
                child: const Icon(Icons.image, color: BahamaColors.islandBlue),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    properties,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
