import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/navigation/app_router.dart' as router;
import 'core/providers/auth_provider.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
    // Initialize auth state
    Future.microtask(() {
      ref.read(authProvider.notifier).checkAuth();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch auth state for changes
    final authState = ref.watch(authProvider);
    
    return MaterialApp.router(
      title: 'Voltzy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: ref.watch(router.routerProvider),
    );
  }
}
