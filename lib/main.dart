import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:voltzy_version_3/features/welcome/screens/welcome_screen.dart';
import 'app.dart';
import 'dart:developer' as developer;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  developer.log('Initializing Supabase...');

  try {
    // Initialize Supabase
    await Supabase.initialize(
      url: 'https://nushpmtzsnpbxoncpnox.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im51c2hwbXR6c25wYnhvbmNwbm94Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkzNzk5NzksImV4cCI6MjA1NDk1NTk3OX0.tfe3v0tBFrpwNQBs6H3KdbJbTVI8zJk-oXKlswxGd60',
    );

    developer.log('Supabase initialized successfully');

    // Test the connection
    final client = Supabase.instance.client;
    final response = await client.rpc(
      'get_service_categories',
      params: {'p_is_active': true},
    );
    developer.log('Successfully tested RPC connection: ${response != null}');
  } catch (e, stack) {
    developer.log('Error initializing Supabase',
        error: e, stackTrace: stack);
    // We'll still run the app, but it might not work properly
  }

  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}
