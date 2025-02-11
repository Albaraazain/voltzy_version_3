import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voltzy_version_3/features/jobs/models/job.dart';
import 'package:voltzy_version_3/features/professional/models/job_stage.dart';
import 'package:voltzy_version_3/features/professional/providers/active_job_provider.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DiagnosisStateProvider extends StateNotifier<AsyncValue<void>> {
  DiagnosisStateProvider() : super(const AsyncValue.data(null));

  Future<void> createQuote(Job job) async {
    // Implementation here
  }
}

final diagnosisStateProvider = StateNotifierProvider<DiagnosisStateProvider, AsyncValue<void>>(
  (ref) => DiagnosisStateProvider(),
);

class DiagnosisView extends ConsumerWidget {
  final Job job;
  
  const DiagnosisView({super.key, required this.job});
  // ... existing code ...

  Future<void> _createQuote(WidgetRef ref, Job job) async {
    try {
      await ref.read(diagnosisStateProvider.notifier).createQuote(job);
      if (!ref.context.mounted) return;

      // Update job stage
      await ref
          .read(activeJobStageProvider.notifier)
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
          ],
        ),
      );
    }
  }

  // Rest of the widget classes remain the same...
