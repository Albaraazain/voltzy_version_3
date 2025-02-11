import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:voltzy_version_3/core/navigation/app_shell.dart';
import 'package:voltzy_version_3/features/auth/screens/login_screen.dart';
import 'package:voltzy_version_3/features/auth/screens/register_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/active_jobs_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/dashboard_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/job_details_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/profile_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/service_request_screen.dart';
import 'package:voltzy_version_3/features/professional/screens/active_job_screen.dart';
import 'package:voltzy_version_3/features/professional/screens/completed_jobs_screen.dart';
import 'package:voltzy_version_3/features/professional/screens/dashboard_screen.dart';
import 'package:voltzy_version_3/features/professional/screens/jobs_screen.dart';
import 'package:voltzy_version_3/features/professional/screens/profile_screen.dart';
import 'package:voltzy_version_3/features/professional/screens/services_screen.dart';
import 'package:voltzy_version_3/features/professional/screens/settings_screen.dart';
import 'package:voltzy_version_3/features/professional/screens/support_screen.dart';
import 'package:voltzy_version_3/features/welcome/screens/welcome_screen.dart';
import 'package:voltzy_version_3/shared/screens/messages_screen.dart';

final _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
  ),
);

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    observers: [
      NavigationObserver(),
    ],
    routes: [
      // Welcome Route (Initial Route)
      GoRoute(
        path: '/',
        builder: (context, state) => const WelcomeScreen(),
      ),

      // Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // Homeowner Routes
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(
            currentPath: state.uri.path,
            isProfessional: false,
            child: child,
          );
        },
        routes: [
          // Dashboard
          GoRoute(
            path: '/homeowner',
            builder: (context, state) => const HomeownerDashboardScreen(),
            routes: [
              GoRoute(
                path: 'request-service',
                builder: (context, state) => const ServiceRequestScreen(),
              ),
            ],
          ),
          // Active Jobs
          GoRoute(
            path: '/homeowner/active-jobs',
            builder: (context, state) => const ActiveJobsScreen(),
            routes: [
              GoRoute(
                path: 'job/:jobId',
                builder: (context, state) => JobDetailsScreen(
                  jobId: state.pathParameters['jobId']!,
                ),
              ),
            ],
          ),
          // Messages
          GoRoute(
            path: '/homeowner/messages',
            builder: (context, state) => const MessagesScreen(),
          ),
          // Profile
          GoRoute(
            path: '/homeowner/profile',
            builder: (context, state) => const HomeownerProfileScreen(),
          ),
        ],
      ),

      // Professional Routes
      ShellRoute(
        builder: (context, state, child) {
          return AppShell(
            currentPath: state.uri.path,
            isProfessional: true,
            child: child,
          );
        },
        routes: [
          // Dashboard
          GoRoute(
            path: '/professional',
            builder: (context, state) => const ProfessionalDashboardScreen(),
          ),
          // Jobs & Broadcasts
          GoRoute(
            path: '/professional/jobs',
            builder: (context, state) => const JobsScreen(),
            routes: [
              GoRoute(
                path: 'completed',
                builder: (context, state) => const CompletedJobsScreen(),
              ),
            ],
          ),
          // Active Job
          GoRoute(
            path: '/professional/jobs/active',
            builder: (context, state) => const ActiveJobScreen(),
          ),
          // Messages
          GoRoute(
            path: '/professional/messages',
            builder: (context, state) => const MessagesScreen(),
          ),
          // Profile
          GoRoute(
            path: '/professional/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          // Services
          GoRoute(
            path: '/professional/services',
            builder: (context, state) => const ServicesScreen(),
          ),
          // Settings
          GoRoute(
            path: '/professional/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
          // Support
          GoRoute(
            path: '/professional/support',
            builder: (context, state) => const SupportScreen(),
          ),
        ],
      ),
    ],
  );
});

class NavigationObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger.i('📱 Navigation Push:'
        '\n  - To: ${route.settings.name ?? "unknown"}'
        '\n  - From: ${previousRoute?.settings.name ?? "none"}'
        '\n  - Arguments: ${route.settings.arguments}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _logger.i('🔄 Navigation Replace:'
        '\n  - New: ${newRoute?.settings.name ?? "unknown"}'
        '\n  - Old: ${oldRoute?.settings.name ?? "none"}'
        '\n  - Arguments: ${newRoute?.settings.arguments}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger.i('⬅️ Navigation Pop:'
        '\n  - From: ${route.settings.name ?? "unknown"}'
        '\n  - To: ${previousRoute?.settings.name ?? "none"}'
        '\n  - Arguments: ${route.settings.arguments}');
  }
}
