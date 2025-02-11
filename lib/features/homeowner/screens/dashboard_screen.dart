import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voltzy_version_3/shared/widgets/app_bar.dart';
import 'package:voltzy_version_3/shared/widgets/buttons.dart';

class HomeownerDashboardScreen extends StatelessWidget {
  const HomeownerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VoltzyAppBar(
        title: 'Voltzy',
        showBackButton: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back!',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 8),
              Text(
                'What service do you need today?',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Request a Service',
                icon: Icons.add_circle_outline,
                onPressed: () => context.push('/homeowner/request-service'),
              ),
              const SizedBox(height: 32),
              Text(
                'Active Jobs',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _buildActiveJobs(),
              ),
              const SizedBox(height: 16),
              SecondaryButton(
                label: 'View All Jobs',
                icon: Icons.history,
                onPressed: () => context.push('/homeowner/active-jobs'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveJobs() {
    return ListView.builder(
      itemCount: 0, // TODO: Replace with actual jobs
      itemBuilder: (context, index) {
        return const Card(
          child: Placeholder(
            fallbackHeight: 100,
          ),
        );
      },
    );
  }
}
