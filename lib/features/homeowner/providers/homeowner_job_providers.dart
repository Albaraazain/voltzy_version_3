import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voltzy_version_3/features/jobs/models/job.dart';
import 'package:voltzy_version_3/features/homeowner/repositories/homeowner_job_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'homeowner_job_providers.g.dart';

@riverpod
HomeownerJobRepository homeownerJobRepository(Ref ref) {
  return HomeownerJobRepository();
}

@riverpod
Future<List<Job>> homeownerMyJobs(Ref ref) async {
  final repository = ref.watch(homeownerJobRepositoryProvider);
  return repository.getMyJobs();
}

@riverpod
Future<List<Job>> homeownerActiveJobs(Ref ref) async {
  final repository = ref.watch(homeownerJobRepositoryProvider);
  final jobs = await repository.getMyJobs();
  return jobs.where((job) => job.status.isActive).toList();
}

@riverpod
Future<List<Job>> homeownerCompletedJobs(Ref ref) async {
  final repository = ref.watch(homeownerJobRepositoryProvider);
  return repository.getCompletedJobs();
}

@riverpod
Future<Job> homeownerJobDetails(
  Ref ref,
  String jobId,
) async {
  final repository = ref.watch(homeownerJobRepositoryProvider);
  return repository.getJob(jobId);
}

@riverpod
class CreateJob extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() async {
    // Initial state is void
  }

  Future<Job?> createJob({
    required String title,
    required String description,
    required String address,
    required double latitude,
    required double longitude,
    required JobUrgency urgency,
    required String category,
    required String subcategory,
    required String homeownerId,
    required String homeownerName,
    required String homeownerPhoneNumber,
  }) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(homeownerJobRepositoryProvider);
      final job = await repository.createJob(
        title: title,
        description: description,
        address: address,
        latitude: latitude,
        longitude: longitude,
        urgency: urgency,
        category: category,
        subcategory: subcategory,
        homeownerId: homeownerId,
        homeownerName: homeownerName,
        homeownerPhoneNumber: homeownerPhoneNumber,
      );

      // Refresh job lists
      ref.invalidate(homeownerMyJobsProvider);
      ref.invalidate(homeownerCompletedJobsProvider);

      state = const AsyncData(null);
      return job;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return null;
    }
  }
}

@riverpod
class CancelJob extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() async {
    // Initial state is void
  }

  Future<Job?> cancelJob(String jobId, String reason) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(homeownerJobRepositoryProvider);
      final job = await repository.cancelJob(jobId, reason);

      // Refresh job lists
      ref.invalidate(homeownerMyJobsProvider);
      ref.invalidate(homeownerCompletedJobsProvider);

      state = const AsyncData(null);
      return job;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return null;
    }
  }
}

@riverpod
class RateJob extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() async {
    // Initial state is void
  }

  Future<Job?> rateJob(String jobId, double rating, String review) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(homeownerJobRepositoryProvider);
      final job = await repository.rateJob(jobId, rating, review);

      // Refresh job lists
      ref.invalidate(homeownerMyJobsProvider);
      ref.invalidate(homeownerCompletedJobsProvider);

      state = const AsyncData(null);
      return job;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return null;
    }
  }
}
