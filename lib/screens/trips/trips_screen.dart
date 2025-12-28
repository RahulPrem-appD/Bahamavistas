import 'package:flutter/material.dart';
import '../../theme/colors.dart';
import '../../widgets/bahama_card.dart';

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
    return ListView(
      padding: const EdgeInsets.all(24),
      children: const [
        _TripCard(
          hotelName: 'Atlantis Paradise Island',
          location: 'Paradise Island, Bahamas',
          checkIn: 'Dec 29, 2024',
          checkOut: 'Jan 1, 2025',
          status: TripStatus.upcoming,
          confirmationCode: 'BV-2024-78542',
          daysUntil: 7,
        ),
        SizedBox(height: 16),
        _TripCard(
          hotelName: 'Sandals Royal Bahamian',
          location: 'Nassau, Bahamas',
          checkIn: 'Jan 15, 2025',
          checkOut: 'Jan 20, 2025',
          status: TripStatus.upcoming,
          confirmationCode: 'BV-2024-78901',
          daysUntil: 24,
        ),
      ],
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
    return ListView(
      padding: const EdgeInsets.all(24),
      children: const [
        _TripCard(
          hotelName: 'Grand Hyatt Baha Mar',
          location: 'Nassau, Bahamas',
          checkIn: 'Nov 10, 2024',
          checkOut: 'Nov 15, 2024',
          status: TripStatus.completed,
          confirmationCode: 'BV-2024-65432',
        ),
        SizedBox(height: 16),
        _TripCard(
          hotelName: 'Rosewood Baha Mar',
          location: 'Nassau, Bahamas',
          checkIn: 'Aug 20, 2024',
          checkOut: 'Aug 25, 2024',
          status: TripStatus.completed,
          confirmationCode: 'BV-2024-54321',
        ),
        SizedBox(height: 16),
        _TripCard(
          hotelName: 'Comfort Suites Paradise',
          location: 'Paradise Island, Bahamas',
          checkIn: 'Jun 5, 2024',
          checkOut: 'Jun 10, 2024',
          status: TripStatus.cancelled,
          confirmationCode: 'BV-2024-43210',
        ),
      ],
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

  const _TripCard({
    required this.hotelName,
    required this.location,
    required this.checkIn,
    required this.checkOut,
    required this.status,
    required this.confirmationCode,
    this.daysUntil,
  });

  @override
  Widget build(BuildContext context) {
    return BahamaCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          // Image header
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  BahamaColors.paleTurquoise,
                  BahamaColors.softSeafoam,
                ],
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.hotel_rounded,
                    size: 48,
                    color: BahamaColors.islandBlue.withOpacity(0.4),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: BahamaColors.whiteSand,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'In $daysUntil days',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: BahamaColors.deepTeal,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
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
                Row(
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
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: BahamaColors.islandBlue,
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

                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),

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
                        Text(
                          confirmationCode,
                          style: const TextStyle(
                            fontSize: 12,
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
                            onTap: () {},
                          ),
                          const SizedBox(width: 8),
                        ],
                        _ActionButton(
                          icon: Icons.visibility_outlined,
                          label: 'Details',
                          onTap: () {},
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
}

class _StatusBadge extends StatelessWidget {
  final TripStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    String label;

    switch (status) {
      case TripStatus.upcoming:
        backgroundColor = BahamaColors.islandBlue;
        textColor = Colors.white;
        label = 'Upcoming';
        break;
      case TripStatus.active:
        backgroundColor = BahamaColors.warmGold;
        textColor = BahamaColors.deepTeal;
        label = 'Active';
        break;
      case TripStatus.completed:
        backgroundColor = BahamaColors.deepTeal;
        textColor = Colors.white;
        label = 'Completed';
        break;
      case TripStatus.cancelled:
        backgroundColor = Colors.red.shade100;
        textColor = Colors.red.shade700;
        label = 'Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
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
      color: BahamaColors.offWhiteMist,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: BahamaColors.islandBlue),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
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

