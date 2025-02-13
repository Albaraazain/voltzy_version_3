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
      url: 'http://127.0.0.1:54321',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0',
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
