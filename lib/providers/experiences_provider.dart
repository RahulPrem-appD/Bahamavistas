import 'package:flutter/foundation.dart';
import '../models/experience.dart';
import '../services/listing_service.dart';
import '../services/api_client.dart';
import '../utils/logger.dart';

const _tag = 'ExperiencesProvider';

class ExperiencesProvider extends ChangeNotifier {
  final ListingService _service;

  List<Experience> _experiences = [];
  Experience? _selectedExperience;
  bool _isLoading = false;
  String? _error;
  int _totalCount = 0;
  int _currentPage = 1;
  ExperienceFilters? _currentFilters;

  ExperiencesProvider(this._service);

  List<Experience> get experiences => _experiences;
  Experience? get selectedExperience => _selectedExperience;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get totalCount => _totalCount;
  bool get hasMore => _experiences.length < _totalCount;

  Future<void> fetchExperiences([ExperienceFilters? filters]) async {
    AppLogger.info(_tag, 'fetchExperiences: filters=${filters?.toQueryParams()}');
    _isLoading = true;
    _error = null;
    _currentFilters = filters;
    notifyListeners();

    try {
      final result = await _service.getExperiences(filters);
      _experiences = result.items;
      _totalCount = result.total;
      _currentPage = result.page;
      AppLogger.info(_tag, 'fetchExperiences: loaded ${_experiences.length} experiences');
    } catch (e) {
      _error = parseError(e);
      AppLogger.error(_tag, 'fetchExperiences: error - $_error', e);
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
      final filters = _currentFilters ?? ExperienceFilters();
      filters.page = nextPage;
      final result = await _service.getExperiences(filters);
      _experiences.addAll(result.items);
      _totalCount = result.total;
      _currentPage = result.page;
      AppLogger.info(_tag, 'fetchNextPage: loaded ${result.items.length} more, total ${_experiences.length}');
    } catch (e) {
      _error = parseError(e);
      AppLogger.error(_tag, 'fetchNextPage: error - $_error', e);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchExperienceById(int id) async {
    AppLogger.info(_tag, 'fetchExperienceById: $id');
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _selectedExperience = await _service.getExperienceById(id);
      AppLogger.info(_tag, 'fetchExperienceById: loaded "${_selectedExperience?.name}"');
    } catch (e) {
      _error = parseError(e);
      AppLogger.error(_tag, 'fetchExperienceById: error - $_error', e);
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
