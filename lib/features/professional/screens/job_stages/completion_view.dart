import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../jobs/models/job.dart';
import '../../providers/active_job_provider.dart';
import '../../providers/job_stages/job_stage_providers.dart';

class CompletionView extends ConsumerWidget {
  final Job job;
  const CompletionView({super.key, required this.job});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completionState = ref.watch(completionStateProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: switch (completionState) {
          AsyncData<void>() => _buildContent(context, ref),
          AsyncLoading<void>() => const Center(
              child: CircularProgressIndicator(),
            ),
          AsyncError<void>(error: final e) => Center(
              child: Text('Error: ${e.toString()}'),
            ),
          _ => const Center(child: Text('Unknown state')),
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _StageIndicator(
            stages: [
              'En Route',
              'At Location',
              'Diagnosis',
              'Quote',
              'In Progress',
              'Complete'
            ],
            currentStage: 5,
          ),
          _JobHeader(
            client: job.homeownerName,
            address: job.location.address,
            serviceType: job.title,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _TimerDisplay(elapsedTime: '01:15:32'),
                const SizedBox(height: 24),

                // Final Checklist Section
                const Text(
                  'Final Checklist',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    _ChecklistItem(
                      title: 'Work Area Clean',
                      description: 'Ensure all debris is removed',
                      isCompleted: true,
                      onToggle: () {},
                    ),
                    const SizedBox(height: 12),
                    _ChecklistItem(
                      title: 'Equipment Test',
                      description: 'Test all installed equipment',
                      isCompleted: true,
                      onToggle: () {},
                    ),
                    const SizedBox(height: 12),
                    _ChecklistItem(
                      title: 'Client Walkthrough',
                      description: 'Review work with client',
                      isCompleted: false,
                      onToggle: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Documentation Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Documentation',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            LucideIcons.camera,
                            size: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Add Photo',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              LucideIcons.image,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Completion Photos',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              Text(
                                'Add photos of completed work',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _PhotoPlaceholder(
                              onTap: () {},
                              isAdd: true,
                            ),
                            const SizedBox(width: 12),
                            _PhotoPlaceholder(
                              onTap: () {},
                              imageUrl: 'https://example.com/photo1.jpg',
                            ),
                            const SizedBox(width: 12),
                            _PhotoPlaceholder(
                              onTap: () {},
                              imageUrl: 'https://example.com/photo2.jpg',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Client Signature Section
                const Text(
                  'Client Signature',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              LucideIcons.pencil,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Client Sign-off',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              Text(
                                'Get client signature to complete job',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Center(
                          child: Text(
                            'Tap to add signature',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              LucideIcons.trash2,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            label: Text(
                              'Clear',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Finalize Job Button
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.primary.withOpacity(0.8),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () => _finalizeJob(ref, job),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Finalize Job',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _finalizeJob(WidgetRef ref, Job job) async {
    try {
      await ref.read(completionStateProvider.notifier).finalizeJob(job);
      if (!ref.context.mounted) return;

      ScaffoldMessenger.of(ref.context).showSnackBar(
        const SnackBar(
          content: Text('Job finalized successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!ref.context.mounted) return;

      ScaffoldMessenger.of(ref.context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class _StageIndicator extends StatelessWidget {
  final List<String> stages;
  final int currentStage;

  const _StageIndicator({
    required this.stages,
    required this.currentStage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: List.generate(stages.length * 2 - 1, (index) {
              if (index.isEven) {
                final stageIndex = index ~/ 2;
                return Expanded(
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      color: stageIndex <= currentStage
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                );
              } else {
                return Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (index ~/ 2) <= currentStage
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[200],
                    border: Border.all(
                      color: (index ~/ 2) <= currentStage
                          ? Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.2)
                          : Colors.transparent,
                      width: 4,
                    ),
                  ),
                );
              }
            }),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Completion',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        LucideIcons.clock,
                        size: 12,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Final steps',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      Theme.of(context).colorScheme.primary.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Step 6 of 6',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12,
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

class _JobHeader extends StatelessWidget {
  final String client;
  final String address;
  final String serviceType;

  const _JobHeader({
    required this.client,
    required this.address,
    required this.serviceType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.green[500],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'URGENT REQUEST',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              serviceType,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        Theme.of(context).colorScheme.primary.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    client
                        .split(' ')
                        .map((e) => e.isNotEmpty ? e[0] : '')
                        .join(''),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  client,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                children: [
                  Icon(
                    LucideIcons.alertTriangle,
                    size: 16,
                    color: Colors.amber[500],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      address,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimerDisplay extends StatelessWidget {
  final String elapsedTime;

  const _TimerDisplay({required this.elapsedTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              LucideIcons.clock,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Job Timer',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              elapsedTime,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChecklistItem extends StatelessWidget {
  final String title;
  final String description;
  final bool isCompleted;
  final VoidCallback onToggle;

  const _ChecklistItem({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCompleted ? Colors.green[50] : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isCompleted ? Colors.green[200]! : Colors.grey[200]!,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isCompleted ? Colors.green[100] : Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              LucideIcons.checkSquare,
              color: isCompleted ? Colors.green[700] : Colors.grey[700],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: isCompleted ? Colors.green[100] : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onToggle,
                borderRadius: BorderRadius.circular(8),
                child: isCompleted
                    ? Icon(
                        LucideIcons.checkCircle,
                        size: 20,
                        color: Colors.green[700],
                      )
                    : Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[400]!,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhotoPlaceholder extends StatelessWidget {
  final VoidCallback onTap;
  final String? imageUrl;
  final bool isAdd;

  const _PhotoPlaceholder({
    required this.onTap,
    this.imageUrl,
    this.isAdd = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: isAdd
            ? Icon(
                LucideIcons.plus,
                color: Colors.grey[400],
                size: 24,
              )
            : imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(
                    LucideIcons.image,
                    color: Colors.grey[400],
                    size: 24,
                  ),
      ),
    );
  }
}
