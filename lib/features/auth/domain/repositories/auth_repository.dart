import 'package:firebase_auth/firebase_auth.dart';
import '../models/auth_user.dart';

/// Repository interface for authentication operations.
/// This abstraction allows for easy testing and switching of authentication providers.
abstract class AuthRepository {
  /// Stream of authentication state changes
  Stream<User?> get authStateChanges;

  /// Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Create a new user account with email and password
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Sign out the current user
  Future<void> signOut();

  /// Get the current authenticated user data
  Future<AuthUser?> getCurrentUser();

  /// Update user profile data
  Future<void> updateUserProfile({
    required String userId,
    required Map<String, dynamic> data,
  });

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email);

  /// Verify email address
  Future<void> sendEmailVerification();

  /// Delete user account
  Future<void> deleteAccount();
}
