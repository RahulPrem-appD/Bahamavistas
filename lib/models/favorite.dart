class Favorite {
  final int id;
  final int listingId;
  final String? notes;
  final String listingType;
  final FavoriteListing? listing;
  final DateTime createdAt;

  Favorite({
    required this.id,
    required this.listingId,
    this.notes,
    required this.listingType,
    this.listing,
    required this.createdAt,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      id: json['id'] as int,
      listingId: json['listing_id'] as int,
      notes: json['notes'] as String?,
      listingType: json['listing_type'] as String? ?? 'stays',
      listing: json['listing'] != null
          ? FavoriteListing.fromJson(json['listing'] as Map<String, dynamic>)
          : null,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }
}

class FavoriteListing {
  final int id;
  final String name;
  final String location;
  final double price;
  final List<String> images;
  final double rating;
  final String type;

  FavoriteListing({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.images,
    required this.rating,
    required this.type,
  });

  String get mainImage => images.isNotEmpty ? images.first : '';

  factory FavoriteListing.fromJson(Map<String, dynamic> json) {
    return FavoriteListing(
      id: json['id'] as int,
      name: json['name'] as String,
      location: json['location'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      images: (json['images'] as List<dynamic>?)?.cast<String>() ?? [],
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      type: json['type'] as String? ?? 'stays',
    );
  }
}
