import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../jobs/models/job.dart';
import '../../providers/active_job_provider.dart' as active_job;
import '../../providers/job_stages/job_stage_providers.dart';

class DiagnosisView extends ConsumerWidget {
  const DiagnosisView({
    super.key,
    required this.job,
  });

  final Job job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diagnosisState = ref.watch(diagnosisStateProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: switch (diagnosisState) {
          AsyncData<void>() => _buildContent(context, ref),
          AsyncLoading<void>() =>
            const Center(child: CircularProgressIndicator()),
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
        children: [
          const StageIndicator(
            stages: ['En Route', 'At Location', 'Diagnosis', 'Quote', 'In Progress', 'Complete'],
            currentIndex: 2,
          ),
          JobHeader(
            client: job.homeownerName,
            address: job.location.address,
            serviceType: job.title,
            onCallTap: () {
              // TODO: Implement call functionality
            },
            onMessageTap: () {
              // TODO: Implement message functionality
            },
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TimerDisplay(),
                const SizedBox(height: 24),
                Text(
                  'Arrival Verification',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                VerificationCard(
                  title: 'Location Verification',
                  icon: LucideIcons.checkCircle,
                  description: 'Confirm you\'re at the correct location',
                  status: 'completed',
                ),
                const SizedBox(height: 12),
                VerificationCard(
                  title: 'Site Photos',
                  icon: LucideIcons.camera,
                  description: 'Take photos of the work area',
                  status: 'pending',
                ),
                const SizedBox(height: 24),
                Text(
                  'Safety Checklist',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                SafetyCheck(
                  icon: LucideIcons.shield,
                  title: 'Personal Protective Equipment',
                  status: true,
                ),
                const SizedBox(height: 12),
                SafetyCheck(
                  icon: LucideIcons.alertTriangle,
                  title: 'Area Safety Check',
                  status: false,
                ),
                const SizedBox(height: 12),
                SafetyCheck(
                  icon: LucideIcons.wrench,
                  title: 'Tools Inspection',
                  status: false,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => _startDiagnosis(ref),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.pink[500],
                    ),
                    child: const Text('Start Diagnosis'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _DiagnosisNotesField(
            notes: '', // TODO: Store this in state
            onNotesChanged: (value) async {
              await ref
                  .read(diagnosisStateProvider.notifier)
                  .updateNotes(value);
            },
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => _createQuote(ref),
            child: const Text('Create Quote'),
          ),
        ],
      ),
    );
  }

  Future<void> _startDiagnosis(WidgetRef ref) async {
    final canStart = await ref.read(atLocationStateProvider.notifier).canStartDiagnosis();
    
    if (!canStart) {
      if (!ref.context.mounted) return;
      ScaffoldMessenger.of(ref.context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all verifications and safety checks before starting diagnosis'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await ref.read(diagnosisStateProvider.notifier).submitDiagnosis(job);
      if (!ref.context.mounted) return;

      // Update job stage
      await ref
          .read(active_job.activeJobStageProvider.notifier)
          .updateStage(JobStage.quoteCreation);
    } catch (e) {
      debugPrint('Error creating quote: $e');
    }
  }
}

class StageIndicator extends StatelessWidget {
  const StageIndicator({
    super.key,
    required this.stages,
    required this.currentIndex,
  });

  final List<String> stages;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 0,
            child: Container(
              height: 96,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.grey.shade50,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  children: List.generate(stages.length * 2 - 1, (index) {
                    if (index.isEven) {
                      final stageIndex = index ~/ 2;
                      return _StageIndicatorDot(
                        isCompleted: stageIndex <= currentIndex,
                      );
                    } else {
                      return _StageIndicatorLine(
                        isCompleted: (index - 1) ~/ 2 < currentIndex,
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
                          stages[currentIndex],
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              LucideIcons.clock,
                              size: 12,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Started 5 mins ago',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.pink.shade100,
                            Colors.pink.shade50,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Step ${currentIndex + 1} of ${stages.length}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.pink[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StageIndicatorDot extends StatelessWidget {
class _StageIndicatorDot extends StatelessWidget {
  const _StageIndicatorDot({
    required this.isCompleted,
  });

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: isCompleted ? Colors.pink[500] : Colors.grey[200],
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isCompleted ? Colors.pink[100]! : Colors.transparent,
          width: 4,
        ),
      ),
    );
  }
}

class _StageIndicatorLine extends StatelessWidget {
  const _StageIndicatorLine({
    required this.isCompleted,
  });

  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 2,
        color: isCompleted ? Colors.pink[500] : Colors.grey[200],
      ),
    );
  }
}

class JobHeader extends StatelessWidget {
  const JobHeader({
    super.key,
    required this.client,
    required this.address,
    required this.serviceType,
    required this.onCallTap,
    required this.onMessageTap,
  });

  final String client;
  final String address;
  final String serviceType;
  final VoidCallback onCallTap;
  final VoidCallback onMessageTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.green[500],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'URGENT REQUEST',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.green[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        serviceType,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.pink[100]!,
                                  Colors.pink[50]!,
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                client.split(' ').map((e) => e[0]).join(''),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.pink[700],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            client,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey[200]!),
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey[50]!,
                              Colors.white,
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              LucideIcons.alertTriangle,
                              size: 16,
                              color: Colors.amber[500],
                            ),
                            const SizedBox(width: 8),
                            Text(
                              address,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    _ActionButton(
                      icon: LucideIcons.phone,
                      onTap: onCallTap,
                    ),
                    const SizedBox(width: 8),
                    _ActionButton(
                      icon: LucideIcons.messageCircle,
                      onTap: onMessageTap,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Colors.pink[100]!,
              Colors.pink[50]!,
            ],
          ),
        ),
        child: Icon(
          icon,
          size: 20,
          color: Colors.pink[600],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onSelected,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: isSelected ? colorScheme.onPrimary : colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: onSelected,
    );
  }
}

class _PhotoDocumentationSection extends StatelessWidget {
  const _PhotoDocumentationSection({
    required this.photos,
    required this.onPhotoAdded,
  });

  final List<String> photos;
  final void Function(String) onPhotoAdded;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Photo Documentation',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _AddPhotoButton(onPhotoAdded: onPhotoAdded),
                  const SizedBox(width: 8),
                  ...photos.map((url) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _PhotoThumbnail(
                          imageUrl: url,
                          label: 'Issue ${photos.indexOf(url) + 1}',
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddPhotoButton extends StatelessWidget {
  const _AddPhotoButton({
    required this.onPhotoAdded,
  });

  final void Function(String) onPhotoAdded;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: const Icon(Icons.add_a_photo),
        onPressed: () {
          // TODO: Implement photo capture
          onPhotoAdded(
              'https://example.com/photo${DateTime.now().millisecondsSinceEpoch}.jpg');
        },
      ),
    );
  }
}

class _PhotoThumbnail extends StatelessWidget {
  const _PhotoThumbnail({
    required this.imageUrl,
    required this.label,
  });

  final String imageUrl;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(8),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class TimerDisplay extends StatelessWidget {
  const TimerDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[200]!),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey[100]!,
                      Colors.grey[50]!,
                    ],
                  ),
                ),
                child: Icon(
                  LucideIcons.clock,
                  size: 20,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Job Timer',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  Colors.grey[100]!,
                  Colors.grey[50]!,
                ],
              ),
            ),
            child: Text(
              '00:05:32',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VerificationCard extends StatelessWidget {
  const VerificationCard({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
    required this.status,
  });

  final String title;
  final IconData icon;
  final String description;
  final String status;

  @override
  Widget build(BuildContext context) {
    final isCompleted = status == 'completed';
    
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
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: isCompleted
                    ? [Colors.green[100]!, Colors.green[50]!]
                    : [Colors.grey[100]!, Colors.grey[50]!],
              ),
            ),
            child: Icon(
              icon,
              size: 20,
              color: isCompleted ? Colors.green[600] : Colors.grey[600],
            ),
          ),
          const SizedBox(width: 16),
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
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: isCompleted
                    ? [Colors.green[100]!, Colors.green[50]!]
                    : [Colors.pink[100]!, Colors.pink[50]!],
              ),
            ),
            child: Text(
              isCompleted ? 'Completed' : 'Required',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isCompleted ? Colors.green[700] : Colors.pink[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SafetyCheck extends StatelessWidget {
  const SafetyCheck({
    super.key,
    required this.icon,
    required this.title,
    required this.status,
  });

  final IconData icon;
  final String title;
  final bool status;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: status ? Colors.green[50] : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: status ? Colors.green[200]! : Colors.grey[200]!,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: status
                    ? [Colors.green[100]!, Colors.green[50]!]
                    : [Colors.grey[100]!, Colors.grey[50]!],
              ),
            ),
            child: Icon(
              icon,
              size: 20,
              color: status ? Colors.green[600] : Colors.grey[600],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: status ? Colors.green[100] : Colors.grey[100],
            ),
            child: status
                ? Icon(
                    LucideIcons.checkCircle,
                    size: 20,
                    color: Colors.green[600],
                  )
                : Center(
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey[400]!,
                          width: 2,
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

class _DiagnosisNotesField extends StatelessWidget {
  const _DiagnosisNotesField({
    required this.notes,
    required this.onNotesChanged,
  });

  final String notes;
  final ValueChanged<String> onNotesChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Diagnosis Notes',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            TextFormField(
              maxLines: 5,
              initialValue: notes,
              onChanged: onNotesChanged,
              decoration: const InputDecoration(
                hintText: 'Enter detailed diagnosis notes...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
