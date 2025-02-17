import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  Future<void> signIn() async {
    try {
      state = state.copyWith(status: AuthStatus.loading);
      // TODO: Implement actual authentication
      await Future.delayed(const Duration(seconds: 1));
      state = state.copyWith(
        status: AuthStatus.authenticated,
        userId: 'test-user-id',
      );
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
      // TODO: Implement actual sign out
      await Future.delayed(const Duration(milliseconds: 500));
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
    // TODO: Implement auth state check
    state = state.copyWith(status: AuthStatus.unauthenticated);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
