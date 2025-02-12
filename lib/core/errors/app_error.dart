class AppError implements Exception {
  final String message;
  final String context;
  final dynamic originalError;

  AppError({
    required this.message,
    required this.context,
    this.originalError,
  });

  @override
  String toString() => '$message (Context: $context)';
}
