import 'package:flutter/foundation.dart';
import '../models/car_rental.dart';
import '../services/listing_service.dart';
import '../services/api_client.dart';
import '../utils/logger.dart';

const _tag = 'CarsProvider';

class CarsProvider extends ChangeNotifier {
  final ListingService _service;

  List<CarRental> _cars = [];
  CarRental? _selectedCar;
  bool _isLoading = false;
  String? _error;
  int _totalCount = 0;
  int _currentPage = 1;
  CarFilters? _currentFilters;

  CarsProvider(this._service);

  List<CarRental> get cars => _cars;
  CarRental? get selectedCar => _selectedCar;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get totalCount => _totalCount;
  bool get hasMore => _cars.length < _totalCount;

  Future<void> fetchCars([CarFilters? filters]) async {
    AppLogger.info(_tag, 'fetchCars: filters=${filters?.toQueryParams()}');
    _isLoading = true;
    _error = null;
    _currentFilters = filters;
    notifyListeners();

    try {
      final result = await _service.getCars(filters);
      _cars = result.items;
      _totalCount = result.total;
      _currentPage = result.page;
      AppLogger.info(_tag, 'fetchCars: loaded ${_cars.length} cars');
    } catch (e) {
      _error = parseError(e);
      AppLogger.error(_tag, 'fetchCars: error - $_error', e);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchNextPage() async {
    if (_isLoading || !hasMore) return;

    final nextPage = _currentPage + 1;
    AppLogger.info(_tag, 'fetchNextPage: page $nextPage');
    _isLoading = true;
    notifyListeners();

    try {
      final filters = _currentFilters ?? CarFilters();
      filters.page = nextPage;
      final result = await _service.getCars(filters);
      _cars.addAll(result.items);
      _totalCount = result.total;
      _currentPage = result.page;
      AppLogger.info(_tag, 'fetchNextPage: loaded ${result.items.length} more, total ${_cars.length}');
    } catch (e) {
      _error = parseError(e);
      AppLogger.error(_tag, 'fetchNextPage: error - $_error', e);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchCarById(int id) async {
    AppLogger.info(_tag, 'fetchCarById: $id');
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _selectedCar = await _service.getCarById(id);
      AppLogger.info(_tag, 'fetchCarById: loaded "${_selectedCar?.name}"');
    } catch (e) {
      _error = parseError(e);
      AppLogger.error(_tag, 'fetchCarById: error - $_error', e);
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
