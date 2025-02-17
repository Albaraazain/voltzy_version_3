import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/models/auth_user.dart';
import '../../../../core/utils/logger.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseAuthRepository({
    required this.auth,
    required this.firestore,
  });

  @override
  Stream<User?> get authStateChanges => auth.authStateChanges();

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      logger.i('Attempting to sign in user: $email');
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      logger.i('User signed in successfully: ${credential.user?.uid}');
      return credential;
    } on FirebaseAuthException catch (e) {
      logger.e('Sign in failed', error: e);
      throw _handleAuthError(e);
    }
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      logger.i('Attempting to create new user: $email');
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      logger.i('User created successfully: ${credential.user?.uid}');
      return credential;
    } on FirebaseAuthException catch (e) {
      logger.e('User creation failed', error: e);
      throw _handleAuthError(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      logger.i('Attempting to sign out user');
      await auth.signOut();
      logger.i('User signed out successfully');
    } catch (e) {
      logger.e('Sign out failed', error: e);
      throw Exception('Failed to sign out: $e');
    }
  }

  @override
  Future<AuthUser?> getCurrentUser() async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        logger.d('No current user found');
        return null;
      }

      logger.d('Fetching user data for: ${user.uid}');
      final doc = await firestore.collection('users').doc(user.uid).get();
      final data = doc.data();

      if (data == null) {
        logger.w('No user data found in Firestore for: ${user.uid}');
        return null;
      }

      return AuthUser(
        id: user.uid,
        email: user.email!,
        userType: data['userType'] as String,
        displayName: user.displayName,
        photoUrl: user.photoURL,
        emailVerified: user.emailVerified,
        createdAt: (data['createdAt'] as Timestamp).toDate(),
        lastLoginAt: user.metadata.lastSignInTime,
      );
    } catch (e) {
      logger.e('Failed to get current user', error: e);
      throw Exception('Failed to get current user: $e');
    }
  }

  @override
  Future<void> updateUserProfile({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    try {
      logger.i('Updating profile for user: $userId');
      await firestore.collection('users').doc(userId).update(data);
      logger.i('Profile updated successfully');
    } catch (e) {
      logger.e('Profile update failed', error: e);
      throw Exception('Failed to update profile: $e');
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      logger.i('Sending password reset email to: $email');
      await auth.sendPasswordResetEmail(email: email);
      logger.i('Password reset email sent successfully');
    } on FirebaseAuthException catch (e) {
      logger.e('Failed to send password reset email', error: e);
      throw _handleAuthError(e);
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        throw Exception('No user is currently signed in');
      }
      logger.i('Sending email verification to: ${user.email}');
      await user.sendEmailVerification();
      logger.i('Verification email sent successfully');
    } catch (e) {
      logger.e('Failed to send verification email', error: e);
      throw Exception('Failed to send verification email: $e');
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        throw Exception('No user is currently signed in');
      }
      logger.i('Deleting account for user: ${user.uid}');
      await firestore.collection('users').doc(user.uid).delete();
      await user.delete();
      logger.i('Account deleted successfully');
    } catch (e) {
      logger.e('Failed to delete account', error: e);
      throw Exception('Failed to delete account: $e');
    }
  }

  Exception _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return Exception('No user found with this email.');
      case 'wrong-password':
        return Exception('Incorrect password.');
      case 'email-already-in-use':
        return Exception('An account already exists with this email.');
      case 'invalid-email':
        return Exception('Please enter a valid email address.');
      case 'operation-not-allowed':
        return Exception('Email/password sign in is not enabled.');
      case 'weak-password':
        return Exception('Please enter a stronger password.');
      case 'too-many-requests':
        return Exception('Too many attempts. Please try again later.');
      case 'network-request-failed':
        return Exception('Network error. Please check your connection.');
      default:
        return Exception(e.message ?? 'An unknown error occurred.');
    }
  }
}
