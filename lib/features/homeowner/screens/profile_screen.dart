import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../widgets/menu_section.dart';
import '../widgets/stats_card.dart';
import 'package:go_router/go_router.dart';

class HomeownerProfileScreen extends StatelessWidget {
  const HomeownerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: const Icon(LucideIcons.chevronLeft, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 24,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),

              // Profile Info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.amber[100]!,
                            Colors.amber[50]!,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'SJ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.amber[700],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sarah Johnson',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              LucideIcons.mapPin,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '123 Main Street, Boston',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Stats Cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    HomeownerStatsCard(
                      icon: LucideIcons.history,
                      title: 'Total Services',
                      value: '12',
                      trend: 'this year',
                      gradientColors: [
                        Colors.amber[500]!,
                        Colors.amber[400]!,
                      ],
                    ),
                    const SizedBox(width: 12),
                    HomeownerStatsCard(
                      icon: LucideIcons.star,
                      title: 'Reviews Given',
                      value: '8',
                      gradientColors: [
                        Colors.blue[500]!,
                        Colors.blue[400]!,
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Account Section
              HomeownerMenuSection(
                title: 'Account',
                items: [
                  HomeownerMenuItem(
                    icon: LucideIcons.user,
                    title: 'Personal Information',
                    onTap: () =>
                        context.push('/homeowner/profile/personal-info'),
                  ),
                  HomeownerMenuItem(
                    icon: LucideIcons.mapPin,
                    title: 'Addresses',
                    value: '2 saved',
                    onTap: () => context.push('/homeowner/profile/addresses'),
                  ),
                  HomeownerMenuItem(
                    icon: LucideIcons.creditCard,
                    title: 'Payment Methods',
                    value: '••••4242',
                    onTap: () =>
                        context.push('/homeowner/profile/payment-methods'),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Preferences Section
              HomeownerMenuSection(
                title: 'Preferences',
                items: [
                  HomeownerMenuItem(
                    icon: LucideIcons.bell,
                    title: 'Notifications',
                    value: 'On',
                    onTap: () =>
                        context.push('/homeowner/profile/notifications'),
                  ),
                  HomeownerMenuItem(
                    icon: LucideIcons.shield,
                    title: 'Privacy',
                    onTap: () => context.push('/homeowner/profile/privacy'),
                  ),
                  HomeownerMenuItem(
                    icon: LucideIcons.settings,
                    title: 'App Settings',
                    onTap: () => context.push('/homeowner/profile/settings'),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Support Section
              HomeownerMenuSection(
                title: 'Support',
                items: [
                  HomeownerMenuItem(
                    icon: LucideIcons.helpCircle,
                    title: 'Help Center',
                    onTap: () => context.push('/homeowner/profile/help'),
                  ),
                  HomeownerMenuItem(
                    icon: LucideIcons.logOut,
                    title: 'Sign Out',
                    iconColor: Colors.red[500],
                    onTap: () {
                      // TODO: Implement sign out
                    },
                  ),
                ],
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
