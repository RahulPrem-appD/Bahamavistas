class User {
  final int id;
  final String email;
  final String name;
  final String firstName;
  final String lastName;
  final String? phone;
  final String? address;
  final String? city;
  final String? country;
  final String? zipCode;
  final String currency;
  final String language;
  final int points;
  final String tier;
  final String status;
  final bool isActive;
  final DateTime? lastLoginAt;
  final DateTime createdAt;
  final DateTime? emailVerifiedAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.address,
    this.city,
    this.country,
    this.zipCode,
    this.currency = 'USD',
    this.language = 'en',
    this.points = 0,
    this.tier = 'bronze',
    this.status = 'active',
    this.isActive = true,
    this.lastLoginAt,
    required this.createdAt,
    this.emailVerifiedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      email: json['email'] as String,
      name: json['name'] as String? ?? '${json['first_name']} ${json['last_name']}',
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      zipCode: json['zip_code'] as String?,
      currency: json['currency'] as String? ?? 'USD',
      language: json['language'] as String? ?? 'en',
      points: json['points'] as int? ?? 0,
      tier: json['tier'] as String? ?? 'bronze',
      status: json['status'] as String? ?? 'active',
      isActive: json['is_active'] as bool? ?? true,
      lastLoginAt: json['last_login_at'] != null
          ? DateTime.tryParse(json['last_login_at'])
          : null,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.tryParse(json['email_verified_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'address': address,
      'city': city,
      'country': country,
      'zip_code': zipCode,
      'currency': currency,
      'language': language,
      'points': points,
      'tier': tier,
      'status': status,
      'is_active': isActive,
    };
  }
}
