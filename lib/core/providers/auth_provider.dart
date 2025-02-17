import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      
      // Sign in anonymously to maintain the same UX flow
      final UserCredential userCredential = await _auth.signInAnonymously();
      final User? user = userCredential.user;

      if (user != null) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          userId: user.uid,
        );
      } else {
        throw Exception('Failed to sign in anonymously');
      }
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: e.toString(),
      );
    }
  }

  Future<void> signOut() async {
    try {
      state = state.copyWith(status: AuthStatus.loading);
      await _auth.signOut();
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        userId: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: e.toString(),
      );
    }
  }

  void checkAuth() {
    final User? currentUser = _auth.currentUser;
    
    if (currentUser != null) {
      state = state.copyWith(
        status: AuthStatus.authenticated,
        userId: currentUser.uid,
      );
    } else {
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
