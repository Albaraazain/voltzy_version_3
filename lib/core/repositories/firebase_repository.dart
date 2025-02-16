import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:typed_data';

final firebaseRepositoryProvider = Provider<FirebaseRepository>((ref) {
  return FirebaseRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
    storage: FirebaseStorage.instance,
  );
});

class FirebaseRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  FirebaseRepository({
    required this.auth,
    required this.firestore,
    required this.storage,
  });

  // Auth Methods
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e);
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  // Firestore Methods
  Future<void> setUserData(String uid, Map<String, dynamic> data) async {
    try {
      await firestore.collection('users').doc(uid).set(data);
    } on FirebaseException catch (e) {
      throw Exception('Failed to set user data: ${e.message}');
    }
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    try {
      final doc = await firestore.collection('users').doc(uid).get();
      return doc.data();
    } on FirebaseException catch (e) {
      throw Exception('Failed to get user data: ${e.message}');
    }
  }

  // Storage Methods
  Future<String> uploadFile(String path, Uint8List bytes) async {
    try {
      final ref = storage.ref().child(path);
      await ref.putData(bytes);
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      throw Exception('Failed to upload file: ${e.message}');
    }
  }

  // Error Handling
  Exception _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return Exception('No user found for that email.');
      case 'wrong-password':
        return Exception('Wrong password provided.');
      case 'email-already-in-use':
        return Exception('The email address is already in use.');
      case 'invalid-email':
        return Exception('The email address is invalid.');
      case 'operation-not-allowed':
        return Exception('Email/password accounts are not enabled.');
      case 'weak-password':
        return Exception('The password is too weak.');
      default:
        return Exception(e.message ?? 'An unknown error occurred.');
    }
  }

  // Stream of auth state changes
  Stream<User?> get authStateChanges => auth.authStateChanges();
}
