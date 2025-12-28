import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_button.dart';
import '../../widgets/bahama_card.dart';
import '../../utils/constants.dart';
import 'booking_screen.dart';

class HotelDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? hotel;

  const HotelDetailScreen({super.key, this.hotel});

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  bool isFavorite = false;
  int currentImageIndex = 0;

  late Map<String, dynamic> hotel;
  late List<String> galleryImages;

  @override
  void initState() {
    super.initState();
    hotel = widget.hotel ?? DemoData.hotels[0];
    galleryImages = [
      hotel['image'] as String,
      AppImages.hotelRoom,
      AppImages.poolResort,
      AppImages.hotelLobby,
      AppImages.beachResort,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Hero image with gallery
          SizedBox(
            height: 360,
            child: Stack(
              children: [
                PageView.builder(
                  itemCount: galleryImages.length,
                  onPageChanged: (index) {
                    setState(() => currentImageIndex = index);
                  },
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: galleryImages[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: BahamaColors.greyLight,
                        highlightColor: BahamaColors.offWhiteMist,
                        child: Container(color: BahamaColors.greyLight),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: BahamaColors.paleTurquoise,
                        child: const Icon(Icons.image, size: 64, color: BahamaColors.islandBlue),
                      ),
                    );
                  },
                ),
                // Gradient overlay
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ),
                // Page indicators
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      galleryImages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: currentImageIndex == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: currentImageIndex == index
                              ? BahamaColors.whiteSand
                              : BahamaColors.whiteSand.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
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

                    const SizedBox(height: 230),

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
                            // Title section
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          if (hotel['isVerified'] == true)
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: BahamaColors.islandBlue,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: const Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.verified_rounded,
                                                    size: 12,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    'Verified',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: BahamaColors.warmGold.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  Icons.star_rounded,
                                                  size: 12,
                                                  color: BahamaColors.warmGold,
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  '${hotel['rating']}',
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    color: BahamaColors.deepTeal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        hotel['name'] as String,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: BahamaColors.deepTeal,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 16,
                                            color: BahamaColors.greyPrimary,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${hotel['location']}, Bahamas',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: BahamaColors.greyPrimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\$${hotel['price']}',
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: BahamaColors.islandBlue,
                                      ),
                                    ),
                                    const Text(
                                      '/night',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: BahamaColors.greyPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            // Description
                            const Text(
                              'About',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: BahamaColors.deepTeal,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Experience the ultimate island getaway at this iconic resort. World-class amenities, stunning ocean views, and unforgettable experiences await you. Perfect for families, couples, and solo travelers looking for a premium Bahamas experience.',
                              style: TextStyle(
                                fontSize: 14,
                                color: BahamaColors.greyPrimary,
                                height: 1.6,
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Amenities
                            const Text(
                              'Amenities',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: BahamaColors.deepTeal,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: const [
                                _AmenityChip(icon: Icons.wifi_rounded, label: 'Free WiFi'),
                                _AmenityChip(icon: Icons.pool_rounded, label: 'Pool'),
                                _AmenityChip(icon: Icons.spa_rounded, label: 'Spa'),
                                _AmenityChip(icon: Icons.restaurant_rounded, label: 'Restaurant'),
                                _AmenityChip(icon: Icons.fitness_center_rounded, label: 'Gym'),
                                _AmenityChip(icon: Icons.local_parking_rounded, label: 'Parking'),
                                _AmenityChip(icon: Icons.beach_access_rounded, label: 'Beach'),
                                _AmenityChip(icon: Icons.room_service_rounded, label: 'Room Service'),
                              ],
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
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: BahamaColors.deepTeal,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: BahamaColors.greyLight,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        '${hotel['reviews']}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: BahamaColors.greyPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
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
                            const SizedBox(height: 12),
                            _ReviewCard(
                              name: 'Sarah M.',
                              avatar: AppImages.avatar1,
                              date: 'Dec 2024',
                              rating: 5,
                              review: 'Absolutely stunning resort! The water park was amazing and the rooms were beautiful. Will definitely come back!',
                            ),
                            const SizedBox(height: 12),
                            _ReviewCard(
                              name: 'James K.',
                              avatar: AppImages.avatar2,
                              date: 'Nov 2024',
                              rating: 4,
                              review: 'Great location and excellent service. The beach is pristine and the staff is very friendly.',
                            ),

                            const SizedBox(height: 24),

                            // Location
                            const Text(
                              'Location',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: BahamaColors.deepTeal,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              height: 160,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: BahamaColors.greyLight),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: 'https://images.unsplash.com/photo-1524661135-423995f22d0b?w=800&q=80',
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        color: BahamaColors.offWhiteMist,
                                      ),
                                      errorWidget: (context, url, error) => Container(
                                        color: BahamaColors.offWhiteMist,
                                        child: const Icon(Icons.map, color: BahamaColors.greyPrimary),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.black.withOpacity(0.2),
                                    ),
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: BahamaColors.whiteSand,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.map_outlined, size: 18, color: BahamaColors.islandBlue),
                                            SizedBox(width: 8),
                                            Text(
                                              'View on Map',
                                              style: TextStyle(
                                                color: BahamaColors.islandBlue,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                          const Text(
                            'Total Price',
                            style: TextStyle(
                              fontSize: 12,
                              color: BahamaColors.greyPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '\$${hotel['price']}',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: BahamaColors.deepTeal,
                                  ),
                                ),
                                const TextSpan(
                                  text: ' /night',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: BahamaColors.greyPrimary,
                                  ),
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
                              builder: (context) => BookingScreen(hotel: hotel),
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
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;

  const _CircleButton({
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: BahamaColors.whiteSand.withOpacity(0.9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: BahamaColors.deepTeal.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Icon(
            icon,
            color: iconColor ?? BahamaColors.deepTeal,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class _AmenityChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _AmenityChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: BahamaColors.offWhiteMist,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: BahamaColors.islandBlue),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: BahamaColors.deepTeal,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final String name;
  final String avatar;
  final String date;
  final int rating;
  final String review;

  const _ReviewCard({
    required this.name,
    required this.avatar,
    required this.date,
    required this.rating,
    required this.review,
  });

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
                  imageUrl: avatar,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 40,
                    height: 40,
                    color: BahamaColors.greyLight,
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 40,
                    height: 40,
                    color: BahamaColors.islandBlue.withOpacity(0.1),
                    child: Center(
                      child: Text(
                        name[0],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: BahamaColors.islandBlue,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: BahamaColors.deepTeal,
                      ),
                    ),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: BahamaColors.greyPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    Icons.star_rounded,
                    size: 16,
                    color: index < rating
                        ? BahamaColors.warmGold
                        : BahamaColors.greyLight,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review,
            style: const TextStyle(
              fontSize: 13,
              color: BahamaColors.greyPrimary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
