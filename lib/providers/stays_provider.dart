import 'package:flutter/foundation.dart';
import '../models/stay.dart';
import '../services/listing_service.dart';
import '../services/api_client.dart';
import '../utils/logger.dart';

const _tag = 'StaysProvider';

class StaysProvider extends ChangeNotifier {
  final ListingService _service;

  List<Stay> _stays = [];
  Stay? _selectedStay;
  bool _isLoading = false;
  String? _error;
  int _totalCount = 0;
  int _currentPage = 1;
  StayFilters? _currentFilters;

  StaysProvider(this._service);

  List<Stay> get stays => _stays;
  Stay? get selectedStay => _selectedStay;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get totalCount => _totalCount;
  bool get hasMore => _stays.length < _totalCount;

  Future<void> fetchStays([StayFilters? filters]) async {
    AppLogger.info(_tag, 'fetchStays: filters=${filters?.toQueryParams()}');
    _isLoading = true;
    _error = null;
    _currentFilters = filters;
    notifyListeners();

    try {
      final result = await _service.getStays(filters);
      _stays = result.items;
      _totalCount = result.total;
      _currentPage = result.page;
      AppLogger.info(_tag, 'fetchStays: loaded ${_stays.length} stays');
    } catch (e) {
      _error = parseError(e);
      AppLogger.error(_tag, 'fetchStays: error - $_error', e);
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
      final filters = _currentFilters ?? StayFilters();
      filters.page = nextPage;
      final result = await _service.getStays(filters);
      _stays.addAll(result.items);
      _totalCount = result.total;
      _currentPage = result.page;
      AppLogger.info(_tag, 'fetchNextPage: loaded ${result.items.length} more, total ${_stays.length}');
    } catch (e) {
      _error = parseError(e);
      AppLogger.error(_tag, 'fetchNextPage: error - $_error', e);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchStayById(int id) async {
    AppLogger.info(_tag, 'fetchStayById: $id');
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _selectedStay = await _service.getStayById(id);
      AppLogger.info(_tag, 'fetchStayById: loaded "${_selectedStay?.name}"');
    } catch (e) {
      _error = parseError(e);
      AppLogger.error(_tag, 'fetchStayById: error - $_error', e);
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
