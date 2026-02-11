import '../models/user_points.dart';
import '../utils/logger.dart';
import 'api_client.dart';

const _tag = 'PointsService';

class PointsService {
  final ApiClient _client;

  PointsService(this._client);

  Future<UserPoints> getUserPoints() async {
    AppLogger.info(_tag, 'getUserPoints');
    final response = await _client.get('/users/points');
    return UserPoints.fromJson(response.data['data']);
  }

  Future<UserPoints> redeemPoints(int points) async {
    AppLogger.info(_tag, 'redeemPoints: $points');
    final response = await _client.post('/users/points/redeem', data: {
      'points': points,
    });
    AppLogger.info(_tag, 'redeemPoints: success');
    return UserPoints.fromJson(response.data['data']);
  }
}
