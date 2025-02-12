import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:voltzy_version_3/features/homeowner/providers/homeowner_job_providers.dart';
import 'package:voltzy_version_3/features/jobs/models/job.dart';
import 'package:voltzy_version_3/shared/widgets/loading_indicator.dart';

import 'job_stages/homeowner_at_location_view.dart';
import 'job_stages/homeowner_diagnosis_view.dart';
import 'job_stages/homeowner_en_route_view.dart';
import 'job_stages/homeowner_quote_creation_view.dart';
import 'job_stages/homeowner_in_progress_view.dart';
import 'job_stages/homeowner_completion_view.dart';

class ActiveJobsScreen extends ConsumerWidget {
  const ActiveJobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeJobsAsync = ref.watch(homeownerActiveJobsProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: activeJobsAsync.when(
                data: (jobs) => jobs.isEmpty
                    ? _buildEmptyState(context)
                    : _buildJobsList(context, jobs),
                loading: () => const LoadingIndicator(),
                error: (error, stack) => _buildErrorState(context, error, ref),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    LucideIcons.chevronLeft,
                    size: 24,
                    color: Colors.grey[800],
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
              Row(
                children: [
                  _HeaderButton(
                    icon: LucideIcons.filter,
                    onPressed: () {
                      // TODO: Implement filtering
                    },
                  ),
                  const SizedBox(width: 8),
                  _HeaderButton(
                    icon: LucideIcons.settings,
                    onPressed: () {
                      // TODO: Implement settings
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Active Services',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Track your ongoing service requests',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobsList(BuildContext context, List<Job> jobs) {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _ServiceCard(
            job: job,
            onTap: () => _navigateToJobView(context, job),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.clipboardX,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Active Services',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'You don\'t have any active services at the moment',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, Object error, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.alertTriangle,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Error Loading Services',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => ref.refresh(homeownerActiveJobsProvider),
            icon: const Icon(LucideIcons.refreshCw),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _navigateToJobView(BuildContext context, Job job) {
    final route = switch (job.stage) {
      JobStage.enRoute => MaterialPageRoute(
          builder: (context) => HomeownerEnRouteView(job: job),
        ),
      JobStage.atLocation => MaterialPageRoute(
          builder: (context) => HomeownerAtLocationView(job: job),
        ),
      JobStage.diagnosis => MaterialPageRoute(
          builder: (context) => HomeownerDiagnosisView(job: job),
        ),
      JobStage.quoteCreation => MaterialPageRoute(
          builder: (context) => HomeownerQuoteCreationView(job: job),
        ),
      JobStage.inProgress => MaterialPageRoute(
          builder: (context) => HomeownerInProgressView(job: job),
        ),
      JobStage.completion => MaterialPageRoute(
          builder: (context) => HomeownerCompletionView(job: job),
        ),
      JobStage.completed => MaterialPageRoute(
          builder: (context) => HomeownerCompletionView(job: job),
        ),
    };

    Navigator.push(context, route);
  }
}

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _HeaderButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            size: 20,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.job,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final (color, gradientColors) = _getServiceColors();
    final stepNumber = _getStepNumber();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(32),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(32),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    _getServiceIcon(),
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                job.title,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    job.stage.displayName,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                LucideIcons.clock,
                                size: 12,
                                color: Colors.grey[500],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '5 mins ago',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (job.professional != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      job.professional!.name
                                          .split(' ')
                                          .map((e) => e[0])
                                          .join(''),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      job.professional!.name,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          LucideIcons.star,
                                          size: 12,
                                          color: Colors.amber[400],
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          job.professional!.rating.toString(),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'View Details',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    LucideIcons.chevronRight,
                                    size: 12,
                                    color: Colors.grey[700],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            job.stage.displayName,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            'Step $stepNumber of 6',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Row(
                          children: [
                            Flexible(
                              flex: stepNumber,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: gradientColors,
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 6 - stepNumber,
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  (Color, List<Color>) _getServiceColors() {
    return switch (job.category?.toLowerCase() ?? 'other') {
      'electrical' => (
          Colors.pink[500]!,
          [Colors.pink[400]!, Colors.pink[300]!],
        ),
      'plumbing' => (
          Colors.blue[500]!,
          [Colors.blue[400]!, Colors.blue[300]!],
        ),
      'hvac' => (
          Colors.teal[500]!,
          [Colors.teal[400]!, Colors.teal[300]!],
        ),
      _ => (
          Colors.amber[500]!,
          [Colors.amber[400]!, Colors.amber[300]!],
        ),
    };
  }

  IconData _getServiceIcon() {
    return switch (job.category?.toLowerCase() ?? 'other') {
      'electrical' => LucideIcons.zap,
      'plumbing' => LucideIcons.droplet,
      'hvac' => LucideIcons.thermometer,
      _ => LucideIcons.wrench,
    };
  }

  int _getStepNumber() {
    return switch (job.stage) {
      JobStage.enRoute => 1,
      JobStage.atLocation => 2,
      JobStage.diagnosis => 3,
      JobStage.quoteCreation => 4,
      JobStage.inProgress => 5,
      JobStage.completion => 6,
      JobStage.completed => 6,
    };
  }
}
