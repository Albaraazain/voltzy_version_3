import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/logger.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthState {
  final AuthStatus status;
  final String? userId;
  final String? error;

  const AuthState({
    required this.status,
    this.userId,
    this.error,
  });

  factory AuthState.initial() {
    return const AuthState(status: AuthStatus.initial);
  }

  AuthState copyWith({
    AuthStatus? status,
    String? userId,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      userId: userId ?? this.userId,
      error: error ?? this.error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState.initial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signIn() async {
    try {
      state = state.copyWith(status: AuthStatus.loading);
      
      logger.i('Attempting anonymous sign in...');
      
      try {
        // Try anonymous sign in first
        final UserCredential userCredential = await _auth.signInAnonymously();
        final User? user = userCredential.user;

        if (user != null) {
          logger.i('Successfully signed in with uid: ${user.uid}');
          state = state.copyWith(
            status: AuthStatus.authenticated,
            userId: user.uid,
          );
          return;
        }
      } catch (e) {
        // If anonymous auth fails (e.g., not enabled), create a temporary user ID
        logger.w('Anonymous auth failed, using temporary ID: $e');
        final String tempUserId = DateTime.now().millisecondsSinceEpoch.toString();
        state = state.copyWith(
          status: AuthStatus.authenticated,
          userId: 'temp_$tempUserId',
        );
        return;
      }

      // If we get here, neither method worked
      throw Exception('Failed to authenticate user');
    } catch (e) {
      logger.e('Error during sign in: $e');
      state = state.copyWith(
        status: AuthStatus.error,
        error: e.toString(),
      );
      rethrow; // Rethrow to handle in UI
    }
  }

  Future<void> signOut() async {
    try {
      state = state.copyWith(status: AuthStatus.loading);
      logger.i('Signing out...');
      
      await _auth.signOut();
      
      logger.i('Successfully signed out');
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        userId: null,
      );
    } catch (e) {
      logger.e('Error during sign out: $e');
      state = state.copyWith(
        status: AuthStatus.error,
        error: e.toString(),
      );
      rethrow; // Rethrow to handle in UI
    }
  }

  void checkAuth() {
    logger.i('Checking authentication status...');
    final User? currentUser = _auth.currentUser;
    
    if (currentUser != null) {
      logger.i('User is authenticated with uid: ${currentUser.uid}');
      state = state.copyWith(
        status: AuthStatus.authenticated,
        userId: currentUser.uid,
      );
    } else {
      logger.i('User is not authenticated');
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        userId: null,
      );
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
