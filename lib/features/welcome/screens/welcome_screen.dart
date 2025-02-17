import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/utils/logger.dart';
import '../../../features/auth/domain/models/user_type.dart';
import '../../../features/auth/providers/user_type_provider.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        color: colorScheme.surface,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'assets/logo.png',
                      width: 160,
                      height: 160,
                    ),
                  ),
                  const SizedBox(height: 32),
                  TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 800),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          style: textTheme.headlineMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                          textAlign: TextAlign.center,
                          child: const Text('Welcome to Voltzy'),
                        ),
                        const SizedBox(height: 8),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          style: textTheme.titleMedium!.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                          textAlign: TextAlign.center,
                          child: const Text('Choose your role to get started'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  _buildRoleCard(
                    context: context,
                    title: 'Professional',
                    description: 'I provide electrical services',
                    icon: Icons.work,
                    color: const Color(0xFF6C63FF),
                    onTap: () {
                      logger.i('Professional role card tapped');
                      ref.read(userTypeNotifierProvider.notifier)
                          .setUserType(UserType.professional.name);
                      context.go('/login', extra: {
                        'userType': UserType.professional.name
                      });
                    },
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(height: 24),
                  _buildRoleCard(
                    context: context,
                    title: 'Homeowner',
                    description: 'I need electrical services',
                    icon: Icons.home,
                    color: const Color(0xFFFF6584),
                    onTap: () {
                      logger.i('Homeowner role card tapped');
                      ref.read(userTypeNotifierProvider.notifier)
                          .setUserType(UserType.homeowner.name);
                      context.go('/login', extra: {
                        'userType': UserType.homeowner.name
                      });
                    },
                    colorScheme: colorScheme,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required ColorScheme colorScheme,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 200),
        tween: Tween(begin: 1.0, end: 0.95),
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: child,
          );
        },
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: colorScheme.outline.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: color,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          description,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: color,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
