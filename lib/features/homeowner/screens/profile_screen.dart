import 'package:flutter/material.dart';
import 'package:voltzy_version_3/shared/widgets/app_bar.dart';

class HomeownerProfileScreen extends StatelessWidget {
  const HomeownerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(24),
                child: VoltzyPageHeader(
                  title: 'Profile',
                  subtitle: 'Manage your account',
                ),
              ),
              // Profile Header
              Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      // TODO: Add profile image
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'John Doe',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      'Homeowner',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Account Settings
              Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Settings',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    _buildSettingsTile(
                      context,
                      icon: Icons.person,
                      title: 'Personal Information',
                      onTap: () {
                        // TODO: Navigate to personal info
                      },
                    ),
                    _buildSettingsTile(
                      context,
                      icon: Icons.location_on,
                      title: 'Addresses',
                      onTap: () {
                        // TODO: Navigate to addresses
                      },
                    ),
                    _buildSettingsTile(
                      context,
                      icon: Icons.payment,
                      title: 'Payment Methods',
                      onTap: () {
                        // TODO: Navigate to payment methods
                      },
                    ),
                    _buildSettingsTile(
                      context,
                      icon: Icons.notifications,
                      title: 'Notifications',
                      onTap: () {
                        // TODO: Navigate to notifications
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Support
              Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Support',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    _buildSettingsTile(
                      context,
                      icon: Icons.help,
                      title: 'Help Center',
                      onTap: () {
                        // TODO: Navigate to help center
                      },
                    ),
                    _buildSettingsTile(
                      context,
                      icon: Icons.privacy_tip,
                      title: 'Privacy Policy',
                      onTap: () {
                        // TODO: Navigate to privacy policy
                      },
                    ),
                    _buildSettingsTile(
                      context,
                      icon: Icons.description,
                      title: 'Terms of Service',
                      onTap: () {
                        // TODO: Navigate to terms
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80), // Space for bottom navigation
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
