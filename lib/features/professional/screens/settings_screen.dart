import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSection(
            context,
            title: 'Account',
            children: [
              _buildSettingTile(
                context,
                title: 'Personal Information',
                icon: Icons.person,
                onTap: () {
                  // TODO: Navigate to personal info screen
                },
              ),
              _buildSettingTile(
                context,
                title: 'Business Details',
                icon: Icons.business,
                onTap: () {
                  // TODO: Navigate to business details screen
                },
              ),
              _buildSettingTile(
                context,
                title: 'Bank Account',
                icon: Icons.account_balance,
                onTap: () {
                  // TODO: Navigate to bank account screen
                },
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'Preferences',
            children: [
              _buildSettingTile(
                context,
                title: 'Notifications',
                icon: Icons.notifications,
                onTap: () {
                  // TODO: Navigate to notifications settings
                },
              ),
              _buildSettingTile(
                context,
                title: 'Availability',
                icon: Icons.schedule,
                onTap: () {
                  // TODO: Navigate to availability settings
                },
              ),
              _buildSettingTile(
                context,
                title: 'Service Area',
                icon: Icons.map,
                onTap: () {
                  // TODO: Navigate to service area settings
                },
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'App Settings',
            children: [
              _buildSettingTile(
                context,
                title: 'Language',
                icon: Icons.language,
                trailing: const Text('English'),
                onTap: () {
                  // TODO: Show language picker
                },
              ),
              _buildSettingTile(
                context,
                title: 'Dark Mode',
                icon: Icons.dark_mode,
                trailing: Switch(
                  value: false, // TODO: Get from theme provider
                  onChanged: (value) {
                    // TODO: Update theme
                  },
                ),
              ),
              _buildSettingTile(
                context,
                title: 'App Version',
                icon: Icons.info,
                trailing: const Text('1.0.0'),
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'Support',
            children: [
              _buildSettingTile(
                context,
                title: 'Help Center',
                icon: Icons.help,
                onTap: () {
                  // TODO: Navigate to help center
                },
              ),
              _buildSettingTile(
                context,
                title: 'Contact Support',
                icon: Icons.support_agent,
                onTap: () {
                  // TODO: Navigate to support contact
                },
              ),
              _buildSettingTile(
                context,
                title: 'Terms of Service',
                icon: Icons.description,
                onTap: () {
                  // TODO: Show terms of service
                },
              ),
              _buildSettingTile(
                context,
                title: 'Privacy Policy',
                icon: Icons.privacy_tip,
                onTap: () {
                  // TODO: Show privacy policy
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FilledButton(
              onPressed: () {
                // TODO: Implement logout
                context.go('/');
              },
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('Logout'),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required String title,
    required IconData icon,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing:
          trailing ?? (onTap != null ? const Icon(Icons.chevron_right) : null),
      onTap: onTap,
    );
  }
}
