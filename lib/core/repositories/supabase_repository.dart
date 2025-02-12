import 'package:supabase_flutter/supabase_flutter.dart';
import '../errors/app_error.dart';

abstract class SupabaseRepository {
  final SupabaseClient client;

  SupabaseRepository(this.client);

  Future<void> logError(String message, String context,
      {Map<String, dynamic>? additionalData}) async {
    try {
      await client.rpc(
        'handle_error',
        params: {
          'p_error_message': message,
          'p_context': context,
          'p_additional_data': additionalData,
        },
      );
    } catch (e) {
      // If error logging fails, print to console at minimum
      print('Failed to log error: $e');
    }
  }

  Future<T> handleError<T>(
      Future<T> Function() operation, String context) async {
    try {
      return await operation();
    } on PostgrestException catch (e) {
      await logError(e.message, context, additionalData: {'code': e.code});
      throw AppError(message: 'Database error: ${e.message}', context: context);
    } on AuthException catch (e) {
      await logError(e.message, context);
      throw AppError(
          message: 'Authentication error: ${e.message}', context: context);
    } catch (e) {
      await logError(e.toString(), context);
      throw AppError(message: 'Unexpected error: $e', context: context);
    }
  }
}
