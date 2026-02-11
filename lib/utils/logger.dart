import 'dart:developer' as developer;

class AppLogger {
  AppLogger._();

  static void debug(String tag, String message) {
    developer.log(message, name: tag, level: 500);
  }

  static void info(String tag, String message) {
    developer.log(message, name: tag, level: 800);
  }

  static void warning(String tag, String message) {
    developer.log(message, name: tag, level: 900);
  }

  static void error(String tag, String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(message, name: tag, level: 1000, error: error, stackTrace: stackTrace);
  }
}
