import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voltzy_version_3/features/homeowner/providers/homeowner_job_providers.dart';
import 'package:voltzy_version_3/features/jobs/models/job.dart';
import 'package:voltzy_version_3/shared/widgets/loading_indicator.dart';

class ActiveJobsScreen extends ConsumerWidget {
  const ActiveJobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeJobs = ref.watch(homeownerActiveJobsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Jobs'),
      ),
      body: activeJobs.when(
        data: (jobs) {
          if (jobs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.work_off_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No active jobs',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => context.go('/homeowner/request-service'),
                    child: const Text('Request a Service'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];
              return _ActiveJobCard(job: job);
            },
          );
        },
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
                onPressed: () => ref.refresh(homeownerActiveJobsProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActiveJobCard extends StatelessWidget {
  final Job job;

  const _ActiveJobCard({required this.job});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => context.go('/homeowner/job/${job.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      job.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _JobStatusChip(status: job.status),
                ],
              ),
              const SizedBox(height: 8),
              if (job.professional != null) ...[
                const Divider(),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: job.professional!.profileImageUrl != null
                          ? NetworkImage(job.professional!.profileImageUrl!)
                          : null,
                      child: job.professional!.profileImageUrl == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.professional!.name,
                            style: theme.textTheme.bodyLarge,
                          ),
                          Text(
                            'Professional',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: Implement chat functionality
                      },
                      icon: const Icon(Icons.chat_bubble_outline),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: Implement call functionality
                      },
                      icon: const Icon(Icons.phone_outlined),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _JobStatusChip extends StatelessWidget {
  final JobStatus status;

  const _JobStatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      JobStatus.pending => (Colors.orange, 'Pending'),
      JobStatus.accepted => (Colors.blue, 'Accepted'),
      JobStatus.inProgress => (Colors.green, 'In Progress'),
      JobStatus.completed => (Colors.purple, 'Completed'),
      JobStatus.cancelled => (Colors.red, 'Cancelled'),
      JobStatus.rejected => (Colors.grey, 'Rejected'),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
