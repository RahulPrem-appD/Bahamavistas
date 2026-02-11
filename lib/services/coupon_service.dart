import '../utils/logger.dart';
import 'api_client.dart';

const _tag = 'CouponService';

class CouponValidation {
  final bool valid;
  final String? code;
  final String? discountType;
  final double? discountValue;
  final String? message;

  CouponValidation({
    required this.valid,
    this.code,
    this.discountType,
    this.discountValue,
    this.message,
  });

  factory CouponValidation.fromJson(Map<String, dynamic> json) {
    return CouponValidation(
      valid: json['valid'] as bool? ?? false,
      code: json['code'] as String?,
      discountType: json['discount_type'] as String?,
      discountValue: (json['discount_value'] as num?)?.toDouble(),
      message: json['message'] as String?,
    );
  }
}

class CouponService {
  final ApiClient _client;

  CouponService(this._client);

  Future<CouponValidation> validateCoupon(String code, {int? listingId}) async {
    AppLogger.info(_tag, 'validateCoupon: code=$code, listingId=$listingId');
    final response = await _client.post('/coupons/validate', data: {
      'code': code,
      if (listingId != null) 'listing_id': listingId,
    });
    final result = CouponValidation.fromJson(response.data['data']);
    AppLogger.info(_tag, 'validateCoupon: valid=${result.valid}');
    return result;
  }
}
