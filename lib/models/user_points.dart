class UserPoints {
  final int points;
  final int totalPoints;
  final int pointsEarned;
  final int pointsRedeemed;
  final int pointsAvailable;
  final int bookingsCount;
  final String tier;
  final String? nextTier;
  final int? pointsToNextTier;

  UserPoints({
    required this.points,
    required this.totalPoints,
    required this.pointsEarned,
    required this.pointsRedeemed,
    required this.pointsAvailable,
    required this.bookingsCount,
    required this.tier,
    this.nextTier,
    this.pointsToNextTier,
  });

  factory UserPoints.fromJson(Map<String, dynamic> json) {
    return UserPoints(
      points: json['points'] as int? ?? 0,
      totalPoints: json['total_points'] as int? ?? 0,
      pointsEarned: json['points_earned'] as int? ?? 0,
      pointsRedeemed: json['points_redeemed'] as int? ?? 0,
      pointsAvailable: json['points_available'] as int? ?? 0,
      bookingsCount: json['bookings_count'] as int? ?? 0,
      tier: json['tier'] as String? ?? 'bronze',
      nextTier: json['next_tier'] as String?,
      pointsToNextTier: json['points_to_next_tier'] as int?,
    );
  }
}
