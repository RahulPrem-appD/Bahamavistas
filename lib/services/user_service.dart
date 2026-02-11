import '../models/user.dart';
import '../models/favorite.dart';
import '../services/api_response.dart';
import '../utils/logger.dart';
import 'api_client.dart';

const _tag = 'UserService';

class UserService {
  final ApiClient _client;

  UserService(this._client);

  Future<User> getProfile() async {
    AppLogger.info(_tag, 'getProfile');
    final response = await _client.get('/users/profile');
    return User.fromJson(response.data['data']);
  }

  Future<User> updateProfile({
    String? firstName,
    String? lastName,
    String? phone,
    String? address,
    String? city,
    String? country,
    String? zipCode,
    String? currency,
    String? language,
  }) async {
    AppLogger.info(_tag, 'updateProfile');
    final data = <String, dynamic>{};
    if (firstName != null) data['first_name'] = firstName;
    if (lastName != null) data['last_name'] = lastName;
    if (phone != null) data['phone'] = phone;
    if (address != null) data['address'] = address;
    if (city != null) data['city'] = city;
    if (country != null) data['country'] = country;
    if (zipCode != null) data['zip_code'] = zipCode;
    if (currency != null) data['currency'] = currency;
    if (language != null) data['language'] = language;

    final response = await _client.put('/users/profile', data: data);
    AppLogger.info(_tag, 'updateProfile: success');
    return User.fromJson(response.data['data']);
  }

  Future<PaginatedResponse<Favorite>> getFavorites({int page = 1, int limit = 20}) async {
    AppLogger.info(_tag, 'getFavorites: page=$page, limit=$limit');
    final response = await _client.get('/users/favorites', queryParameters: {
      'page': page,
      'limit': limit,
    });
    final data = response.data['data'];
    final favorites = (data['favorites'] as List<dynamic>?)
            ?.map((j) => Favorite.fromJson(j as Map<String, dynamic>))
            .toList() ??
        [];
    AppLogger.info(_tag, 'getFavorites: returned ${favorites.length} favorites');
    return PaginatedResponse(
      items: favorites,
      total: data['total'] as int? ?? favorites.length,
      page: data['page'] as int? ?? 1,
      limit: data['limit'] as int? ?? limit,
    );
  }

  Future<Favorite> addFavorite(int listingId, {String? notes}) async {
    AppLogger.info(_tag, 'addFavorite: listingId=$listingId');
    final response = await _client.post('/users/favorites', data: {
      'listing_id': listingId,
      if (notes != null) 'notes': notes,
    });
    AppLogger.info(_tag, 'addFavorite: success');
    return Favorite.fromJson(response.data['data']);
  }

  Future<void> removeFavorite(int favoriteId) async {
    AppLogger.info(_tag, 'removeFavorite: id=$favoriteId');
    await _client.delete('/users/favorites/$favoriteId');
    AppLogger.info(_tag, 'removeFavorite: success');
  }
}
