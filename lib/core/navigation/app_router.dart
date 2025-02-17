import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voltzy_version_3/features/welcome/screens/welcome_screen.dart';
import 'package:voltzy_version_3/features/professional/screens/dashboard_screen.dart';
import 'package:voltzy_version_3/features/professional/screens/jobs_screen.dart';
import 'package:voltzy_version_3/features/professional/screens/active_job_screen.dart';
import 'package:voltzy_version_3/features/professional/screens/job_requests_screen.dart';
import 'package:voltzy_version_3/features/professional/screens/completed_jobs_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/home_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/active_jobs_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/job_details_screen.dart';
import 'package:voltzy_version_3/core/providers/auth_provider.dart';
import 'package:voltzy_version_3/features/auth/domain/models/user_type.dart';
import 'package:voltzy_version_3/features/auth/providers/user_type_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/welcome',
    redirect: (context, state) {
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final isInitializing = authState.status == AuthStatus.initial;
      
      // Don't redirect while initializing
      if (isInitializing) return null;

      final isWelcomeRoute = state.uri.path == '/welcome';
      final isLoginRoute = state.uri.path == '/login';
      
      // If not authenticated, only allow welcome and login routes
      if (!isAuthenticated) {
        if (!isWelcomeRoute && !isLoginRoute) {
          return '/welcome';
        }
        return null;
      }

      // If authenticated, don't allow welcome or login routes
      if (isAuthenticated && (isWelcomeRoute || isLoginRoute)) {
        final userType = ref.read(userTypeNotifierProvider);
        return userType == UserType.professional.name
            ? '/professional/dashboard'
            : '/homeowner/home';
      }

      return null;
    },
    routes: [
      // Root route redirects to welcome
      GoRoute(
        path: '/',
        redirect: (_, __) => '/welcome',
      ),
      // Welcome & Auth
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/login',
        redirect: (context, state) {
          final Map<String, dynamic>? extra = state.extra as Map<String, dynamic>?;
          final userType = extra?['userType'] as String?;
          if (userType == UserType.professional.name) {
            return '/professional/dashboard';
          } else if (userType == UserType.homeowner.name) {
            return '/homeowner/home';
          }
          return '/welcome';
        },
      ),

      // Professional Routes
      GoRoute(
        path: '/professional/dashboard',
        builder: (context, state) => const ProfessionalDashboardScreen(),
      ),
      GoRoute(
        path: '/professional/jobs',
        builder: (context, state) => const JobsScreen(),
      ),
      GoRoute(
        path: '/professional/jobs/active',
        builder: (context, state) => const ActiveJobScreen(),
      ),
      GoRoute(
        path: '/professional/jobs/requests',
        builder: (context, state) => const JobRequestsScreen(),
      ),
      GoRoute(
        path: '/professional/jobs/completed',
        builder: (context, state) => const CompletedJobsScreen(),
      ),

      // Homeowner Routes
      GoRoute(
        path: '/homeowner/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/homeowner/jobs/active',
        builder: (context, state) => const ActiveJobsScreen(),
      ),
      GoRoute(
        path: '/homeowner/jobs/:jobId',
        builder: (context, state) => JobDetailsScreen(
          jobId: state.pathParameters['jobId']!,
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),
  );
});
