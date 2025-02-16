import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/firebase_repository.dart';

enum AuthStatus {
  initial,
  authenticated,
  unauthenticated,
  error,
}

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? error;
  final String? userType;
  final bool isLoading;

  const AuthState({
    required this.status,
    this.user,
    this.error,
    this.userType,
    this.isLoading = false,
  });

  factory AuthState.initial() {
    return const AuthState(status: AuthStatus.initial);
  }

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? error,
    String? userType,
    bool? isLoading,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
      userType: userType ?? this.userType,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final FirebaseRepository _repository;

  AuthNotifier(this._repository) : super(AuthState.initial()) {
    // Listen to auth state changes
    _repository.authStateChanges.listen((User? user) {
      if (user != null) {
        state = AuthState(
          status: AuthStatus.authenticated,
          user: user,
        );
      } else {
        state = const AuthState(
          status: AuthStatus.unauthenticated,
        );
      }
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      state = state.copyWith(isLoading: true);
      await _repository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        error: e.toString(),
      );
    }
  }

  Future<void> signUp({
    required String email, 
    required String password,
    required String userType,
  }) async {
    try {
      state = state.copyWith(isLoading: true);
      final credential = await _repository.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Store additional user data in Firestore
      if (credential.user != null) {
        await _repository.setUserData(credential.user!.uid, {
          'email': email,
          'createdAt': DateTime.now().toIso8601String(),
          'userType': userType,
        });
      }
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _repository.signOut();
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: e.toString(),
        isLoading: false,
      );
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(firebaseRepositoryProvider);
  return AuthNotifier(repository);
});

final userProvider = Provider<User?>((ref) {
  return ref.watch(authProvider).user;
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).status == AuthStatus.authenticated;
});
