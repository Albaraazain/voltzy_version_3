import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../jobs/models/job.dart';
import '../../providers/active_job_provider.dart';

class DiagnosisStateProvider extends StateNotifier<AsyncValue<void>> {
  DiagnosisStateProvider() : super(const AsyncData(null));

  Future<void> createQuote(Job job) async {
    state = const AsyncLoading();
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }
}

final diagnosisStateProvider =
    StateNotifierProvider<DiagnosisStateProvider, AsyncValue<void>>(
  (ref) => DiagnosisStateProvider(),
);

class DiagnosisView extends ConsumerWidget {
  const DiagnosisView({super.key, required this.job});

  final Job job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diagnosisState = ref.watch(diagnosisStateProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: switch (diagnosisState) {
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
          _StageIndicator(
            stages: const [
              'En Route',
              'At Location',
              'Diagnosis',
              'Quote',
              'In Progress',
              'Complete'
            ],
            currentStage: 2,
          ),
          _JobHeader(
            client: job.homeownerName,
            address: job.location.address,
            serviceType: job.title,
            onCallTap: () {
              // TODO: Implement phone call
            },
            onMessageTap: () {
              // TODO: Implement messaging
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _TimerDisplay(elapsedTime: '00:05:32'),
                const SizedBox(height: 24),
                _buildDiagnosisSection(context),
                const SizedBox(height: 24),
                _buildSafetyChecklist(context),
                const SizedBox(height: 32),
                _buildActionButton(context, ref),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiagnosisSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 16),
          child: Text(
            'Diagnosis Steps',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const Column(
          children: [
            _VerificationCard(
              title: 'Initial Assessment',
              icon: LucideIcons.clipboardCheck,
              description: 'Document initial findings',
              status: 'completed',
            ),
            SizedBox(height: 12),
            _VerificationCard(
              title: 'Testing',
              icon: LucideIcons.wrench,
              description: 'Perform diagnostic tests',
              status: 'pending',
            ),
            SizedBox(height: 12),
            _VerificationCard(
              title: 'Documentation',
              icon: LucideIcons.camera,
              description: 'Take photos of issues found',
              status: 'pending',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSafetyChecklist(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 16),
          child: Text(
            'Safety Checklist',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const Column(
          children: [
            _SafetyCheck(
              icon: LucideIcons.shield,
              title: 'Personal Protective Equipment',
              status: true,
            ),
            SizedBox(height: 12),
            _SafetyCheck(
              icon: LucideIcons.alertTriangle,
              title: 'Area Safety Check',
              status: false,
            ),
            SizedBox(height: 12),
            _SafetyCheck(
              icon: LucideIcons.wrench,
              title: 'Tools Inspection',
              status: false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _createQuote(ref, job),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: const Center(
              child: Text(
                'Create Quote',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createQuote(WidgetRef ref, Job job) async {
    try {
      await ref.read(diagnosisStateProvider.notifier).createQuote(job);
      if (!ref.context.mounted) return;

      // Update job stage
      await ref
          .read(activeJobProvider.notifier)
          .updateStage(JobStage.quoteCreation);
    } catch (e) {
      debugPrint('Error creating quote: $e');
      if (!ref.context.mounted) return;
      ScaffoldMessenger.of(ref.context).showSnackBar(
        SnackBar(
          content: Text('Error creating quote: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class _StageIndicator extends StatelessWidget {
  const _StageIndicator({
    required this.stages,
    required this.currentStage,
  });

  final List<String> stages;
  final int currentStage;

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
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: stageIndex <= currentStage
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey[200],
                          border: Border.all(
                            color: stageIndex <= currentStage
                                ? Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2)
                                : Colors.transparent,
                            width: 4,
                          ),
                        ),
                      ),
                      if (stageIndex < stages.length - 1)
                        Expanded(
                          child: Container(
                            height: 2,
                            color: stageIndex < currentStage
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey[200],
                          ),
                        ),
                    ],
                  ),
                );
              }
              return const SizedBox(width: 4);
            }),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stages[currentStage],
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
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Started 5 mins ago',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
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
                  'Step ${currentStage + 1} of ${stages.length}',
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
      padding: const EdgeInsets.all(24),
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
                                  Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.2),
                                  Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.1),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                client
                                    .split(' ')
                                    .map((e) => e[0])
                                    .join('')
                                    .toUpperCase(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary,
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
                      onPressed: onCallTap,
                    ),
                    const SizedBox(width: 8),
                    _ActionButton(
                      icon: LucideIcons.messageCircle,
                      onPressed: onMessageTap,
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
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.1),
                Theme.of(context).colorScheme.primary.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[200]!),
      ),
      padding: const EdgeInsets.all(20),
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
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isCompleted
                    ? [
                        Colors.green[100]!,
                        Colors.green[50]!,
                      ]
                    : [
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        Theme.of(context).colorScheme.primary.withOpacity(0.05),
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
    );
  }
}

class _SafetyCheck extends StatelessWidget {
  const _SafetyCheck({
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
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: status ? Colors.green[100] : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: status
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
        ],
      ),
    );
  }
}
