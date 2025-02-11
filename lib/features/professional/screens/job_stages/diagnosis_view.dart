import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    return Scaffold(
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _IssueCategorySelector(
            selectedCategories: const [], // TODO: Store these in state
            onCategorySelected: (category) async {
              await ref
                  .read(diagnosisStateProvider.notifier)
                  .updateSelectedCategories([category]);
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

class _IssueCategorySelector extends StatelessWidget {
  const _IssueCategorySelector({
    required this.selectedCategories,
    required this.onCategorySelected,
  });

  final List<String> selectedCategories;
  final void Function(String) onCategorySelected;

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
