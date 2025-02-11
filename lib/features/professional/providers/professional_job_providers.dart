import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voltzy_version_3/features/jobs/models/job.dart';
import 'package:voltzy_version_3/features/professional/repositories/professional_job_repository.dart';

part 'professional_job_providers.g.dart';

@riverpod
ProfessionalJobRepository professionalJobRepository(
    ProfessionalJobRepositoryRef ref) {
  return ProfessionalJobRepository();
}

@riverpod
Future<List<Job>> jobRequests(JobRequestsRef ref) {
  final repository = ref.watch(professionalJobRepositoryProvider);
  return repository.getJobRequests();
}

@riverpod
Future<Job?> activeJob(ActiveJobRef ref) {
  final repository = ref.watch(professionalJobRepositoryProvider);
  return repository.getActiveJob();
}

@riverpod
Future<List<Job>> completedJobs(CompletedJobsRef ref) {
  final repository = ref.watch(professionalJobRepositoryProvider);
  return repository.getCompletedJobs();
}

@riverpod
class JobRequestsController extends _$JobRequestsController {
  @override
  FutureOr<void> build() {
    // Initial state is void
  }

  Future<void> acceptJobRequest(String jobId) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(professionalJobRepositoryProvider);
      await repository.acceptJob(jobId);

      // Refresh job requests and active job
      ref.invalidate(jobRequestsProvider);
      ref.invalidate(activeJobProvider);

      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> rejectJobRequest(String jobId, String reason) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(professionalJobRepositoryProvider);
      await repository.rejectJob(jobId, reason);

      // Refresh job requests
      ref.invalidate(jobRequestsProvider);

      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}

@riverpod
class ActiveJobController extends _$ActiveJobController {
  @override
  FutureOr<void> build() {
    // Initial state is void
  }

  Future<void> startJob(String jobId) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(professionalJobRepositoryProvider);
      await repository.startJob(jobId);

      // Refresh active job
      ref.invalidate(activeJobProvider);

      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> completeJob(
    String jobId, {
    required double finalPrice,
    String? notes,
    List<String>? photos,
  }) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(professionalJobRepositoryProvider);
      await repository.completeJob(
        jobId,
        finalPrice: finalPrice,
        notes: notes,
        photos: photos,
      );

      // Refresh active job and completed jobs
      ref.invalidate(activeJobProvider);
      ref.invalidate(completedJobsProvider);

      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> cancelJob(String jobId, String reason) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(professionalJobRepositoryProvider);
      await repository.cancelJob(jobId, reason);

      // Refresh active job
      ref.invalidate(activeJobProvider);

      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
