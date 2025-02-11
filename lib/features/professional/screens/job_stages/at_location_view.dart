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
      body: Container(
        color: Colors.grey[50],
        child: SafeArea(
          child: switch (atLocationState) {
            AsyncData<void>() => _buildContent(context, ref),
            AsyncLoading<void>() =>
              const Center(child: CircularProgressIndicator()),
            AsyncError<void>(error: final e) =>
              Center(child: Text('Error: ${e.toString()}')),
            _ => const Center(child: Text('Unknown state')),
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _StageIndicator(
            stages: [
              'En Route',
              'At Location',
              'Diagnosis',
              'Quote',
              'In Progress',
              'Complete'
            ],
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
                const _TimerDisplay(elapsedTime: '00:05:32'),
                const SizedBox(height: 24),

                // Verification Section
                const Text(
                  'Arrival Verification',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    _VerificationCard(
                      title: 'Location Verification',
                      icon: LucideIcons.checkCircle,
                      description: 'Confirm you\'re at the correct location',
                      status: 'completed',
                      onVerify: () => _verifyLocation(ref),
                    ),
                    const SizedBox(height: 12),
                    _VerificationCard(
                      title: 'Site Photos',
                      icon: LucideIcons.camera,
                      description: 'Take photos of the work area',
                      status: 'pending',
                      onVerify: () => _addSitePhoto(ref),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Safety Checklist
                const Text(
                  'Safety Checklist',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    _SafetyCheck(
                      icon: LucideIcons.shield,
                      title: 'Personal Protective Equipment',
                      status: true,
                      onToggle: () => _toggleSafetyItem(ref, 'ppe'),
                    ),
                    const SizedBox(height: 12),
                    _SafetyCheck(
                      icon: LucideIcons.alertTriangle,
                      title: 'Area Safety Check',
                      status: false,
                      onToggle: () => _toggleSafetyItem(ref, 'area'),
                    ),
                    const SizedBox(height: 12),
                    _SafetyCheck(
                      icon: LucideIcons.wrench,
                      title: 'Tools Inspection',
                      status: false,
                      onToggle: () => _toggleSafetyItem(ref, 'tools'),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Start Diagnosis Button
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
                    onPressed: () => _startDiagnosis(ref, job),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Start Diagnosis',
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

  Future<void> _verifyLocation(WidgetRef ref) async {
    try {
      await ref.read(atLocationStateProvider.notifier).verifyLocation();
    } catch (e) {
      debugPrint('Error verifying location: $e');
    }
  }

  Future<void> _addSitePhoto(WidgetRef ref) async {
    try {
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
      await ref.read(atLocationStateProvider.notifier).startDiagnosis(job);
      if (!ref.context.mounted) return;

      // Show success message
      ScaffoldMessenger.of(ref.context).showSnackBar(
        const SnackBar(
          content: Text('Starting diagnosis...'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!ref.context.mounted) return;

      // Show error message
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

  const _StageIndicator({required this.stages});

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
                      color: stageIndex <= 1
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
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'At Location',
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
                        'Arrived 5 mins ago',
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

class _VerificationCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;
  final String status;
  final VoidCallback onVerify;

  const _VerificationCard({
    required this.title,
    required this.icon,
    required this.description,
    required this.status,
    required this.onVerify,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = status == 'completed';

    return Container(
      padding: const EdgeInsets.all(20),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isCompleted
                        ? [Colors.green[100]!, Colors.green[50]!]
                        : [
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
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  isCompleted ? 'Completed' : 'Required',
                  style: TextStyle(
                    color: isCompleted
                        ? Colors.green[700]
                        : Theme.of(context).colorScheme.primary,
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

class _SafetyCheck extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool status;
  final VoidCallback onToggle;

  const _SafetyCheck({
    required this.icon,
    required this.title,
    required this.status,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
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
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
  final IconData icon;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.onPressed,
  });

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
