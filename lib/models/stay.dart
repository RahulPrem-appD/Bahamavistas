class Stay {
  final int id;
  final int listingId;
  final String type;
  final String name;
  final String description;
  final List<String> images;
  final double price;
  final String priceUnit;
  final String location;
  final double? latitude;
  final double? longitude;
  final String currency;
  final bool instantBook;
  final String island;
  final String propertyType;
  final List<String> amenities;
  final String? mealPlan;
  final String? cancellationPolicy;
  final bool freeCancellation;
  final double rating;
  final int reviewCount;
  final bool verified;
  final bool featured;
  final int? maxGuests;
  final int? bedrooms;
  final int? bathrooms;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Stay({
    required this.id,
    required this.listingId,
    this.type = 'stays',
    required this.name,
    required this.description,
    required this.images,
    required this.price,
    this.priceUnit = 'night',
    required this.location,
    this.latitude,
    this.longitude,
    this.currency = 'USD',
    this.instantBook = true,
    required this.island,
    required this.propertyType,
    required this.amenities,
    this.mealPlan,
    this.cancellationPolicy,
    this.freeCancellation = false,
    this.rating = 0,
    this.reviewCount = 0,
    this.verified = false,
    this.featured = false,
    this.maxGuests,
    this.bedrooms,
    this.bathrooms,
    this.createdAt,
    this.updatedAt,
  });

  String get mainImage => images.isNotEmpty ? images.first : '';

  factory Stay.fromJson(Map<String, dynamic> json) {
    return Stay(
      id: json['id'] as int,
      listingId: json['listingId'] as int? ?? 0,
      type: json['type'] as String? ?? 'stays',
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)?.cast<String>() ?? [],
      price: (json['price'] as num).toDouble(),
      priceUnit: json['priceUnit'] as String? ?? 'night',
      location: json['location'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      currency: json['currency'] as String? ?? 'USD',
      instantBook: json['instantBook'] as bool? ?? true,
      island: json['island'] as String? ?? '',
      propertyType: json['propertyType'] as String? ?? '',
      amenities: (json['amenities'] as List<dynamic>?)?.cast<String>() ?? [],
      mealPlan: json['mealPlan'] as String?,
      cancellationPolicy: json['cancellationPolicy'] as String?,
      freeCancellation: json['freeCancellation'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      verified: json['verified'] as bool? ?? false,
      featured: json['featured'] as bool? ?? false,
      maxGuests: json['maxGuests'] as int?,
      bedrooms: json['bedrooms'] as int?,
      bathrooms: json['bathrooms'] as int?,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    );
  }
}
