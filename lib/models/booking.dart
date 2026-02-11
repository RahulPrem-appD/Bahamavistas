class Booking {
  final int id;
  final int listingId;
  final String confirmationCode;
  final String? listingName;
  final String? listingImage;
  final String? location;
  final String startDate;
  final String endDate;
  final int guests;
  final int totalPrice; // cents
  final String status;
  final bool paid;
  final DateTime createdAt;
  final bool hasReview;

  Booking({
    required this.id,
    required this.listingId,
    required this.confirmationCode,
    this.listingName,
    this.listingImage,
    this.location,
    required this.startDate,
    required this.endDate,
    this.guests = 1,
    required this.totalPrice,
    required this.status,
    this.paid = false,
    required this.createdAt,
    this.hasReview = false,
  });

  double get totalDollars => totalPrice / 100;

  bool get isUpcoming => status == 'pending' || status == 'confirmed';
  bool get isCompleted => status == 'completed';
  bool get isCancelled => status == 'cancelled';

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as int,
      listingId: json['listing_id'] as int,
      confirmationCode: json['confirmation_code'] as String? ?? '',
      listingName: json['listing_name'] as String?,
      listingImage: json['listing_image'] as String?,
      location: json['location'] as String?,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      guests: json['guests'] as int? ?? 1,
      totalPrice: json['total_price'] as int? ?? 0,
      status: json['status'] as String? ?? 'pending',
      paid: json['paid'] as bool? ?? false,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      hasReview: json['has_review'] as bool? ?? false,
    );
  }
}

class CreateBookingResponse {
  final int bookingId;
  final String confirmationCode;
  final int totalPrice;
  final String status;

  CreateBookingResponse({
    required this.bookingId,
    required this.confirmationCode,
    required this.totalPrice,
    required this.status,
  });

  double get totalDollars => totalPrice / 100;

  factory CreateBookingResponse.fromJson(Map<String, dynamic> json) {
    return CreateBookingResponse(
      bookingId: json['booking_id'] as int,
      confirmationCode: json['confirmation_code'] as String,
      totalPrice: json['total_price'] as int? ?? 0,
      status: json['status'] as String? ?? 'pending',
    );
  }
}
