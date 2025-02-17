import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/professional_dashboard_providers.dart';
import '../models/job_request.dart' as request;
import '../models/metric.dart';
import '../../jobs/models/job.dart';
import 'package:voltzy_version_3/shared/widgets/app_bar.dart';
import 'package:voltzy_version_3/shared/widgets/stat_card.dart';
import 'package:voltzy_version_3/shared/widgets/transaction_card.dart';

class ProfessionalDashboardScreen extends ConsumerWidget {
  const ProfessionalDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final onlineStatus = ref.watch(onlineStatusProvider);
    final activeJob = ref.watch(activeJobProvider);
    final jobRequests = ref.watch(jobRequestsProvider);
    final totalEarnings = 285.00; // Hardcoded for now

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 4,
                      width: 24,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          ref.read(onlineStatusProvider.notifier).toggle(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: onlineStatus
                              ? Colors.green[50]
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          onlineStatus ? 'Online' : 'Offline',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: onlineStatus
                                ? Colors.green[700]
                                : Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Welcome Text
                Text(
                  'Welcome back, John!',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You have 3 new requests nearby',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),

                // Metrics
                ref.watch(dashboardMetricsProvider).when(
                      data: (metrics) => GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.5,
                        children: metrics
                            .map((metric) => _buildMetricCard(context, metric))
                            .toList(),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (error, stack) => Center(
                        child: Text('Error: $error'),
                      ),
                    ),
                const SizedBox(height: 32),

                // Active Job
                Text(
                  'Active Job',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ref.watch(activeJobProvider).when(
                      data: (job) => job != null
                          ? _buildActiveJobCard(context, job)
                          : _buildNoActiveJobCard(context),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (error, stack) => Center(
                        child: Text('Error: $error'),
                      ),
                    ),
                const SizedBox(height: 32),

                // New Requests
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'New Requests',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ref.watch(jobRequestsProvider).when(
                      data: (requests) => Column(
                        children: requests
                            .map((req) => _buildJobRequestCard(
                                context, req as request.JobRequest))
                            .toList(),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (error, stack) => Center(
                        child: Text('Error: $error'),
                      ),
                    ),
                const SizedBox(height: 100), // Space for bottom navigation
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(BuildContext context, Metric metric) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color backgroundColor;
    Color iconColor;
    if (metric.backgroundColor == 'pink') {
      backgroundColor = colorScheme.primary.withOpacity(0.1);
      iconColor = colorScheme.primary;
    } else {
      backgroundColor = colorScheme.secondary.withOpacity(0.1);
      iconColor = colorScheme.secondary;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                metric.title,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  metric.backgroundColor == 'pink'
                      ? Icons.trending_up
                      : Icons.notifications_none,
                  size: 20,
                  color: iconColor,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                metric.value,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (metric.trend != null)
                Row(
                  children: [
                    Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    Text(
                      metric.trend!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveJobCard(BuildContext context, Job job) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () => context.go('/professional/jobs/active'),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary,
              colorScheme.primary.withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Background pattern
              Positioned(
                right: -20,
                top: -20,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with stage and urgency
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _getStageIcon(job.stage),
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                job.stage.displayName,
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: job.urgency.color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            job.urgency.displayName,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Job title and description
                    Text(
                      job.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      job.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Location and customer info
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.white.withOpacity(0.8),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  job.location.address,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 20,
                          color: Colors.white.withOpacity(0.2),
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.white.withOpacity(0.2),
                              child: Text(
                                job.homeownerName[0].toUpperCase(),
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              job.homeownerName,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Action hint
              Positioned(
                right: 16,
                bottom: 16,
                child: Row(
                  children: [
                    Text(
                      'View Details',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white.withOpacity(0.8),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getStageIcon(JobStage stage) {
    switch (stage) {
      case JobStage.pending:
        return Icons.pending_outlined;
      case JobStage.quoteCreation:
        return Icons.request_quote_outlined;
      case JobStage.enRoute:
        return Icons.directions_car_outlined;
      case JobStage.atLocation:
        return Icons.location_on_outlined;
      case JobStage.diagnosis:
        return Icons.search_outlined;
      case JobStage.inProgress:
        return Icons.engineering_outlined;
      case JobStage.completion:
        return Icons.check_circle_outline;
    }
  }

  Widget _buildNoActiveJobCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.engineering_outlined,
            size: 48,
            color: colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No Active Job',
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check new job requests below',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.primary.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobRequestCard(
      BuildContext context, request.JobRequest request) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          request.title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (request.isUrgent) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Urgent',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            size: 16, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          request.location,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
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
              Row(
                children: [
                  Row(
                    children: [
                      Icon(Icons.navigation_outlined,
                          size: 16, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(
                        '${request.distance} away',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 16, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(
                        '${request.eta} min',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  // TODO: Implement accept job request
                },
                child: Text(
                  'Accept',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
