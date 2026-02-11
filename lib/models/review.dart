class Review {
  final int id;
  final int rating;
  final String? title;
  final String comment;
  final String userName;
  final String? travelerType;
  final DateTime date;
  final int? listingId;

  Review({
    required this.id,
    required this.rating,
    this.title,
    required this.comment,
    required this.userName,
    this.travelerType,
    required this.date,
    this.listingId,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as int,
      rating: json['rating'] as int,
      title: json['title'] as String?,
      comment: json['comment'] as String? ?? '',
      userName: json['userName'] as String? ?? 'Anonymous',
      travelerType: json['travelerType'] as String?,
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      listingId: json['listing_id'] as int?,
    );
  }
}
