import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voltzy_version_3/features/welcome/screens/welcome_screen.dart';
import 'firebase_options.dart';
import 'app.dart';
import 'dart:developer' as developer;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  developer.log('Initializing Firebase...');

  try {
    // Initialize Firebase with options
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    developer.log('Firebase initialized successfully');

    // Set up auth state listener
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        developer.log('User is signed in: ${user.uid}');
      } else {
        developer.log('User is signed out');
      }
    });

    // Test Firestore connection
    try {
      await FirebaseFirestore.instance.collection('test').get();
      developer.log('Successfully tested Firestore connection');
    } catch (e) {
      developer.log('Error testing Firestore connection', error: e);
    }

  } catch (e, stack) {
    developer.log('Error initializing Firebase',
        error: e, stackTrace: stack);
    // We'll still run the app, but it might not work properly
  }

  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}
