import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../jobs/models/job.dart';
import '../../providers/active_job_provider.dart' as active_job;
import '../../providers/job_stages/job_stage_providers.dart';

class EnRouteView extends ConsumerWidget {
  const EnRouteView({
    super.key,
    required this.job,
  });

  final Job job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final enRouteState = ref.watch(enRouteStateProvider);

    return Stack(
      children: [
        // Map Placeholder (Replace with actual map)
        Container(
          color: Colors.grey[100],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map,
                  size: 48,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 8),
                Text(
                  'Map View',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Job Info at Top
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stage Indicator
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildStageIndicator(context),
                ),

                // Job Details
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job.title,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  job.homeownerName,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              _ActionButton(
                                icon: Icons.phone,
                                onPressed: () {
                                  // TODO: Implement phone call
                                },
                              ),
                              const SizedBox(width: 8),
                              _ActionButton(
                                icon: Icons.message,
                                onPressed: () {
                                  // TODO: Implement messaging
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              job.location.address,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[600],
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
          ),
        ),

        // Navigation Info at Bottom
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _NavigationInfo(
                      icon: Icons.navigation,
                      label: 'Distance',
                      value: '2.5 miles',
                      iconColor: colorScheme.secondary,
                      backgroundColor: colorScheme.secondary.withOpacity(0.1),
                    ),
                    _NavigationInfo(
                      icon: Icons.schedule,
                      label: 'ETA',
                      value: '10 mins',
                      iconColor: colorScheme.primary,
                      backgroundColor: colorScheme.primary.withOpacity(0.1),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: enRouteState.isLoading
                      ? null
                      : () => _markAsArrived(ref, job),
                  child: enRouteState.isLoading
                      ? const CircularProgressIndicator()
                      : const Text("I've Arrived"),
                ),
              ],
            ),
          ),
        ),

        // Emergency Button
        Positioned(
          right: 16,
          top: MediaQuery.of(context).size.height / 2,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 4,
            child: Icon(
              Icons.warning_amber_rounded,
              color: colorScheme.error,
            ),
            onPressed: () {
              // TODO: Implement emergency action
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStageIndicator(BuildContext context) {
    final stages = JobStage.values;
    final currentStageIndex = stages.indexOf(job.stage);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            stages.length,
            (index) => Expanded(
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index <= currentStageIndex
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey[200],
                    ),
                  ),
                  if (index < stages.length - 1)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: index < currentStageIndex
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey[200],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          job.stage.displayName,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  Future<void> _markAsArrived(WidgetRef ref, Job job) async {
    try {
      await ref.read(enRouteStateProvider.notifier).markAsArrived(job);
    } catch (e) {
      // Handle error appropriately
      debugPrint('Error marking as arrived: $e');
    }
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

class _NavigationInfo extends StatelessWidget {
  const _NavigationInfo({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
    required this.backgroundColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
