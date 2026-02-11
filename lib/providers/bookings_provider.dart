import 'package:flutter/foundation.dart';
import '../models/booking.dart';
import '../services/booking_service.dart';
import '../services/api_client.dart';
import '../utils/logger.dart';

const _tag = 'BookingsProvider';

class BookingsProvider extends ChangeNotifier {
  final BookingService _service;

  List<Booking> _bookings = [];
  bool _isLoading = false;
  String? _error;

  BookingsProvider(this._service);

  List<Booking> get bookings => _bookings;
  List<Booking> get upcomingBookings => _bookings.where((b) => b.isUpcoming).toList();
  List<Booking> get completedBookings => _bookings.where((b) => b.isCompleted).toList();
  List<Booking> get cancelledBookings => _bookings.where((b) => b.isCancelled).toList();
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchBookings() async {
    AppLogger.info(_tag, 'fetchBookings');
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _service.getUserBookings();
      _bookings = result.items;
      AppLogger.info(_tag, 'fetchBookings: loaded ${_bookings.length} bookings');
    } catch (e) {
      _error = parseError(e);
      AppLogger.error(_tag, 'fetchBookings: error - $_error', e);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<CreateBookingResponse?> createBooking({
    required int listingId,
    required String startDate,
    required String endDate,
    required int guests,
    int rooms = 1,
    String? couponCode,
    int? pointsToRedeem,
  }) async {
    AppLogger.info(_tag, 'createBooking: listingId=$listingId, startDate=$startDate, endDate=$endDate');
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _service.createBooking(
        listingId: listingId,
        startDate: startDate,
        endDate: endDate,
        guests: guests,
        rooms: rooms,
        couponCode: couponCode,
        pointsToRedeem: pointsToRedeem,
      );
      AppLogger.info(_tag, 'createBooking: success');
      // Refresh bookings list after creating
      await fetchBookings();
      return result;
    } catch (e) {
      _error = parseError(e);
      AppLogger.error(_tag, 'createBooking: error - $_error', e);
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  Future<bool> cancelBooking(int bookingId) async {
    AppLogger.info(_tag, 'cancelBooking: id=$bookingId');
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _service.cancelBooking(bookingId);
      AppLogger.info(_tag, 'cancelBooking: success');
      // Update local state
      final index = _bookings.indexWhere((b) => b.id == bookingId);
      if (index != -1) {
        await fetchBookings();
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = parseError(e);
      AppLogger.error(_tag, 'cancelBooking: error - $_error', e);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
