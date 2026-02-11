import '../models/review.dart';
import '../utils/logger.dart';
import 'api_client.dart';

const _tag = 'ReviewService';

class ReviewService {
  final ApiClient _client;

  ReviewService(this._client);

  Future<Review> createReview({
    required int listingId,
    required int rating,
    String? title,
    required String comment,
    String? travelerType,
  }) async {
    AppLogger.info(_tag, 'createReview: listingId=$listingId, rating=$rating');
    final response = await _client.post('/reviews', data: {
      'listing_id': listingId,
      'rating': rating,
      if (title != null) 'title': title,
      'comment': comment,
      if (travelerType != null) 'traveler_type': travelerType,
    });
    AppLogger.info(_tag, 'createReview: success');
    return Review.fromJson(response.data['data']);
  }
}
