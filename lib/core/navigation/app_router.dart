import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voltzy_version_3/features/welcome/screens/welcome_screen.dart';
import 'package:voltzy_version_3/features/auth/screens/login_screen.dart';
import '../providers/auth_provider.dart';

enum UserType {
  homeowner,
  professional;

  String get name => toString().split('.').last;
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      // Add more routes as needed
    ],
    redirect: (context, state) {
      // Handle loading state
      if (authState.isLoading) {
        return null;
      }

      // Get the current location
      final isLoggingIn = state.path == '/login';
      final isSigningUp = state.path == '/signup';
      final isWelcomePage = state.path == '/';

      // Handle unauthenticated state
      if (authState.status == AuthStatus.unauthenticated) {
        if (isWelcomePage) return null;
        return '/';
      }

      // Handle authenticated state
      if (authState.status == AuthStatus.authenticated) {
        if (isLoggingIn || isSigningUp || isWelcomePage) {
          // Redirect to appropriate dashboard based on user type
          switch (authState.userType) {
            case 'homeowner':
              return '/homeowner-dashboard';
            case 'professional':
              return '/professional-dashboard';
            default:
              return '/';
          }
        }
      }

      return null;
    },
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),
  );
});
