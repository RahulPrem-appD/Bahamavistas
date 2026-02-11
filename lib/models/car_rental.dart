class CarRental {
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
  final String transmission;
  final List<String> features;
  final String vehicleType;
  final String? color;
  final String fuelType;
  final String mileagePolicy;
  final int? seats;
  final int? year;
  final int? doors;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CarRental({
    required this.id,
    required this.listingId,
    this.type = 'car-rental',
    required this.name,
    required this.description,
    required this.images,
    required this.price,
    this.priceUnit = 'day',
    required this.location,
    this.latitude,
    this.longitude,
    this.currency = 'USD',
    this.instantBook = true,
    required this.transmission,
    required this.features,
    required this.vehicleType,
    this.color,
    this.fuelType = 'petrol',
    this.mileagePolicy = 'unlimited',
    this.seats,
    this.year,
    this.doors,
    this.createdAt,
    this.updatedAt,
  });

  String get mainImage => images.isNotEmpty ? images.first : '';
  bool get isPopular => vehicleType.toLowerCase() == 'suv' || vehicleType.toLowerCase() == 'convertible';

  factory CarRental.fromJson(Map<String, dynamic> json) {
    return CarRental(
      id: json['id'] as int,
      listingId: json['listingId'] as int? ?? 0,
      type: json['type'] as String? ?? 'car-rental',
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)?.cast<String>() ?? [],
      price: (json['price'] as num).toDouble(),
      priceUnit: json['priceUnit'] as String? ?? 'day',
      location: json['location'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      currency: json['currency'] as String? ?? 'USD',
      instantBook: json['instantBook'] as bool? ?? true,
      transmission: json['transmission'] as String? ?? 'automatic',
      features: (json['features'] as List<dynamic>?)?.cast<String>() ?? [],
      vehicleType: json['vehicleType'] as String? ?? '',
      color: json['color'] as String?,
      fuelType: json['fuelType'] as String? ?? 'petrol',
      mileagePolicy: json['mileagePolicy'] as String? ?? 'unlimited',
      seats: json['seats'] as int?,
      year: json['year'] as int?,
      doors: json['doors'] as int?,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    );
  }
}
