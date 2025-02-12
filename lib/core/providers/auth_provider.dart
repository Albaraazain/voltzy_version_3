import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../repositories/auth_repository.dart';

class AuthState {
  final User? user;
  final UserType? userType;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.user,
    this.userType,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    User? user,
    UserType? userType,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      userType: userType ?? this.userType,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(const AuthState()) {
    _init();
  }

  void _init() {
    _authRepository.authStateChanges.listen((event) async {
      if (event.event == AuthChangeEvent.signedIn) {
        await _loadUserType();
      } else if (event.event == AuthChangeEvent.signedOut) {
        state = const AuthState();
      }
    });

    // Check initial auth state
    final user = _authRepository.currentUser;
    if (user != null) {
      state = state.copyWith(user: user);
      _loadUserType();
    }
  }

  Future<void> _loadUserType() async {
    try {
      final userType = await _authRepository.getCurrentUserType();
      state = state.copyWith(userType: userType);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required UserType userType,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      await _authRepository.signUp(
        email: email,
        password: password,
        userType: userType,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      await _authRepository.signIn(
        email: email,
        password: password,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> signOut() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      await _authRepository.signOut();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});
