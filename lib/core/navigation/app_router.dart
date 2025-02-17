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
import 'package:voltzy_version_3/features/auth/screens/login_screen.dart';
import 'package:voltzy_version_3/features/auth/screens/signup_screen.dart';
import 'package:voltzy_version_3/core/navigation/app_shell.dart';
import 'package:voltzy_version_3/features/homeowner/screens/profile_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/profile/settings_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/profile/privacy_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/profile/personal_info_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/profile/payment_methods_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/profile/notifications_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/profile/addresses_screen.dart';

import '../../features/homeowner/screens/profile/personal_info_screen.dart';
import '../../features/homeowner/screens/profile/settings_screen.dart';

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
      
      // List of public routes that don't require authentication
      final isPublicRoute = isWelcomeRoute || isLoginRoute;

      if (!isAuthenticated) {
        // Redirect to welcome if trying to access authenticated routes
        return isPublicRoute ? null : '/welcome';
      }

      // Handle authenticated user trying to access public routes
      if (isAuthenticated && isPublicRoute) {
        final userType = ref.read(userTypeNotifierProvider);
        return userType == UserType.professional.name
            ? '/professional/dashboard'
            : '/homeowner';
      }

      // Allow authenticated users to access their routes
      final userType = ref.read(userTypeNotifierProvider);
      final path = state.uri.path;
      final isCorrectUserPath = userType == UserType.professional.name
          ? path.startsWith('/professional')
          : path.startsWith('/homeowner');

      if (!isCorrectUserPath) {
        return userType == UserType.professional.name
            ? '/professional/dashboard'
            : '/homeowner';
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
        builder: (context, state) {
          final Map<String, dynamic>? extra = state.extra as Map<String, dynamic>?;
          final userType = extra?['userType'] as String?;
          if (userType == null) return const WelcomeScreen();
          return LoginScreen(userType: userType);
        },
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) {
          final Map<String, dynamic>? extra = state.extra as Map<String, dynamic>?;
          final userType = extra?['userType'] as String?;
          if (userType == null) return const WelcomeScreen();
          return SignupScreen(userType: userType);
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

      // Homeowner Routes with Shell
      ShellRoute(
        builder: (context, state, child) {
          final userType = ref.read(userTypeNotifierProvider);
          return AppShell(
            child: child,
            currentPath: state.uri.path,
            isProfessional: userType == UserType.professional.name,
          );
        },
        routes: [
          // Dashboard
          GoRoute(
            path: '/homeowner',
            builder: (context, state) => const HomeScreen(),
          ),
          // Jobs
          GoRoute(
            path: '/homeowner/active-jobs',
            builder: (context, state) => const ActiveJobsScreen(),
          ),
          // Profile
          // Profile Section
          GoRoute(
            path: '/homeowner/profile',
            builder: (context, state) => const HomeownerProfileScreen(),
          ),
          GoRoute(
            path: '/homeowner/profile/settings',
            builder: (context, state) => const HomeownerSettingsScreen(),
          ),
          GoRoute(
            path: '/homeowner/profile/personal-info',
            builder: (context, state) => const HomeownerPersonalInfoScreen(),
          ),
          GoRoute(
            path: '/homeowner/profile/privacy',
            builder: (context, state) => const HomeownerPrivacyScreen(),
          ),
          GoRoute(
            path: '/homeowner/profile/payment-methods',
            builder: (context, state) => const HomeownerPaymentMethodsScreen(),
          ),
          GoRoute(
            path: '/homeowner/profile/notifications',
            builder: (context, state) => const HomeownerNotificationsScreen(),
          ),
          GoRoute(
            path: '/homeowner/profile/addresses',
            builder: (context, state) => const HomeownerAddressesScreen(),
          ),
        ],
      ),
      // Additional Homeowner Routes (outside shell)
      GoRoute(
        path: '/homeowner/category/:categoryId',
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Category Services')),
          body: Center(
            child: Text('Services for category ${state.pathParameters['categoryId']} - Coming Soon'),
          ),
        ),
      ),
      GoRoute(
        path: '/homeowner/jobs/:jobId',
        builder: (context, state) => JobDetailsScreen(
          jobId: state.pathParameters['jobId']!,
        ),
      ),
      GoRoute(
        path: '/homeowner/profile/settings',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Settings Screen - Coming Soon')),
        ),
      ),
      GoRoute(
        path: '/homeowner/profile/help',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Help & Support - Coming Soon')),
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
