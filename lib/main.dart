import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://nushpmtzsnpbxoncpnox.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im51c2hwbXR6c25wYnhvbmNwbm94Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkzNzk5NzksImV4cCI6MjA1NDk1NTk3OX0.tfe3v0tBFrpwNQBs6H3KdbJbTVI8zJk-oXKlswxGd60',
  );

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
