import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voltzy_version_3/features/jobs/models/job.dart';
import 'package:voltzy_version_3/features/professional/providers/professional_job_providers.dart';
import 'package:voltzy_version_3/shared/widgets/app_bar.dart';
import 'package:voltzy_version_3/shared/widgets/loading_indicator.dart';

class JobRequestsScreen extends ConsumerWidget {
  const JobRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobRequests = ref.watch(jobRequestsProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VoltzyPageHeader(
              title: 'Job Requests',
              subtitle: 'Available jobs in your area',
            ),
            Expanded(
              child: jobRequests.when(
                data: (jobs) => jobs.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.work_off_outlined,
                              size: 64,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No job requests available',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Check back later for new requests',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: jobs.length,
                        itemBuilder: (context, index) {
                          final job = jobs[index];
                          return _JobRequestCard(
                            job: job,
                            onAccept: () =>
                                _showAcceptDialog(context, ref, job),
                            onReject: () =>
                                _showRejectDialog(context, ref, job),
                          );
                        },
                      ),
                error: (error, stackTrace) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading job requests',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Please try again later',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                loading: () => const LoadingIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAcceptDialog(
    BuildContext context,
    WidgetRef ref,
    Job job,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Accept Job Request'),
        content: Text(
          'Are you sure you want to accept this job request? '
          'Once accepted, you will be responsible for completing the job.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Accept'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final controller = ref.read(jobRequestsControllerProvider.notifier);
      await controller.acceptJobRequest(job.id);
    }
  }

  Future<void> _showRejectDialog(
    BuildContext context,
    WidgetRef ref,
    Job job,
  ) async {
    final reasonController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reject Job Request'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Please provide a reason for rejecting this job request. '
                'This will help the homeowner understand why their request was rejected.',
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: reasonController,
                decoration: const InputDecoration(
                  labelText: 'Reason',
                  hintText: 'Enter reason for rejection',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a reason';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(context, true);
              }
            },
            child: const Text('Reject'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final controller = ref.read(jobRequestsControllerProvider.notifier);
      await controller.rejectJobRequest(job.id, reasonController.text);
    }
  }
}

class _JobRequestCard extends StatelessWidget {
  const _JobRequestCard({
    required this.job,
    required this.onAccept,
    required this.onReject,
  });

  final Job job;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        job.location.address,
                        style: theme.textTheme.bodyMedium,
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
                    color: job.urgency.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    job.urgency.displayName,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: job.urgency.color,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              job.description,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  size: 16,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  'Est. ${job.estimatedDuration != null ? job.estimatedDuration! ~/ 60 : 0}h',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.attach_money,
                  size: 16,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  '\$${job.budget?.toStringAsFixed(2) ?? 'N/A'}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onReject,
                    child: const Text('Reject'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onAccept,
                    child: const Text('Accept'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
