import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../jobs/models/job.dart';
import 'package:flutter/foundation.dart';

part 'active_job_provider.g.dart';

@riverpod
class ActiveJob extends _$ActiveJob {
  @override
  Stream<Job?> build() async* {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      yield Job(
        id: '1',
        title: 'Fix Leaking Pipe',
        description: 'Kitchen sink pipe is leaking',
        location: const Location(
          address: '123 Main St',
          latitude: 37.7749,
          longitude: -122.4194,
        ),
        homeownerId: 'client1',
        homeownerName: 'John Doe',
        homeownerPhoneNumber: '+1234567890',
        stage: JobStage.enRoute,
        status: JobStatus.inProgress,
        urgency: JobUrgency.high,
        createdAt: DateTime.now(),
        estimatedDuration: const Duration(hours: 2),
        budget: 150.0,
      );
    } catch (e) {
      // Log the error
      // Consider using a proper logging mechanism instead of print in production
      print('Error fetching active job: $e');
      yield null;
    }
  }

  Future<void> updateStage(JobStage newStage) async {
    debugPrint('📝 Updating job stage to: $newStage');
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final currentJob = state.value;
      if (currentJob == null) {
        debugPrint('❌ Cannot update stage: No active job found');
        throw Exception('No active job found');
      }

      debugPrint('✅ Updating job stage from ${currentJob.stage} to $newStage');
      return currentJob.copyWith(stage: newStage);
    });

    final updatedJob = state.value;
    debugPrint('🔄 Job stage updated: ${updatedJob?.stage}');
  }
}

@riverpod
class ActiveJobStage extends _$ActiveJobStage {
  @override
  JobStage build() {
    final jobAsync = ref.watch(activeJobProvider);
    return jobAsync.when(
      data: (job) => job?.stage ?? JobStage.enRoute,
      loading: () => JobStage.enRoute,
      error: (_, __) => JobStage.enRoute,
    );
  }

  Future<void> updateStage(JobStage newStage) async {
    await ref.read(activeJobProvider.notifier).updateStage(newStage);
  }
}
