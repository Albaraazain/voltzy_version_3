import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voltzy_version_3/core/config/app_theme.dart';
import 'package:voltzy_version_3/core/navigation/app_router.dart';
import 'package:voltzy_version_3/core/providers/auth_provider.dart';
import 'package:voltzy_version_3/core/repositories/auth_repository.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final authState = ref.watch(authProvider);
    final isProfessional = authState.userType == UserType.professional;
    final theme = ref.watch(
        isProfessional ? professionalThemeProvider : homeownerThemeProvider);

    return MaterialApp.router(
      title: 'Voltzy',
      theme: theme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
