import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../jobs/models/job.dart';
import '../repositories/professional_job_repository.dart';
import 'package:flutter/foundation.dart';

part 'active_job_provider.g.dart';

@riverpod
class ActiveJob extends AutoDisposeAsyncNotifier<Job?> {
  @override
  FutureOr<Job?> build() async {
    debugPrint('🔄 ActiveJob: Building provider');
    return _fetchActiveJob();
  }

  Future<Job?> _fetchActiveJob() async {
    debugPrint('🔍 ActiveJob: Fetching active job');
    try {
      final repository = ref.read(professionalJobRepositoryProvider);
      final job = await repository.getActiveJob();
      debugPrint('✅ ActiveJob: Fetched job ${job?.id}');
      return job;
    } catch (e, stack) {
      debugPrint('❌ ActiveJob: Error fetching job - $e');
      throw AsyncError(e, stack);
    }
  }

  Future<void> updateStage(JobStage newStage) async {
    debugPrint('🔄 ActiveJob: Updating stage to ${newStage.name}');
    if (state.isLoading) {
      debugPrint('⚠️ ActiveJob: Already loading, ignoring update');
      return;
    }

    try {
      // Keep the current value
      final currentJob = state.value;
      if (currentJob == null) {
        throw Exception('No active job found');
      }

      // Set loading state while updating
      state = const AsyncLoading();

      // Create updated job with new stage
      final updatedJob = currentJob.copyWith(
        stage: newStage,
        updatedAt: DateTime.now(),
      );

      // Update state with new job
      state = AsyncData(updatedJob);
      debugPrint('✅ ActiveJob: Stage updated successfully');
    } catch (e, stack) {
      debugPrint('❌ ActiveJob: Stage update failed - $e');
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> refresh() async {
    debugPrint('🔄 ActiveJob: Refreshing job data');
    if (state.isLoading) {
      debugPrint('⚠️ ActiveJob: Already loading, ignoring refresh');
      return;
    }

    state = const AsyncLoading();
    try {
      final job = await _fetchActiveJob();
      state = AsyncData(job);
      debugPrint('✅ ActiveJob: Refresh successful');
    } catch (e, stack) {
      debugPrint('❌ ActiveJob: Refresh failed - $e');
      state = AsyncError(e, stack);
      rethrow;
    }
  }
}
