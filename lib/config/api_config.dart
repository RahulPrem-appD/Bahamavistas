import 'dart:io' show Platform;

class ApiConfig {
  static String get baseUrl {
    // Android emulator uses 10.0.2.2 to reach host localhost
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8080/api/v1';
    }
    return 'http://localhost:8080/api/v1';
  }

  static const int connectTimeout = 15000;
  static const int receiveTimeout = 15000;
  static const int defaultPageSize = 20;
}
