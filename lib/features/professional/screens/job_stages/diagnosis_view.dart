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
          const SizedBox(height: 16),
          _PhotoDocumentationSection(
            photos: const [], // TODO: Store these in state
            onPhotoAdded: (photoUrl) async {
              await ref
                  .read(diagnosisStateProvider.notifier)
                  .addPhoto(photoUrl);
            },
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

  Future<void> _createQuote(WidgetRef ref) async {
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Issue Categories',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _CategoryChip(
                  label: 'Electrical',
                  icon: Icons.electrical_services,
                  isSelected: selectedCategories.contains('Electrical'),
                  onSelected: (selected) => onCategorySelected('Electrical'),
                ),
                _CategoryChip(
                  label: 'Plumbing',
                  icon: Icons.water_damage,
                  isSelected: selectedCategories.contains('Plumbing'),
                  onSelected: (selected) => onCategorySelected('Plumbing'),
                ),
                _CategoryChip(
                  label: 'HVAC',
                  icon: Icons.ac_unit,
                  isSelected: selectedCategories.contains('HVAC'),
                  onSelected: (selected) => onCategorySelected('HVAC'),
                ),
                _CategoryChip(
                  label: 'Structural',
                  icon: Icons.home,
                  isSelected: selectedCategories.contains('Structural'),
                  onSelected: (selected) => onCategorySelected('Structural'),
                ),
              ],
            ),
          ],
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
