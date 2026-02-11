import '../models/stay.dart';
import '../models/car_rental.dart';
import '../models/experience.dart';
import '../models/review.dart';
import '../services/api_response.dart';
import '../config/api_config.dart';
import '../utils/logger.dart';
import 'api_client.dart';

const _tag = 'ListingService';

class StayFilters {
  String? search;
  String? island;
  double? minPrice;
  double? maxPrice;
  double? minRating;
  bool? verified;
  String? sortBy;
  int page;
  int limit;

  StayFilters({
    this.search,
    this.island,
    this.minPrice,
    this.maxPrice,
    this.minRating,
    this.verified,
    this.sortBy,
    this.page = 1,
    this.limit = ApiConfig.defaultPageSize,
  });

  Map<String, dynamic> toQueryParams() {
    final params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    if (search != null && search!.isNotEmpty) params['search'] = search;
    if (island != null && island!.isNotEmpty) params['island'] = island;
    if (minPrice != null) params['min_price'] = minPrice;
    if (maxPrice != null) params['max_price'] = maxPrice;
    if (minRating != null) params['min_rating'] = minRating;
    if (verified == true) params['verified'] = true;
    if (sortBy != null) params['sort'] = sortBy;
    return params;
  }
}

class CarFilters {
  String? search;
  String? vehicleType;
  double? minPrice;
  double? maxPrice;
  String? transmission;
  int page;
  int limit;

  CarFilters({
    this.search,
    this.vehicleType,
    this.minPrice,
    this.maxPrice,
    this.transmission,
    this.page = 1,
    this.limit = ApiConfig.defaultPageSize,
  });

  Map<String, dynamic> toQueryParams() {
    final params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    if (search != null && search!.isNotEmpty) params['search'] = search;
    if (vehicleType != null) params['vehicle_type'] = vehicleType;
    if (minPrice != null) params['min_price'] = minPrice;
    if (maxPrice != null) params['max_price'] = maxPrice;
    if (transmission != null) params['transmission'] = transmission;
    return params;
  }
}

class ExperienceFilters {
  String? search;
  String? activityType;
  double? minPrice;
  double? maxPrice;
  double? minRating;
  int page;
  int limit;

  ExperienceFilters({
    this.search,
    this.activityType,
    this.minPrice,
    this.maxPrice,
    this.minRating,
    this.page = 1,
    this.limit = ApiConfig.defaultPageSize,
  });

  Map<String, dynamic> toQueryParams() {
    final params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    if (search != null && search!.isNotEmpty) params['search'] = search;
    if (activityType != null) params['activity_type'] = activityType;
    if (minPrice != null) params['min_price'] = minPrice;
    if (maxPrice != null) params['max_price'] = maxPrice;
    if (minRating != null) params['min_rating'] = minRating;
    return params;
  }
}

class ListingService {
  final ApiClient _client;

  ListingService(this._client);

  // Stays
  Future<PaginatedResponse<Stay>> getStays([StayFilters? filters]) async {
    final params = filters?.toQueryParams() ?? {'page': 1, 'limit': ApiConfig.defaultPageSize};
    AppLogger.info(_tag, 'getStays: params=$params');
    final response = await _client.get('/stays', queryParameters: params);
    final data = response.data['data'];
    final listings = (data['listings'] as List<dynamic>?)
            ?.map((j) => Stay.fromJson(j as Map<String, dynamic>))
            .toList() ??
        [];
    AppLogger.info(_tag, 'getStays: returned ${listings.length} stays');
    return PaginatedResponse(
      items: listings,
      total: data['total'] as int? ?? listings.length,
      page: data['page'] as int? ?? 1,
      limit: data['limit'] as int? ?? ApiConfig.defaultPageSize,
    );
  }

  Future<Stay> getStayById(int id) async {
    AppLogger.info(_tag, 'getStayById: $id');
    final response = await _client.get('/stays/$id');
    return Stay.fromJson(response.data['data']);
  }

  // Cars
  Future<PaginatedResponse<CarRental>> getCars([CarFilters? filters]) async {
    final params = filters?.toQueryParams() ?? {'page': 1, 'limit': ApiConfig.defaultPageSize};
    AppLogger.info(_tag, 'getCars: params=$params');
    final response = await _client.get('/cars', queryParameters: params);
    final data = response.data['data'];
    final listings = (data['listings'] as List<dynamic>?)
            ?.map((j) => CarRental.fromJson(j as Map<String, dynamic>))
            .toList() ??
        [];
    AppLogger.info(_tag, 'getCars: returned ${listings.length} cars');
    return PaginatedResponse(
      items: listings,
      total: data['total'] as int? ?? listings.length,
      page: data['page'] as int? ?? 1,
      limit: data['limit'] as int? ?? ApiConfig.defaultPageSize,
    );
  }

  Future<CarRental> getCarById(int id) async {
    AppLogger.info(_tag, 'getCarById: $id');
    final response = await _client.get('/cars/$id');
    return CarRental.fromJson(response.data['data']);
  }

  // Experiences
  Future<PaginatedResponse<Experience>> getExperiences([ExperienceFilters? filters]) async {
    final params = filters?.toQueryParams() ?? {'page': 1, 'limit': ApiConfig.defaultPageSize};
    AppLogger.info(_tag, 'getExperiences: params=$params');
    final response = await _client.get('/experiences', queryParameters: params);
    final data = response.data['data'];
    final listings = (data['listings'] as List<dynamic>?)
            ?.map((j) => Experience.fromJson(j as Map<String, dynamic>))
            .toList() ??
        [];
    AppLogger.info(_tag, 'getExperiences: returned ${listings.length} experiences');
    return PaginatedResponse(
      items: listings,
      total: data['total'] as int? ?? listings.length,
      page: data['page'] as int? ?? 1,
      limit: data['limit'] as int? ?? ApiConfig.defaultPageSize,
    );
  }

  Future<Experience> getExperienceById(int id) async {
    AppLogger.info(_tag, 'getExperienceById: $id');
    final response = await _client.get('/experiences/$id');
    return Experience.fromJson(response.data['data']);
  }

  // Reviews
  Future<PaginatedResponse<Review>> getListingReviews(int listingId, {int page = 1, int limit = 20}) async {
    AppLogger.info(_tag, 'getListingReviews: listingId=$listingId, page=$page');
    final response = await _client.get('/listings/$listingId/reviews', queryParameters: {
      'page': page,
      'limit': limit,
    });
    final data = response.data['data'];
    final reviews = (data['reviews'] as List<dynamic>?)
            ?.map((j) => Review.fromJson(j as Map<String, dynamic>))
            .toList() ??
        [];
    AppLogger.info(_tag, 'getListingReviews: returned ${reviews.length} reviews');
    return PaginatedResponse(
      items: reviews,
      total: data['total'] as int? ?? reviews.length,
      page: data['page'] as int? ?? 1,
      limit: data['limit'] as int? ?? limit,
    );
  }
}
