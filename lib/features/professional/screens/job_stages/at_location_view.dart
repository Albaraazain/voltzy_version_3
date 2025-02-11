import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../jobs/models/job.dart';
import '../../providers/active_job_provider.dart';
import '../../providers/job_stages/job_stage_providers.dart';

class AtLocationView extends ConsumerWidget {
  final Job job;
  const AtLocationView({super.key, required this.job});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final atLocationState = ref.watch(atLocationStateProvider);

    return Scaffold(
      body: SafeArea(
        child: switch (atLocationState) {
          AsyncData<void>() => _buildContent(context, ref, job),
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

  Widget _buildContent(BuildContext context, WidgetRef ref, Job job) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Location Verification Section
          _buildLocationVerification(context, ref),
          const SizedBox(height: 24),

          // Safety Checklist Section
          _buildSafetyChecklist(context, ref),
          const SizedBox(height: 24),

          // Start Diagnosis Button
          ElevatedButton(
            onPressed: () => _startDiagnosis(ref, job),
            child: const Text('Start Diagnosis'),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationVerification(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Location Verification',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _verifyLocation(ref),
              child: const Text('Verify Location'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _addSitePhoto(ref),
              child: const Text('Add Site Photo'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyChecklist(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Safety Checklist',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Add safety checklist items here
            _buildSafetyItem(ref, 'ppe', 'Personal Protective Equipment'),
            _buildSafetyItem(ref, 'area', 'Area Safety Check'),
            _buildSafetyItem(ref, 'tools', 'Tools Inspection'),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyItem(WidgetRef ref, String id, String title) {
    return ListTile(
      title: Text(title),
      trailing: IconButton(
        icon: const Icon(Icons.check_circle_outline),
        onPressed: () => _toggleSafetyItem(ref, id),
      ),
    );
  }

  Future<void> _verifyLocation(WidgetRef ref) async {
    try {
      await ref.read(atLocationStateProvider.notifier).verifyLocation();
    } catch (e) {
      debugPrint('Error verifying location: $e');
    }
  }

  Future<void> _addSitePhoto(WidgetRef ref) async {
    try {
      // TODO: Implement photo capture logic
      await ref
          .read(atLocationStateProvider.notifier)
          .addSitePhoto('photo_url');
    } catch (e) {
      debugPrint('Error adding site photo: $e');
    }
  }

  Future<void> _toggleSafetyItem(WidgetRef ref, String itemId) async {
    try {
      await ref.read(atLocationStateProvider.notifier).toggleSafetyItem(itemId);
    } catch (e) {
      debugPrint('Error toggling safety item: $e');
    }
  }

  Future<void> _startDiagnosis(WidgetRef ref, Job job) async {
    try {
      final canStart =
          await ref.read(atLocationStateProvider.notifier).canStartDiagnosis();
      if (canStart) {
        await ref.read(atLocationStateProvider.notifier).startDiagnosis(job);
      }
    } catch (e) {
      debugPrint('Error starting diagnosis: $e');
    }
  }
}

class _StageIndicator extends StatelessWidget {
  const _StageIndicator({required this.stages});

  final List<String> stages;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: List.generate(stages.length * 2 - 1, (index) {
              if (index.isEven) {
                final stageIndex = index ~/ 2;
                return Expanded(
                  child: Container(
                    height: 3,
                    decoration: BoxDecoration(
                      color: stageIndex <= 1
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(1.5),
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
                    color: (index ~/ 2) <= 1
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey[200],
                    border: Border.all(
                      color: (index ~/ 2) <= 1
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
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'At Location',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                  'Step 2 of 6',
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
  const _JobHeader({
    required this.client,
    required this.address,
    required this.serviceType,
  });

  final String client;
  final String address;
  final String serviceType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'URGENT REQUEST',
                      style: TextStyle(
                        color: theme.colorScheme.error,
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
            style: theme.textTheme.titleLarge?.copyWith(
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
                      theme.colorScheme.primary.withOpacity(0.1),
                      theme.colorScheme.primary.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text(
                  client.split(' ').map((e) => e[0]).join(''),
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                client,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[700],
                ),
              ),
              const Spacer(),
              _ActionButton(
                icon: LucideIcons.phone,
                onPressed: () {
                  // TODO: Implement phone call
                },
              ),
              const SizedBox(width: 8),
              _ActionButton(
                icon: LucideIcons.messageCircle,
                onPressed: () {
                  // TODO: Implement messaging
                },
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
                  color: theme.colorScheme.error,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    address,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimerDisplay extends StatelessWidget {
  const _TimerDisplay({required this.elapsedTime});

  final String elapsedTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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

class _VerificationCard extends StatelessWidget {
  const _VerificationCard({
    required this.title,
    required this.icon,
    required this.description,
    required this.status,
    required this.onVerify,
    this.photos = const [],
  });

  final String title;
  final IconData icon;
  final String description;
  final String status;
  final VoidCallback onVerify;
  final List<String> photos;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompleted = status == 'completed';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.green[50] : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isCompleted ? Colors.green[200]! : Colors.grey[200]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isCompleted ? Colors.green[100] : Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
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
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isCompleted
                        ? [Colors.green[100]!, Colors.green[50]!]
                        : [
                            theme.colorScheme.primary.withOpacity(0.1),
                            theme.colorScheme.primary.withOpacity(0.05)
                          ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  isCompleted ? 'Completed' : 'Required',
                  style: TextStyle(
                    color: isCompleted
                        ? Colors.green[700]
                        : theme.colorScheme.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          if (photos.isNotEmpty) ...[
            const SizedBox(height: 16),
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: photos.length + (photos.length < 4 ? 1 : 0),
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  if (index == photos.length) {
                    return _AddPhotoButton(onTap: onVerify);
                  }
                  return _PhotoThumbnail(imageUrl: photos[index]);
                },
              ),
            ),
          ] else if (title == 'Site Photos') ...[
            const SizedBox(height: 16),
            _AddPhotoButton(onTap: onVerify),
          ],
        ],
      ),
    );
  }
}

class _SafetyCheck extends StatelessWidget {
  const _SafetyCheck({
    required this.icon,
    required this.title,
    required this.status,
    required this.onToggle,
  });

  final IconData icon;
  final String title;
  final bool status;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: status ? Colors.green[50] : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: status ? Colors.green[200]! : Colors.grey[200]!,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: status ? Colors.green[100] : Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: status ? Colors.green[700] : Colors.grey[700],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            onPressed: onToggle,
            icon: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: status ? Colors.green[100] : Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: status
                  ? Icon(
                      LucideIcons.check,
                      size: 16,
                      color: Colors.green[700],
                    )
                  : Container(
                      margin: const EdgeInsets.all(6),
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
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        color: Colors.grey[600],
      ),
    );
  }
}

class _AddPhotoButton extends StatelessWidget {
  const _AddPhotoButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          LucideIcons.camera,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}

class _PhotoThumbnail extends StatelessWidget {
  const _PhotoThumbnail({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
