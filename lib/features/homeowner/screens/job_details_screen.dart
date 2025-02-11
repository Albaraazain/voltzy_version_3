import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voltzy_version_3/features/homeowner/providers/homeowner_job_providers.dart';
import 'package:voltzy_version_3/features/jobs/models/job.dart';
import 'package:voltzy_version_3/shared/widgets/buttons.dart';
import 'package:voltzy_version_3/shared/widgets/loading_indicator.dart';

class JobDetailsScreen extends ConsumerWidget {
  final String jobId;

  const JobDetailsScreen({
    super.key,
    required this.jobId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobAsync = ref.watch(homeownerJobDetailsProvider(jobId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
      ),
      body: jobAsync.when(
        data: (job) => job != null
            ? _JobDetailsView(job: job)
            : const Center(
                child: Text('Job not found'),
              ),
        loading: () => const LoadingIndicator(),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Error: ${error.toString()}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () =>
                    ref.refresh(homeownerJobDetailsProvider(jobId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _JobDetailsView extends StatelessWidget {
  final Job job;

  const _JobDetailsView({required this.job});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusSection(theme),
          const SizedBox(height: 24),
          if (job.professional != null) _buildProfessionalSection(theme),
          const SizedBox(height: 24),
          _buildDetailsSection(theme),
          const SizedBox(height: 24),
          _buildActionsSection(context),
        ],
      ),
    );
  }

  Widget _buildStatusSection(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              job.title,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: _getStatusColor(job.status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _getStatusColor(job.status),
                ),
              ),
              child: Text(
                _getStatusLabel(job.status),
                style: TextStyle(
                  color: _getStatusColor(job.status),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfessionalSection(ThemeData theme) {
    final professional = job.professional!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Professional',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: professional.profileImageUrl != null
                      ? NetworkImage(professional.profileImageUrl!)
                      : null,
                  child: professional.profileImageUrl == null
                      ? const Icon(Icons.person, size: 32)
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        professional.name,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            professional.rating.toString(),
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // TODO: Implement chat
                  },
                  icon: const Icon(Icons.chat_bubble_outline),
                ),
                IconButton(
                  onPressed: () {
                    // TODO: Implement call
                  },
                  icon: const Icon(Icons.phone_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsSection(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            _buildDetailRow(
              theme,
              icon: Icons.description_outlined,
              label: 'Description',
              value: job.description,
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              theme,
              icon: Icons.location_on_outlined,
              label: 'Location',
              value: job.location.address,
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              theme,
              icon: Icons.attach_money,
              label: 'Budget',
              value: job.budget != null
                  ? '\$${job.budget!.toStringAsFixed(2)}'
                  : 'Not set',
            ),
            const SizedBox(height: 12),
            _buildDetailRow(
              theme,
              icon: Icons.access_time,
              label: 'Created',
              value: _formatDate(job.createdAt),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    ThemeData theme, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall,
              ),
              Text(
                value,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionsSection(BuildContext context) {
    if (job.status == JobStatus.completed ||
        job.status == JobStatus.cancelled) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (job.status == JobStatus.pending) ...[
          PrimaryButton(
            onPressed: () {
              // TODO: Implement cancel job
            },
            label: 'Cancel Request',
          ),
        ] else ...[
          PrimaryButton(
            onPressed: () {
              // TODO: Implement complete job
            },
            label: 'Mark as Complete',
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () {
              // TODO: Implement cancel job
            },
            child: const Text('Cancel Job'),
          ),
        ],
      ],
    );
  }

  Color _getStatusColor(JobStatus status) {
    return switch (status) {
      JobStatus.pending => Colors.orange,
      JobStatus.accepted => Colors.blue,
      JobStatus.inProgress => Colors.green,
      JobStatus.completed => Colors.purple,
      JobStatus.cancelled => Colors.red,
      JobStatus.rejected => Colors.grey,
    };
  }

  String _getStatusLabel(JobStatus status) {
    return status.displayName;
  }

  String _formatDate(DateTime date) {
    // TODO: Implement proper date formatting
    return date.toString();
  }
}
