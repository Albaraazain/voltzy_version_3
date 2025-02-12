import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../errors/app_error.dart';

enum UserType { homeowner, professional, admin }

class AuthRepository {
  final SupabaseClient _client;

  AuthRepository(this._client);

  Future<void> signUp({
    required String email,
    required String password,
    required UserType userType,
  }) async {
    try {
      final AuthResponse response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'user_type': userType.name,
        },
      );

      if (response.user == null) {
        throw AppError(
          message: 'Signup failed',
          context: 'AuthRepository.signUp',
        );
      }

      await _client.rpc(
        'set_user_type',
        params: {
          'p_user_id': response.user!.id,
          'p_user_type': userType.name,
        },
      );
    } catch (e) {
      throw AppError(
        message: 'Signup failed: ${e.toString()}',
        context: 'AuthRepository.signUp',
        originalError: e,
      );
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw AppError(
          message: 'Login failed',
          context: 'AuthRepository.signIn',
        );
      }

      final userType = await getCurrentUserType();
      if (userType != null) {
        await _client.auth.updateUser(
          UserAttributes(
            data: {'user_type': userType.name},
          ),
        );
      }
    } catch (e) {
      throw AppError(
        message: 'Login failed: ${e.toString()}',
        context: 'AuthRepository.signIn',
        originalError: e,
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      throw AppError(
        message: 'Signout failed: ${e.toString()}',
        context: 'AuthRepository.signOut',
        originalError: e,
      );
    }
  }

  Future<UserType?> getCurrentUserType() async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) return null;

      final metadataType = user.userMetadata?['user_type'] as String?;
      if (metadataType != null) {
        return UserType.values.firstWhere(
          (type) => type.name == metadataType,
          orElse: () => UserType.homeowner,
        );
      }

      final response = await _client.rpc(
        'get_user_type',
        params: {'p_user_id': user.id},
      );

      final userType = UserType.values.firstWhere(
        (type) => type.name == response as String,
        orElse: () => UserType.homeowner,
      );

      await _client.auth.updateUser(
        UserAttributes(
          data: {'user_type': userType.name},
        ),
      );

      return userType;
    } catch (e) {
      throw AppError(
        message: 'Failed to get user type: ${e.toString()}',
        context: 'AuthRepository.getCurrentUserType',
        originalError: e,
      );
    }
  }

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  User? get currentUser => _client.auth.currentUser;
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(Supabase.instance.client);
});
