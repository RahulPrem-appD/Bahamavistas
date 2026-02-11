import '../models/booking.dart';
import '../services/api_response.dart';
import '../utils/logger.dart';
import 'api_client.dart';

const _tag = 'BookingService';

class BookingService {
  final ApiClient _client;

  BookingService(this._client);

  Future<PaginatedResponse<Booking>> getUserBookings({int page = 1, int limit = 20}) async {
    AppLogger.info(_tag, 'getUserBookings: page=$page, limit=$limit');
    final response = await _client.get('/bookings', queryParameters: {
      'page': page,
      'limit': limit,
    });
    final data = response.data['data'];
    final bookings = (data['bookings'] as List<dynamic>?)
            ?.map((j) => Booking.fromJson(j as Map<String, dynamic>))
            .toList() ??
        [];
    AppLogger.info(_tag, 'getUserBookings: returned ${bookings.length} bookings');
    return PaginatedResponse(
      items: bookings,
      total: data['total'] as int? ?? bookings.length,
      page: data['page'] as int? ?? 1,
      limit: data['limit'] as int? ?? limit,
    );
  }

  Future<CreateBookingResponse> createBooking({
    required int listingId,
    required String startDate,
    required String endDate,
    required int guests,
    int rooms = 1,
    String? couponCode,
    int? pointsToRedeem,
  }) async {
    AppLogger.info(_tag, 'createBooking: listingId=$listingId');
    final response = await _client.post('/bookings', data: {
      'listing_id': listingId,
      'start_date': startDate,
      'end_date': endDate,
      'guests': guests,
      'rooms': rooms,
      if (couponCode != null) 'coupon_code': couponCode,
      if (pointsToRedeem != null) 'points_to_redeem': pointsToRedeem,
    });
    AppLogger.info(_tag, 'createBooking: success');
    return CreateBookingResponse.fromJson(response.data['data']);
  }

  Future<void> cancelBooking(int bookingId) async {
    AppLogger.info(_tag, 'cancelBooking: id=$bookingId');
    await _client.post('/bookings/$bookingId/cancel');
    AppLogger.info(_tag, 'cancelBooking: success');
  }
}
