import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../jobs/models/job.dart';
import '../../providers/active_job_provider.dart';
import '../../providers/job_timer_provider.dart';

class InProgressView extends ConsumerWidget {
  const InProgressView({
    super.key,
    required this.job,
  });

  final Job job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobTimer = ref.watch(jobTimerProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _JobTimer(duration: jobTimer),
          const SizedBox(height: 16),
          _TasksList(),
          const SizedBox(height: 16),
          _IssuesEncountered(),
          const SizedBox(height: 16),
          _ProgressPhotos(),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => _completeJob(ref),
            child: const Text('Complete Job'),
          ),
        ],
      ),
    );
  }

  Future<void> _completeJob(WidgetRef ref) async {
    // Update job stage
    await ref
        .read(activeJobStageProvider.notifier)
        .updateStage(JobStage.completion);
  }
}

class _JobTimer extends StatelessWidget {
  const _JobTimer({
    required this.duration,
  });

  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final hours = duration.inHours;
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Job Duration',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '$hours:$minutes:$seconds',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Hardcoded tasks for now
    final tasks = [
      {
        'title': 'Clean water heater tank',
        'isCompleted': true,
      },
      {
        'title': 'Replace heating elements',
        'isCompleted': true,
      },
      {
        'title': 'Test water temperature',
        'isCompleted': false,
      },
      {
        'title': 'Clean work area',
        'isCompleted': false,
      },
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tasks',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add Task'),
                  onPressed: () => _showAddTaskDialog(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...tasks.map((task) => CheckboxListTile(
                  title: Text(task['title'] as String),
                  value: task['isCompleted'] as bool,
                  onChanged: (value) {
                    // TODO: Implement task completion toggle
                  },
                )),
          ],
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Task'),
        content: TextField(
          decoration: const InputDecoration(
            labelText: 'Task Description',
          ),
          maxLines: 2,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              // TODO: Implement task addition
              Navigator.pop(context);
            },
            child: const Text('Add Task'),
          ),
        ],
      ),
    );
  }
}

class _IssuesEncountered extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Issues Encountered',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add Issue'),
                  onPressed: () => _showAddIssueDialog(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Hardcoded issues for now
            _IssueItem(
              title: 'Additional corrosion found',
              description:
                  'Found significant corrosion on the upper heating element mount.',
              timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddIssueDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Issue'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Issue Title',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              // TODO: Implement issue addition
              Navigator.pop(context);
            },
            child: const Text('Add Issue'),
          ),
        ],
      ),
    );
  }
}

class _IssueItem extends StatelessWidget {
  const _IssueItem({
    required this.title,
    required this.description,
    required this.timestamp,
  });

  final String title;
  final String description;
  final DateTime timestamp;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 4),
        Text(
          _formatTimestamp(timestamp),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
        const Divider(),
      ],
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

class _ProgressPhotos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Hardcoded photos for now
    final photos = [
      'https://example.com/photo1.jpg',
      'https://example.com/photo2.jpg',
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progress Photos',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.add_a_photo),
                  onPressed: () {
                    // TODO: Implement photo capture
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (photos.isEmpty)
              Center(
                child: Text(
                  'No photos added yet',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              )
            else
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: photos
                      .map(
                        (url) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _PhotoThumbnail(
                            imageUrl: url,
                            onTap: () {
                              // TODO: Show full-size photo
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PhotoThumbnail extends StatelessWidget {
  const _PhotoThumbnail({
    required this.imageUrl,
    required this.onTap,
  });

  final String imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
