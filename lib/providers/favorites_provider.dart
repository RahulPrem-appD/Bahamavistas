import 'package:flutter/foundation.dart';
import '../models/favorite.dart';
import '../services/user_service.dart';
import '../services/api_client.dart';
import '../utils/logger.dart';

const _tag = 'FavoritesProvider';

class FavoritesProvider extends ChangeNotifier {
  final UserService _service;

  List<Favorite> _favorites = [];
  final Set<int> _favoriteListingIds = {};
  bool _isLoading = false;
  String? _error;

  FavoritesProvider(this._service);

  List<Favorite> get favorites => _favorites;
  List<Favorite> get stayFavorites => _favorites.where((f) => f.listingType == 'stays').toList();
  List<Favorite> get carFavorites => _favorites.where((f) => f.listingType == 'car-rental').toList();
  List<Favorite> get experienceFavorites => _favorites.where((f) => f.listingType == 'experience').toList();
  Set<int> get favoriteListingIds => _favoriteListingIds;
  bool get isLoading => _isLoading;
  String? get error => _error;

  bool isFavorite(int listingId) => _favoriteListingIds.contains(listingId);

  Future<void> fetchFavorites() async {
    AppLogger.info(_tag, 'fetchFavorites');
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _service.getFavorites(limit: 100);
      _favorites = result.items;
      _favoriteListingIds.clear();
      for (final fav in _favorites) {
        _favoriteListingIds.add(fav.listingId);
      }
      AppLogger.info(_tag, 'fetchFavorites: loaded ${_favorites.length} favorites');
    } catch (e) {
      _error = parseError(e);
      AppLogger.error(_tag, 'fetchFavorites: error - $_error', e);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavorite(int listingId) async {
    final adding = !isFavorite(listingId);
    AppLogger.info(_tag, 'toggleFavorite: listingId=$listingId, action=${adding ? 'add' : 'remove'}');
    try {
      if (!adding) {
        // Find the favorite to get its ID for deletion
        final fav = _favorites.firstWhere((f) => f.listingId == listingId);
        await _service.removeFavorite(fav.id);
        _favorites.removeWhere((f) => f.listingId == listingId);
        _favoriteListingIds.remove(listingId);
      } else {
        final fav = await _service.addFavorite(listingId);
        _favorites.add(fav);
        _favoriteListingIds.add(listingId);
      }
      AppLogger.info(_tag, 'toggleFavorite: success');
      notifyListeners();
    } catch (e) {
      _error = parseError(e);
      AppLogger.error(_tag, 'toggleFavorite: error - $_error', e);
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
