import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:voltzy_version_3/core/navigation/app_shell.dart';
import 'package:voltzy_version_3/core/repositories/auth_repository.dart';
import 'package:voltzy_version_3/core/providers/auth_provider.dart';
import 'package:voltzy_version_3/features/auth/screens/login_screen.dart';
import 'package:voltzy_version_3/features/auth/screens/signup_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/active_jobs_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/home_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/job_details_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/profile_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/service_request_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/profile/personal_info_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/profile/addresses_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/profile/payment_methods_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/profile/notifications_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/profile/privacy_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/profile/settings_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/profile/help_screen.dart';
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
import 'package:voltzy_version_3/features/homeowner/screens/review_broadcast_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/finding_professionals_screen.dart';
import 'package:voltzy_version_3/features/homeowner/screens/service_initiation_screen.dart';

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
  final authRepository = ref.watch(authRepositoryProvider);
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    observers: [
      NavigationObserver(),
    ],
    redirect: (context, state) {
      final isLoggedIn = authState.user != null;
      final isAuthRoute =
          state.uri.path == '/login' || state.uri.path == '/register';
      final isWelcomeRoute = state.uri.path == '/';

      // Use the user type from auth provider state
      final isProfessional = authState.userType == UserType.professional;

      if (!isLoggedIn) {
        // If not logged in and not on an auth route, go to welcome screen
        if (!isAuthRoute && !isWelcomeRoute) {
          return '/';
        }
      } else {
        // If logged in and on an auth route or welcome route, redirect to appropriate dashboard
        if (isAuthRoute || isWelcomeRoute) {
          return isProfessional ? '/professional' : '/homeowner';
        }
      }

      return null;
    },
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
        builder: (context, state) => const SignupScreen(),
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
          // Home
          GoRoute(
            path: '/homeowner',
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'request-service',
                builder: (context, state) => ServiceRequestScreen(
                  categoryId: (state.extra
                      as Map<String, dynamic>)['categoryId'] as String,
                  categoryName: (state.extra
                      as Map<String, dynamic>)['categoryName'] as String,
                  categoryColor:
                      (state.extra as Map<String, dynamic>)['categoryColor']
                          as MaterialColor,
                ),
                routes: [
                  GoRoute(
                    path: 'review',
                    builder: (context, state) => ReviewBroadcastScreen(
                      categoryId: (state.extra
                          as Map<String, dynamic>)['categoryId'] as String,
                      categoryName: (state.extra
                          as Map<String, dynamic>)['categoryName'] as String,
                      issueDescription: (state.extra
                              as Map<String, dynamic>)['issueDescription']
                          as String,
                      photos: (state.extra as Map<String, dynamic>)['photos']
                          as List<String>,
                      location: (state.extra
                          as Map<String, dynamic>)['location'] as String,
                      urgency: (state.extra as Map<String, dynamic>)['urgency']
                          as String,
                      notes: (state.extra as Map<String, dynamic>)['notes']
                          as String,
                    ),
                    routes: [
                      GoRoute(
                        path: 'finding',
                        builder: (context, state) => FindingProfessionalsScreen(
                          categoryId: (state.extra
                              as Map<String, dynamic>)['categoryId'] as String,
                          categoryName: (state.extra
                                  as Map<String, dynamic>)['categoryName']
                              as String,
                        ),
                        routes: [
                          GoRoute(
                            path: 'service-initiation',
                            builder: (context, state) =>
                                ServiceInitiationScreen(
                              categoryId: (state.extra
                                      as Map<String, dynamic>)['categoryId']
                                  as String,
                              categoryName: (state.extra
                                      as Map<String, dynamic>)['categoryName']
                                  as String,
                              professional: (state.extra
                                      as Map<String, dynamic>)['professional']
                                  as Map<String, dynamic>,
                              service: (state.extra
                                      as Map<String, dynamic>)['service']
                                  as Map<String, dynamic>,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
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
            routes: [
              GoRoute(
                path: 'personal-info',
                builder: (context, state) =>
                    const HomeownerPersonalInfoScreen(),
              ),
              GoRoute(
                path: 'addresses',
                builder: (context, state) => const HomeownerAddressesScreen(),
              ),
              GoRoute(
                path: 'payment-methods',
                builder: (context, state) =>
                    const HomeownerPaymentMethodsScreen(),
              ),
              GoRoute(
                path: 'notifications',
                builder: (context, state) =>
                    const HomeownerNotificationsScreen(),
              ),
              GoRoute(
                path: 'privacy',
                builder: (context, state) => const HomeownerPrivacyScreen(),
              ),
              GoRoute(
                path: 'settings',
                builder: (context, state) => const HomeownerSettingsScreen(),
              ),
              GoRoute(
                path: 'help',
                builder: (context, state) => const HomeownerHelpScreen(),
              ),
            ],
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
