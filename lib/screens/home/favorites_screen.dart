import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_card.dart';
import '../../providers/favorites_provider.dart';
import '../booking/hotel_detail_screen.dart';
import '../booking/experience_detail_screen.dart';
import '../booking/car_detail_screen.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoritesProvider>().fetchFavorites();
    });
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
                  const SizedBox(height: 8),
                  const Text(
                    'Your saved places and experiences',
                    style: TextStyle(
                      fontSize: 14,
                      color: BahamaColors.islandBlueDark,
                    ),
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
    return Consumer<FavoritesProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading && provider.favorites.isEmpty) {
          return _buildFavShimmer();
        }
        final stays = provider.stayFavorites;
        if (stays.isEmpty) {
          return _buildFavEmpty('No favorite hotels yet');
        }
        return AnimationLimiter(
          child: ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: stays.length,
            itemBuilder: (context, index) {
              final fav = stays[index];
              final listing = fav.listing;
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: BahamaImageCard(
                        imageUrl: listing?.mainImage ?? '',
                        title: listing?.name ?? 'Unknown',
                        subtitle: listing?.location ?? '',
                        price: '\$${listing?.price.toStringAsFixed(0) ?? '0'}/night',
                        rating: listing?.rating ?? 0,
                        isFavorite: true,
                        onFavorite: () {
                          context.read<FavoritesProvider>().toggleFavorite(fav.listingId);
                        },
                        onTap: () {
                          final hotelMap = {
                            'name': listing?.name ?? '',
                            'location': listing?.location ?? '',
                            'price': listing?.price.toInt() ?? 0,
                            'rating': listing?.rating ?? 0,
                            'reviews': 0,
                            'image': listing?.mainImage ?? '',
                          };
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HotelDetailScreen(hotel: hotelMap),
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
      },
    );
  }
}

class _FavoriteExperiences extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading && provider.favorites.isEmpty) {
          return _buildFavShimmer();
        }
        final exps = provider.experienceFavorites;
        if (exps.isEmpty) {
          return _buildFavEmpty('No favorite experiences yet');
        }
        return AnimationLimiter(
          child: ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: exps.length,
            itemBuilder: (context, index) {
              final fav = exps[index];
              final listing = fav.listing;
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: BahamaImageCard(
                        imageUrl: listing?.mainImage ?? '',
                        title: listing?.name ?? 'Unknown',
                        subtitle: listing?.location ?? '',
                        price: '\$${listing?.price.toStringAsFixed(0) ?? '0'}/person',
                        rating: listing?.rating ?? 0,
                        isFavorite: true,
                        onFavorite: () {
                          context.read<FavoritesProvider>().toggleFavorite(fav.listingId);
                        },
                        onTap: () {
                          final expMap = {
                            'name': listing?.name ?? '',
                            'location': listing?.location ?? '',
                            'price': listing?.price.toInt() ?? 0,
                            'rating': listing?.rating ?? 0,
                            'image': listing?.mainImage ?? '',
                          };
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExperienceDetailScreen(experience: expMap),
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
      },
    );
  }
}

class _FavoriteCars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading && provider.favorites.isEmpty) {
          return _buildFavShimmer();
        }
        final cars = provider.carFavorites;
        if (cars.isEmpty) {
          return _buildFavEmpty('No favorite cars yet');
        }
        return AnimationLimiter(
          child: ListView.builder(
            padding: const EdgeInsets.all(24),
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final fav = cars[index];
              final listing = fav.listing;
              final carMap = {
                'name': listing?.name ?? 'Unknown',
                'location': listing?.location ?? '',
                'price': listing?.price.toInt() ?? 0,
                'rating': listing?.rating ?? 0,
                'image': listing?.mainImage ?? '',
                'type': '',
                'transmission': '',
                'seats': 4,
                'features': <String>[],
                'isPopular': false,
              };
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _CarFavoriteCard(
                        car: carMap,
                        listingId: fav.listingId,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CarDetailScreen(car: carMap),
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
      },
    );
  }
}

Widget _buildFavShimmer() {
  return ListView.builder(
    padding: const EdgeInsets.all(24),
    itemCount: 3,
    itemBuilder: (context, index) => Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Shimmer.fromColors(
        baseColor: BahamaColors.greyLight,
        highlightColor: BahamaColors.offWhiteMist,
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: BahamaColors.greyLight,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    ),
  );
}

Widget _buildFavEmpty(String message) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            size: 64,
            color: BahamaColors.islandBlue.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              color: BahamaColors.greyPrimary,
            ),
          ),
        ],
      ),
    ),
  );
}

class _CarFavoriteCard extends StatelessWidget {
  final Map<String, dynamic> car;
  final int? listingId;
  final VoidCallback onTap;

  const _CarFavoriteCard({required this.car, this.listingId, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: BahamaColors.whiteSand,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: BahamaColors.deepTeal.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: CachedNetworkImage(
                    imageUrl: car['image'] as String,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: BahamaColors.greyLight,
                      highlightColor: BahamaColors.offWhiteMist,
                      child: Container(height: 160, color: BahamaColors.greyLight),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 160,
                      color: BahamaColors.offWhiteMist,
                      child: const Icon(Icons.directions_car, size: 48, color: BahamaColors.islandBlue),
                    ),
                  ),
                ),
                if (car['isPopular'] == true)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        gradient: BahamaColors.ctaGradient,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Popular',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: BahamaColors.deepTeal),
                      ),
                    ),
                  ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: listingId != null
                        ? () => context.read<FavoritesProvider>().toggleFavorite(listingId!)
                        : null,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: BahamaColors.whiteSand,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)],
                      ),
                      child: const Icon(Icons.favorite, size: 18, color: Colors.red),
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
                        car['name'] as String,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: BahamaColors.deepTeal),
                      ),
                      Text(
                        '\$${car['price']}/day',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: BahamaColors.islandBlue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${car['type']} • ${car['transmission']} • ${car['seats']} seats',
                    style: const TextStyle(fontSize: 13, color: BahamaColors.greyPrimary),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: ((car['features'] as List<dynamic>).take(3)).map((f) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: BahamaColors.offWhiteMist,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(f as String, style: const TextStyle(fontSize: 11, color: BahamaColors.deepTeal)),
                    )).toList(),
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
