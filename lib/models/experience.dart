class Experience {
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
  final String? cancellationPolicy;
  final String? duration;
  final String? difficultyLevel;
  final String? activityType;
  final String? inclusions;
  final String? exclusions;
  final String? requirements;
  final String? meetingPoint;
  final String? whatToBring;
  final List<String> availableDays;
  final String? startTime;
  final String? endTime;
  final int? durationValue;
  final int? minimumAge;
  final int? groupSizeMin;
  final int? groupSizeMax;
  final int? maxGuests;
  final double? priceAdult;
  final double? priceChild;
  final double rating;
  final int reviewCount;
  final bool verified;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Experience({
    required this.id,
    required this.listingId,
    this.type = 'experience',
    required this.name,
    required this.description,
    required this.images,
    required this.price,
    this.priceUnit = 'person',
    required this.location,
    this.latitude,
    this.longitude,
    this.currency = 'USD',
    this.instantBook = true,
    this.cancellationPolicy,
    this.duration,
    this.difficultyLevel,
    this.activityType,
    this.inclusions,
    this.exclusions,
    this.requirements,
    this.meetingPoint,
    this.whatToBring,
    this.availableDays = const [],
    this.startTime,
    this.endTime,
    this.durationValue,
    this.minimumAge,
    this.groupSizeMin,
    this.groupSizeMax,
    this.maxGuests,
    this.priceAdult,
    this.priceChild,
    this.rating = 0,
    this.reviewCount = 0,
    this.verified = false,
    this.createdAt,
    this.updatedAt,
  });

  String get mainImage => images.isNotEmpty ? images.first : '';

  List<String> get inclusionsList {
    if (inclusions == null || inclusions!.isEmpty) return [];
    return inclusions!.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  }

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'] as int,
      listingId: json['listingId'] as int? ?? 0,
      type: json['type'] as String? ?? 'experience',
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)?.cast<String>() ?? [],
      price: (json['price'] as num).toDouble(),
      priceUnit: json['priceUnit'] as String? ?? 'person',
      location: json['location'] as String? ?? '',
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      currency: json['currency'] as String? ?? 'USD',
      instantBook: json['instantBook'] as bool? ?? true,
      cancellationPolicy: json['cancellationPolicy'] as String?,
      duration: json['duration'] as String?,
      difficultyLevel: json['difficultyLevel'] as String?,
      activityType: json['activityType'] as String?,
      inclusions: json['inclusions'] as String?,
      exclusions: json['exclusions'] as String?,
      requirements: json['requirements'] as String?,
      meetingPoint: json['meetingPoint'] as String?,
      whatToBring: json['whatToBring'] as String?,
      availableDays: (json['availableDays'] as List<dynamic>?)?.cast<String>() ?? [],
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      durationValue: json['durationValue'] as int?,
      minimumAge: json['minimumAge'] as int?,
      groupSizeMin: json['groupSizeMin'] as int?,
      groupSizeMax: json['groupSizeMax'] as int?,
      maxGuests: json['maxGuests'] as int?,
      priceAdult: (json['priceAdult'] as num?)?.toDouble(),
      priceChild: (json['priceChild'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      reviewCount: json['reviewCount'] as int? ?? 0,
      verified: json['verified'] as bool? ?? false,
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    );
  }
}
