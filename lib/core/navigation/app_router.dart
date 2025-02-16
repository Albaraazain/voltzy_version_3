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
import 'dart:developer' as developer;

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
    // Add router context extension
    navigatorKey: GlobalKey<NavigatorState>(),
    redirect: (context, state) {
      developer.log(
          'Router redirect - Path: ${state.uri.path}, Auth state: ${authState.user != null}');

      final isLoggedIn = authState.user != null;
      final isAuthRoute =
          state.uri.path == '/login' || state.uri.path == '/register';
      final isWelcomeRoute = state.uri.path == '/';
      final isProfessional = authState.userType == UserType.professional;

      developer.log(
          'Router state - isLoggedIn: $isLoggedIn, isAuthRoute: $isAuthRoute, isWelcomeRoute: $isWelcomeRoute, isProfessional: $isProfessional');

      developer.log('Auth details - '
          'User: ${authState.user?.email ?? 'null'}, '
          'UserType: ${authState.userType?.name ?? 'null'}, '
          'Current path: ${state.uri.path}');

      // Not logged in - only allow welcome and auth routes
      if (!isLoggedIn) {
        developer.log('🔒 Not logged in');
        if (isWelcomeRoute || isAuthRoute) {
          developer.log('✅ Allowing access to welcome/auth screen');
          return null;
        }
        developer.log('🔄 Redirecting to welcome screen');
        return '/';
      }

      // Logged in but user type not determined yet
      if (authState.userType == null) {
        if (authState.isLoading) {
          developer.log('⏳ User type loading in progress');
          if (isWelcomeRoute) {
            developer.log('✅ Showing welcome screen while loading user type');
            return null;
          }
          developer.log('🔄 Redirecting to welcome screen while loading user type');
          return '/';
        }
        
        // If loading is complete but userType is still null, show error
        developer.log('⚠️ User type could not be determined');
        if (isWelcomeRoute) {
          developer.log('✅ Showing welcome screen with error');
          return null;
        }
        developer.log('🔄 Redirecting to welcome screen with error');
        return '/';
      }

      // Fully authenticated with user type
      if (authState.userType != null) {
        final basePath = isProfessional ? '/professional' : '/homeowner';
        developer.log('👤 User authenticated - Base path: $basePath');
        
        // If user is on welcome/auth route, redirect to their home
        if (isWelcomeRoute || isAuthRoute) {
          developer.log('🔄 User on welcome/auth route - Redirecting to home');
          return basePath;
        }

        // If user is trying to access wrong type of route, redirect
        if (isProfessional && !state.uri.path.startsWith('/professional')) {
          developer.log('🔄 Professional accessing non-professional route - Redirecting');
          return basePath;
        }
        if (!isProfessional && !state.uri.path.startsWith('/homeowner')) {
          developer.log('🔄 Homeowner accessing non-homeowner route - Redirecting');
          return basePath;
        }

        // If user is already on their home route, allow access
        if (state.uri.path == basePath) {
          developer.log('✅ User is on their home route');
          return null;
        }

        // If user is on a subroute of their home, allow access
        if (state.uri.path.startsWith(basePath)) {
          developer.log('✅ User is on a subroute of their home');
          return null;
        }

        // Fallback - redirect to home
        developer.log('🔄 Fallback - Redirecting to home');
        return basePath;
      }

      // Fallback case
      developer.log('⚠️ Fallback case - Not logged in or user type not determined');
      if (isWelcomeRoute) {
        developer.log('✅ Allowing access to welcome screen');
        return null;
      }
      developer.log('🔄 Redirecting to welcome screen');
      return '/';
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
        builder: (context, state) {
          final userTypeStr = (state.extra as Map<String, String>)['userType'];
          final userType = UserType.values.firstWhere(
            (type) => type.name == userTypeStr,
            orElse: () => UserType.homeowner,
          );
          developer.log('Login route - User type: $userType');
          return LoginScreen(userType: userType);
        },
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) {
          final userTypeStr = (state.extra as Map<String, String>)['userType'];
          final userType = UserType.values.firstWhere(
            (type) => type.name == userTypeStr,
            orElse: () => UserType.homeowner,
          );
          developer.log('Register route - User type: $userType');
          return const SignupScreen();
        },
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
