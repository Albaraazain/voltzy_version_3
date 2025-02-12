import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voltzy_version_3/features/jobs/models/job.dart';
import 'package:voltzy_version_3/features/homeowner/repositories/homeowner_job_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:voltzy_version_3/features/professional/models/professional.dart';

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
  // Mock data for testing different job stages
  return [
    Job(
      id: '1',
      title: 'Electrical Repair - Circuit Issue',
      description: 'Faulty circuit breaker needs replacement',
      location: const Location(
        address: '123 Main St, San Francisco, CA',
        latitude: 37.7749,
        longitude: -122.4194,
      ),
      stage: JobStage.enRoute,
      status: JobStatus.inProgress,
      urgency: JobUrgency.high,
      createdAt: DateTime.now(),
      homeownerId: 'client1',
      homeownerName: 'John Doe',
      homeownerPhoneNumber: '+1234567890',
      professional: const Professional(
        id: 'p1',
        name: 'John Smith',
        rating: 4.8,
        completedJobs: 156,
        responseRate: 0.95,
      ),
      category: 'Electrical',
      subcategory: 'Circuit Repair',
    ),
    Job(
      id: '2',
      title: 'HVAC Maintenance',
      description: 'Annual AC system inspection and maintenance',
      location: const Location(
        address: '456 Oak Ave, San Francisco, CA',
        latitude: 37.7749,
        longitude: -122.4194,
      ),
      stage: JobStage.atLocation,
      status: JobStatus.inProgress,
      urgency: JobUrgency.medium,
      createdAt: DateTime.now(),
      homeownerId: 'client1',
      homeownerName: 'John Doe',
      homeownerPhoneNumber: '+1234567890',
      professional: const Professional(
        id: 'p2',
        name: 'Mike Johnson',
        rating: 4.9,
        completedJobs: 243,
        responseRate: 0.98,
      ),
      category: 'HVAC',
      subcategory: 'Maintenance',
    ),
    Job(
      id: '3',
      title: 'Plumbing Inspection',
      description: 'Investigate low water pressure issue',
      location: const Location(
        address: '789 Pine St, San Francisco, CA',
        latitude: 37.7749,
        longitude: -122.4194,
      ),
      stage: JobStage.diagnosis,
      status: JobStatus.inProgress,
      urgency: JobUrgency.low,
      createdAt: DateTime.now(),
      homeownerId: 'client1',
      homeownerName: 'John Doe',
      homeownerPhoneNumber: '+1234567890',
      professional: const Professional(
        id: 'p3',
        name: 'Sarah Wilson',
        rating: 4.7,
        completedJobs: 128,
        responseRate: 0.92,
      ),
      notes: 'Checking main water line and pressure issues',
      photos: [
        'https://picsum.photos/200',
        'https://picsum.photos/201',
      ],
      category: 'Plumbing',
      subcategory: 'Inspection',
    ),
    Job(
      id: '4',
      title: 'Water Heater Replacement',
      description: 'Old water heater needs complete replacement',
      location: const Location(
        address: '321 Elm St, San Francisco, CA',
        latitude: 37.7749,
        longitude: -122.4194,
      ),
      stage: JobStage.quoteCreation,
      status: JobStatus.inProgress,
      urgency: JobUrgency.medium,
      createdAt: DateTime.now(),
      homeownerId: 'client1',
      homeownerName: 'John Doe',
      homeownerPhoneNumber: '+1234567890',
      professional: const Professional(
        id: 'p4',
        name: 'David Brown',
        rating: 4.9,
        completedJobs: 312,
        responseRate: 0.97,
      ),
      notes: 'Old water heater needs complete replacement',
      photos: [
        'https://picsum.photos/202',
        'https://picsum.photos/203',
      ],
      finalPrice: 1200.00,
      category: 'Plumbing',
      subcategory: 'Installation',
      estimatedDuration: const Duration(hours: 4),
    ),
    Job(
      id: '5',
      title: 'Kitchen Remodel - Electrical Work',
      description: 'Installing new electrical outlets and lighting',
      location: const Location(
        address: '654 Maple Dr, San Francisco, CA',
        latitude: 37.7749,
        longitude: -122.4194,
      ),
      stage: JobStage.inProgress,
      status: JobStatus.inProgress,
      urgency: JobUrgency.medium,
      createdAt: DateTime.now(),
      homeownerId: 'client1',
      homeownerName: 'John Doe',
      homeownerPhoneNumber: '+1234567890',
      professional: const Professional(
        id: 'p5',
        name: 'Lisa Anderson',
        rating: 4.8,
        completedJobs: 189,
        responseRate: 0.94,
      ),
      notes: 'Installing new electrical outlets and lighting',
      photos: [
        'https://picsum.photos/204',
        'https://picsum.photos/205',
      ],
      finalPrice: 2500.00,
      category: 'Electrical',
      subcategory: 'Installation',
      estimatedDuration: const Duration(days: 2),
    ),
    Job(
      id: '6',
      title: 'Bathroom Plumbing Renovation',
      description: 'Complete bathroom plumbing upgrade',
      location: const Location(
        address: '987 Cedar Ln, San Francisco, CA',
        latitude: 37.7749,
        longitude: -122.4194,
      ),
      stage: JobStage.completion,
      status: JobStatus.inProgress,
      urgency: JobUrgency.medium,
      createdAt: DateTime.now(),
      homeownerId: 'client1',
      homeownerName: 'John Doe',
      homeownerPhoneNumber: '+1234567890',
      professional: const Professional(
        id: 'p6',
        name: 'Robert Taylor',
        rating: 4.9,
        completedJobs: 275,
        responseRate: 0.96,
      ),
      notes: 'Complete bathroom plumbing upgrade finished',
      photos: [
        'https://picsum.photos/206',
        'https://picsum.photos/207',
        'https://picsum.photos/208',
      ],
      finalPrice: 3500.00,
      category: 'Plumbing',
      subcategory: 'Renovation',
      estimatedDuration: const Duration(days: 3),
    ),
  ];
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
