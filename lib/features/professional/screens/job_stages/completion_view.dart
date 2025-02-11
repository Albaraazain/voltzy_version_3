
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../jobs/models/job.dart';
import '../../providers/active_job_provider.dart';
import '../../providers/job_stages/job_stage_providers.dart';

class CompletionView extends ConsumerWidget {
  const CompletionView({
    super.key,
    required this.job,
  });

  final Job job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completionState = ref.watch(completionStateProvider);

    return Scaffold(
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
    // Initialize with default values
    final checklist = [
      {
        'title': 'Clean workspace',
        'subtitle': 'Ensure area is clean',
        'isChecked': false
      },
      {
        'title': 'Tools collected',
        'subtitle': 'All tools accounted for',
        'isChecked': false
      },
      {
        'title': 'Final inspection',
        'subtitle': 'Verify work quality',
        'isChecked': false
      },
    ];
    final photos = <String>[];
    String? signature;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CompletionChecklist(
            checklist: checklist,
            onItemToggled: (index) async {
              try {
                await ref
                    .read(completionStateProvider.notifier)
                    .toggleChecklistItem(index);
              } catch (e) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${e.toString()}')),
                );
              }
            },
          ),
          const SizedBox(height: 16),
          _FinalPhotoCapture(
            photos: photos,
            onPhotoAdded: (photoUrl) async {
              try {
                await ref
                    .read(completionStateProvider.notifier)
                    .addPhoto(photoUrl);
              } catch (e) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${e.toString()}')),
                );
              }
            },
          ),
          const SizedBox(height: 16),
          _ClientSignatureField(
            signature: signature,
            onSignatureChanged: (signatureUrl) async {
              try {
                await ref
                    .read(completionStateProvider.notifier)
                    .setSignature(signatureUrl);
              } catch (e) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${e.toString()}')),
                );
              }
            },
            onSignatureCleared: () async {
              try {
                await ref
                    .read(completionStateProvider.notifier)
                    .clearSignature();
              } catch (e) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${e.toString()}')),
                );
              }
            },
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: checklist.every((item) => item['isChecked'] as bool) &&
                    photos.isNotEmpty &&
                    signature != null
                ? () => _finalizeJob(ref)
                : null,
            child: const Text('Finalize Job'),
          ),
        ],
      ),
    );
  }

  Future<void> _finalizeJob(WidgetRef ref) async {
    try {
      await ref.read(completionStateProvider.notifier).finalizeJob(job);
      if (!ref.context.mounted) return;

      await ref
          .read(activeJobProvider.notifier)
          .updateStage(JobStage.completed);
    } catch (e) {
      if (!ref.context.mounted) return;
      ScaffoldMessenger.of(ref.context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}

class _CompletionChecklist extends StatelessWidget {
  const _CompletionChecklist({
    required this.checklist,
    required this.onItemToggled,
  });

  final List<Map<String, dynamic>> checklist;
  final void Function(int) onItemToggled;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Completion Checklist',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            ...checklist.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  _ChecklistItem(
                    title: item['title'] as String,
                    subtitle: item['subtitle'] as String,
                    isChecked: item['isChecked'] as bool,
                    onToggled: () => onItemToggled(index),
                  ),
                  if (index < checklist.length - 1) const SizedBox(height: 8),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _ChecklistItem extends StatelessWidget {
  const _ChecklistItem({
    required this.title,
    required this.subtitle,
    required this.isChecked,
    required this.onToggled,
  });

  final String title;
  final String subtitle;
  final bool isChecked;
  final VoidCallback onToggled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (_) => onToggled(),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  decoration: isChecked ? TextDecoration.lineThrough : null,
                ),
              ),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FinalPhotoCapture extends StatelessWidget {
  const _FinalPhotoCapture({
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
              'Final Photos',
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
                          label: 'After ${photos.indexOf(url) + 1}',
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
              Colors.black.withAlpha(179),
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

class _ClientSignatureField extends StatelessWidget {
  const _ClientSignatureField({
    required this.signature,
    required this.onSignatureChanged,
    required this.onSignatureCleared,
  });

  final String? signature;
  final void Function(String) onSignatureChanged;
  final VoidCallback onSignatureCleared;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Client Signature',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: signature != null && signature!.isNotEmpty
                  ? Image.network(
                      signature!,
                      fit: BoxFit.contain,
                    )
                  : const Center(
                      child: Text('Signature Pad Here'),
                    ),
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton.icon(
                onPressed: onSignatureCleared,
                icon: const Icon(Icons.refresh),
                label: const Text('Clear Signature'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
