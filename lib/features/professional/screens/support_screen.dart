import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupportScreen extends ConsumerWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            title: 'Common Issues',
            children: [
              _buildFaqItem(
                context,
                question: 'How do I update my availability?',
                answer:
                    'Go to Settings > Preferences > Availability to update your working hours and days.',
              ),
              _buildFaqItem(
                context,
                question: 'How do payments work?',
                answer:
                    'Payments are processed automatically after job completion. Funds are transferred to your linked bank account within 2-3 business days.',
              ),
              _buildFaqItem(
                context,
                question: 'What if I need to cancel a job?',
                answer:
                    'If you need to cancel a job, please do so at least 2 hours before the scheduled time. Frequent cancellations may affect your rating.',
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'Contact Support',
            children: [
              _buildContactOption(
                context,
                icon: Icons.chat,
                title: 'Live Chat',
                subtitle: 'Chat with our support team',
                onTap: () {
                  // TODO: Implement live chat
                },
              ),
              _buildContactOption(
                context,
                icon: Icons.phone,
                title: 'Phone Support',
                subtitle: '1-800-VOLTZY',
                onTap: () {
                  // TODO: Implement phone call
                },
              ),
              _buildContactOption(
                context,
                icon: Icons.email,
                title: 'Email Support',
                subtitle: 'support@voltzy.com',
                onTap: () {
                  // TODO: Implement email
                },
              ),
            ],
          ),
          _buildSection(
            context,
            title: 'Resources',
            children: [
              _buildResourceTile(
                context,
                icon: Icons.school,
                title: 'Training Videos',
                onTap: () {
                  // TODO: Navigate to training videos
                },
              ),
              _buildResourceTile(
                context,
                icon: Icons.article,
                title: 'User Guide',
                onTap: () {
                  // TODO: Show user guide
                },
              ),
              _buildResourceTile(
                context,
                icon: Icons.policy,
                title: 'Safety Guidelines',
                onTap: () {
                  // TODO: Show safety guidelines
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          Center(
            child: Column(
              children: [
                Text(
                  'Need immediate assistance?',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                FilledButton.icon(
                  onPressed: () {
                    // TODO: Implement emergency support
                  },
                  icon: const Icon(Icons.emergency),
                  label: const Text('Contact Emergency Support'),
                ),
              ],
            ),
          ),
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
          padding: const EdgeInsets.symmetric(vertical: 16),
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

  Widget _buildFaqItem(
    BuildContext context, {
    required String question,
    required String answer,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(
          question,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget _buildResourceTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
