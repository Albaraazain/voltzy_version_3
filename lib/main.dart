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

void main() async {
  // Catch any errors that occur during initialization
  try {
    WidgetsFlutterBinding.ensureInitialized();
    developer.log('Starting app initialization...');

    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    developer.log('Firebase initialized successfully');

    // Configure Firestore settings with persistence enabled
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
    developer.log('Firestore settings configured');

    // Run the app inside a try-catch to handle any initialization errors
    runApp(
      const ProviderScope(
        child: App(),
      ),
    );
    developer.log('App started successfully');
  } catch (e, stackTrace) {
    developer.log(
      'Error during app initialization',
      error: e,
      stackTrace: stackTrace,
    );
    // Re-throw the error to crash the app if initialization fails
    rethrow;
  }
}
