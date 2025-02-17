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

  developer.log('Starting app in development mode...');

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Enable offline persistence for Firestore
  await FirebaseFirestore.instance.enablePersistence();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
