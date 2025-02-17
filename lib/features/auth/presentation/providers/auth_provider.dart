import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/auth_state.dart';
import '../../domain/models/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../data/repositories/firebase_auth_repository.dart';
import '../../../../core/utils/logger.dart';

/// Provider for the current authentication state
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});

/// Provider for the current user
final currentUserProvider = Provider<AuthUser?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(
    authenticated: (user) => user,
    orElse: () => null,
  );
});

/// Provider to check if user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(
    authenticated: (_) => true,
    orElse: () => false,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;
  StreamSubscription<User?>? _authStateSubscription;

  AuthNotifier(this._repository) : super(const AuthState.initial()) {
    _init();
  }

  void _init() {
    logger.i('Initializing AuthNotifier');
    _authStateSubscription = _repository.authStateChanges.listen(
      (user) => _handleAuthStateChange(user),
      onError: (error) {
        logger.e('Auth state stream error', error: error);
        state = AuthState.error(error.toString());
      },
    );
  }

  Future<void> _handleAuthStateChange(User? user) async {
    logger.i('Auth state changed - User: ${user?.email}');
    if (user == null) {
      state = const AuthState.unauthenticated();
      return;
    }

    try {
      final authUser = await _repository.getCurrentUser();
      if (authUser != null) {
        state = AuthState.authenticated(authUser);
      } else {
        state = const AuthState.unauthenticated();
      }
    } catch (e) {
      logger.e('Error getting user data', error: e);
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      state = const AuthState.loading();
      logger.i('Attempting to sign in user: $email');
      await _repository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      logger.i('Sign in successful');
    } catch (e) {
      logger.e('Sign in failed', error: e);
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String userType,
  }) async {
    try {
      state = const AuthState.loading();
      logger.i('Attempting to create new user: $email');
      final credential = await _repository.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await _repository.updateUserProfile(
          userId: credential.user!.uid,
          data: {
            'email': email,
            'userType': userType,
            'createdAt': DateTime.now(),
          },
        );
      }
      logger.i('User created successfully');
    } catch (e) {
      logger.e('Sign up failed', error: e);
      state = AuthState.error(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      state = const AuthState.loading();
      logger.i('Attempting to sign out user');
      await _repository.signOut();
      logger.i('Sign out successful');
      state = const AuthState.unauthenticated();
    } catch (e) {
      logger.e('Sign out failed', error: e);
      state = AuthState.error(e.toString());
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      state = const AuthState.loading();
      logger.i('Sending password reset email to: $email');
      await _repository.sendPasswordResetEmail(email);
      logger.i('Password reset email sent successfully');
      state = const AuthState.unauthenticated();
    } catch (e) {
      logger.e('Failed to send password reset email', error: e);
      state = AuthState.error(e.toString());
    }
  }

  Future<void> deleteAccount() async {
    try {
      state = const AuthState.loading();
      logger.i('Attempting to delete account');
      await _repository.deleteAccount();
      logger.i('Account deleted successfully');
      state = const AuthState.unauthenticated();
    } catch (e) {
      logger.e('Failed to delete account', error: e);
      state = AuthState.error(e.toString());
    }
  }

  @override
  void dispose() {
    _authStateSubscription?.cancel();
    super.dispose();
  }
}
