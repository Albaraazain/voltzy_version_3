import 'package:logger/logger.dart';

/// Global logger instance with pretty printer configuration
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
  level: Level.debug,
);

/// Extension methods for easier logging
extension LoggerExtension on Logger {
  /// Log a debug message
  void d(String message, [dynamic error, StackTrace? stackTrace]) {
    this.d(message, error: error, stackTrace: stackTrace);
  }

  /// Log an info message
  void i(String message, [dynamic error, StackTrace? stackTrace]) {
    this.i(message, error: error, stackTrace: stackTrace);
  }

  /// Log a warning message
  void w(String message, [dynamic error, StackTrace? stackTrace]) {
    this.w(message, error: error, stackTrace: stackTrace);
  }

  /// Log an error message
  void e(String message, {dynamic error, StackTrace? stackTrace}) {
    this.e(message, error: error, stackTrace: stackTrace);
  }
}
