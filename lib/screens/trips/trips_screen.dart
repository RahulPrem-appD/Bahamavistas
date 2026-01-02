import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_card.dart';
import '../../utils/constants.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen>
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
                  const Text(
                    'My Trips',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: BahamaColors.deepTeal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Manage your bookings and travel history',
                    style: TextStyle(
                      fontSize: 14,
                      color: BahamaColors.islandBlueDark,
                    ),
                  ),
                  const SizedBox(height: 20),
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
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      padding: const EdgeInsets.all(4),
                      tabs: const [
                        Tab(text: 'Upcoming'),
                        Tab(text: 'Active'),
                        Tab(text: 'Past'),
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
                  _UpcomingTrips(),
                  _ActiveTrips(),
                  _PastTrips(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UpcomingTrips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final upcomingTrips = DemoData.trips
        .where((trip) => trip['status'] == 'upcoming')
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: upcomingTrips.length,
      itemBuilder: (context, index) {
        final trip = upcomingTrips[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _TripCard(
            hotelName: trip['hotelName'] as String,
            location: trip['location'] as String,
            checkIn: trip['checkIn'] as String,
            checkOut: trip['checkOut'] as String,
            status: TripStatus.upcoming,
            confirmationCode: trip['confirmationCode'] as String,
            daysUntil: trip['daysUntil'] as int,
            imageUrl: trip['image'] as String,
          ),
        );
      },
    );
  }
}

class _ActiveTrips extends StatelessWidget {
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
                Icons.beach_access_rounded,
                size: 48,
                color: BahamaColors.islandBlue,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Active Trips',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: BahamaColors.deepTeal,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your current trips will appear here when you\'re traveling',
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

class _PastTrips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pastTrips = DemoData.trips
        .where((trip) => trip['status'] == 'completed' || trip['status'] == 'cancelled')
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: pastTrips.length,
      itemBuilder: (context, index) {
        final trip = pastTrips[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _TripCard(
            hotelName: trip['hotelName'] as String,
            location: trip['location'] as String,
            checkIn: trip['checkIn'] as String,
            checkOut: trip['checkOut'] as String,
            status: trip['status'] == 'completed' 
                ? TripStatus.completed 
                : TripStatus.cancelled,
            confirmationCode: trip['confirmationCode'] as String,
            imageUrl: trip['image'] as String,
          ),
        );
      },
    );
  }
}

enum TripStatus { upcoming, active, completed, cancelled }

class _TripCard extends StatelessWidget {
  final String hotelName;
  final String location;
  final String checkIn;
  final String checkOut;
  final TripStatus status;
  final String confirmationCode;
  final int? daysUntil;
  final String imageUrl;

  const _TripCard({
    required this.hotelName,
    required this.location,
    required this.checkIn,
    required this.checkOut,
    required this.status,
    required this.confirmationCode,
    this.daysUntil,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return BahamaCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          // Image header
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
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          BahamaColors.paleTurquoise,
                          BahamaColors.softSeafoam,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.hotel_rounded,
                        size: 48,
                        color: BahamaColors.islandBlue.withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
              ),
              // Gradient overlay
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 60,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.4),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: _StatusBadge(status: status),
              ),
              if (daysUntil != null)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: BahamaColors.whiteSand,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.schedule_rounded,
                          size: 14,
                          color: BahamaColors.islandBlue,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'In $daysUntil days',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: BahamaColors.deepTeal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotelName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: BahamaColors.deepTeal,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: BahamaColors.greyPrimary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(
                        fontSize: 13,
                        color: BahamaColors.greyPrimary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Dates
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: BahamaColors.offWhiteMist,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Check-in',
                              style: TextStyle(
                                fontSize: 11,
                                color: BahamaColors.greyPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              checkIn,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: BahamaColors.deepTeal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          size: 16,
                          color: BahamaColors.islandBlue,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Check-out',
                              style: TextStyle(
                                fontSize: 11,
                                color: BahamaColors.greyPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              checkOut,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: BahamaColors.deepTeal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Confirmation & actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Confirmation',
                          style: TextStyle(
                            fontSize: 11,
                            color: BahamaColors.greyPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          confirmationCode,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: BahamaColors.islandBlue,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        if (status == TripStatus.upcoming) ...[
                          _ActionButton(
                            icon: Icons.edit_outlined,
                            label: 'Modify',
                            onTap: () => _showModifyDialog(context),
                          ),
                          const SizedBox(width: 8),
                        ],
                        _ActionButton(
                          icon: Icons.visibility_outlined,
                          label: 'Details',
                          onTap: () => _showDetailsSheet(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showModifyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Modify Booking'),
        content: const Text(
          'You can modify your check-in/check-out dates or room preferences up to 48 hours before arrival.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Modify'),
          ),
        ],
      ),
    );
  }

  void _showDetailsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
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
                color: BahamaColors.greyLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      hotelName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: BahamaColors.deepTeal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16, color: BahamaColors.islandBlue),
                        const SizedBox(width: 4),
                        Text(location, style: const TextStyle(color: BahamaColors.greyPrimary)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _DetailRow(label: 'Confirmation Code', value: confirmationCode),
                    _DetailRow(label: 'Check-in', value: '$checkIn at 3:00 PM'),
                    _DetailRow(label: 'Check-out', value: '$checkOut at 11:00 AM'),
                    _DetailRow(label: 'Room Type', value: 'Deluxe Ocean View'),
                    _DetailRow(label: 'Guests', value: '2 Adults'),
                    const SizedBox(height: 24),
                    if (status == TripStatus.upcoming) ...[
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.cancel_outlined, size: 18),
                              label: const Text('Cancel'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red,
                                side: const BorderSide(color: Colors.red),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.chat_outlined, size: 18),
                              label: const Text('Contact Hotel'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: BahamaColors.islandBlue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ] else if (status == TripStatus.completed) ...[
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.star_outline, size: 18),
                          label: const Text('Rate Your Stay'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: BahamaColors.warmGold,
                            foregroundColor: BahamaColors.deepTeal,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: BahamaColors.greyPrimary,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: BahamaColors.deepTeal,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final TripStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    String label;
    IconData icon;

    switch (status) {
      case TripStatus.upcoming:
        backgroundColor = BahamaColors.islandBlue;
        textColor = Colors.white;
        label = 'Upcoming';
        icon = Icons.event_available_rounded;
        break;
      case TripStatus.active:
        backgroundColor = BahamaColors.warmGold;
        textColor = BahamaColors.deepTeal;
        label = 'Active';
        icon = Icons.luggage_rounded;
        break;
      case TripStatus.completed:
        backgroundColor = BahamaColors.deepTeal;
        textColor = Colors.white;
        label = 'Completed';
        icon = Icons.check_circle_rounded;
        break;
      case TripStatus.cancelled:
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade700;
        label = 'Cancelled';
        icon = Icons.cancel_rounded;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: textColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: BahamaColors.islandBlue.withOpacity(0.1),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 15, color: BahamaColors.islandBlue),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: BahamaColors.islandBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
