import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../active_job_provider.dart';
import '../../../jobs/models/job.dart';
import 'package:flutter/foundation.dart';

part 'job_stage_providers.g.dart';

@riverpod
class ActiveJobStage extends AutoDisposeNotifier<JobStage> {
  @override
  JobStage build() {
    final job = ref.watch(activeJobProvider).value;
    return job?.stage ?? JobStage.enRoute;
  }

  Future<void> updateStage(JobStage newStage) async {
    state = newStage;
    // Simulate backend delay
    await Future.delayed(const Duration(milliseconds: 100));
  }
}

// En Route Stage
@riverpod
class EnRouteState extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<void> markAsArrived(Job job) async {
    if (state is AsyncLoading) return;

    try {
      state = const AsyncLoading();

      // Update the stage using the provider from active_job_provider.dart
      await ref
          .read(activeJobProvider.notifier)
          .updateStage(JobStage.atLocation);

      // Complete successfully
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }
}

// At Location Stage
@riverpod
class AtLocationState extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    return null;
  }

  // State for verification items
  final Map<String, bool> _verificationStatus = {
    'location': false,
    'photos': false,
  };

  // State for safety checklist
  final Map<String, bool> _safetyChecklist = {
    'ppe': false,
    'areaSafety': false,
    'tools': false,
  };

  Future<void> verifyLocation() async {
    if (state.isLoading) return;

    state = const AsyncLoading();
    try {
      _verificationStatus['location'] = true;
      await Future.delayed(const Duration(seconds: 1));
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> addSitePhoto(String photoUrl) async {
    if (state.isLoading) return;

    state = const AsyncLoading();
    try {
      _verificationStatus['photos'] = true;
      await Future.delayed(const Duration(seconds: 1));
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> toggleSafetyItem(String itemId) async {
    if (state.isLoading) return;

    state = const AsyncLoading();
    try {
      if (_safetyChecklist.containsKey(itemId)) {
        _safetyChecklist[itemId] = !_safetyChecklist[itemId]!;
      }
      await Future.delayed(const Duration(seconds: 1));
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  bool isVerificationComplete(String item) {
    return _verificationStatus[item] ?? false;
  }

  bool isSafetyItemChecked(String item) {
    return _safetyChecklist[item] ?? false;
  }

  Future<void> startTimer() async {
    if (state.isLoading) return;

    state = const AsyncLoading();
    try {
      // Simulate starting a timer
      await Future.delayed(const Duration(seconds: 1));
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> updateElapsedTime(String elapsedTime) async {
    if (state.isLoading) return;

    state = const AsyncLoading();
    try {
      // Simulate updating elapsed time
      await Future.delayed(const Duration(seconds: 1));
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<bool> canStartDiagnosis() async {
    debugPrint('🔍 Checking if can start diagnosis...');

    // For development, always allow starting diagnosis
    debugPrint('✅ Development mode: always allowing diagnosis to start');
    return true;
  }

  Future<void> startDiagnosis(Job job) async {
    debugPrint('🚀 Starting diagnosis for job ${job.id}...');

    if (state.isLoading) {
      debugPrint('⚠️ State is loading, cannot start diagnosis');
      return;
    }

    try {
      // First check if we can start
      final canStart = await canStartDiagnosis();
      debugPrint('📋 Can start diagnosis: $canStart');

      if (!canStart) {
        throw Exception(
            'Please complete all required verifications and safety checks');
      }

      // Only set loading state after we know we can proceed
      state = const AsyncLoading();

      debugPrint('⏳ Simulating diagnosis start...');
      await Future.delayed(const Duration(seconds: 1));

      debugPrint('📤 Updating job stage to diagnosis...');
      await ref
          .read(activeJobProvider.notifier)
          .updateStage(JobStage.diagnosis);

      debugPrint('✅ Diagnosis started successfully');
      state = const AsyncData(null);
    } catch (e, stack) {
      debugPrint('❌ Error in startDiagnosis: $e');
      state = AsyncError(e, stack);
      rethrow;
    }
  }
}

// Diagnosis Stage
@riverpod
class DiagnosisState extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<void> updateSelectedCategories(List<String> categories) async {
    if (state is AsyncLoading) return;

    try {
      state = const AsyncLoading();

      // Simulate updating selected categories
      await Future.delayed(const Duration(seconds: 1));

      // Complete successfully
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> addPhoto(String photoUrl) async {
    if (state is AsyncLoading) return;

    try {
      state = const AsyncLoading();

      // Simulate adding a photo
      await Future.delayed(const Duration(seconds: 1));

      // Complete successfully
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> updateNotes(String notes) async {
    if (state is AsyncLoading) return;

    try {
      state = const AsyncLoading();

      // Simulate updating notes
      await Future.delayed(const Duration(seconds: 1));

      // Complete successfully
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> submitDiagnosis(Job job) async {
    if (state is AsyncLoading) return;

    try {
      state = const AsyncLoading();

      // Simulate submitting diagnosis
      await Future.delayed(const Duration(seconds: 1));

      // Complete successfully
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }
}

// Quote Stage
@riverpod
class QuoteState extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<void> addServiceItem(Map<String, dynamic> item) async {
    if (state is AsyncLoading) return;

    try {
      state = const AsyncLoading();

      // Simulate adding a service item
      await Future.delayed(const Duration(seconds: 1));

      // Complete successfully
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> addMaterial(Map<String, dynamic> material) async {
    if (state is AsyncLoading) return;

    try {
      state = const AsyncLoading();

      // Simulate adding a material
      await Future.delayed(const Duration(seconds: 1));

      // Complete successfully
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> updateLaborCost(double cost) async {
    if (state is AsyncLoading) return;

    try {
      state = const AsyncLoading();

      // Simulate updating labor cost
      await Future.delayed(const Duration(seconds: 1));

      // Complete successfully
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> updateNotes(String notes) async {
    if (state is AsyncLoading) return;

    try {
      state = const AsyncLoading();

      // Simulate updating notes
      await Future.delayed(const Duration(seconds: 1));

      // Complete successfully
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> submitQuote(Job job) async {
    if (state is AsyncLoading) return;

    try {
      state = const AsyncLoading();

      // Simulate submitting quote
      await Future.delayed(const Duration(seconds: 1));

      // Complete successfully
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }
}

// In Progress Stage
@riverpod
class InProgressState extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<void> addTask(String title) async {
    if (state.isLoading) return;

    state = const AsyncLoading();
    try {
      // Simulate adding a task
      await Future.delayed(const Duration(seconds: 1));
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> toggleTask(int index) async {
    if (state.isLoading) return;

    state = const AsyncLoading();
    try {
      // Simulate toggling a task
      await Future.delayed(const Duration(seconds: 1));
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> updateMaterialUsage(int index, int usedQuantity) async {
    if (state.isLoading) return;

    state = const AsyncLoading();
    try {
      // Simulate updating material usage
      await Future.delayed(const Duration(seconds: 1));
      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> completeJob(Job job) async {
    if (state.isLoading) return;

    state = const AsyncLoading();
    try {
      // Simulate completing a job
      await Future.delayed(const Duration(seconds: 1));

      // Update the job stage
      await ref
          .read(activeJobProvider.notifier)
          .updateStage(JobStage.completion);

      state = const AsyncData(null);
    } catch (e, stack) {
      state = AsyncError(e, stack);
      rethrow;
    }
  }
}

// Completion Stage
@riverpod
class CompletionState extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    debugPrint('🔄 CompletionState: Building with initial state');
    return const AsyncData(null);
  }

  Future<void> toggleChecklistItem(int index) async {
    debugPrint('📝 CompletionState: Toggling checklist item at index $index');
    if (state.isLoading) {
      debugPrint('⚠️ CompletionState: Already loading, ignoring toggle');
      return;
    }

    state = const AsyncLoading();
    try {
      debugPrint('⏳ CompletionState: Simulating toggle operation');
      await Future.delayed(const Duration(seconds: 1));
      debugPrint('✅ CompletionState: Toggle successful');
      state = const AsyncData(null);
    } catch (e, stack) {
      debugPrint('❌ CompletionState: Toggle failed - $e');
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> addPhoto(String photoUrl) async {
    debugPrint('📸 CompletionState: Adding photo: $photoUrl');
    if (state.isLoading) {
      debugPrint('⚠️ CompletionState: Already loading, ignoring photo add');
      return;
    }

    state = const AsyncLoading();
    try {
      debugPrint('⏳ CompletionState: Simulating photo addition');
      await Future.delayed(const Duration(seconds: 1));
      debugPrint('✅ CompletionState: Photo added successfully');
      state = const AsyncData(null);
    } catch (e, stack) {
      debugPrint('❌ CompletionState: Photo addition failed - $e');
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> setSignature(String signatureUrl) async {
    debugPrint('✍️ CompletionState: Setting signature: $signatureUrl');
    if (state.isLoading) {
      debugPrint('⚠️ CompletionState: Already loading, ignoring signature set');
      return;
    }

    state = const AsyncLoading();
    try {
      debugPrint('⏳ CompletionState: Simulating signature set');
      await Future.delayed(const Duration(seconds: 1));
      debugPrint('✅ CompletionState: Signature set successfully');
      state = const AsyncData(null);
    } catch (e, stack) {
      debugPrint('❌ CompletionState: Signature set failed - $e');
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> clearSignature() async {
    debugPrint('🗑️ CompletionState: Clearing signature');
    if (state.isLoading) {
      debugPrint(
          '⚠️ CompletionState: Already loading, ignoring signature clear');
      return;
    }

    state = const AsyncLoading();
    try {
      debugPrint('⏳ CompletionState: Simulating signature clear');
      await Future.delayed(const Duration(seconds: 1));
      debugPrint('✅ CompletionState: Signature cleared successfully');
      state = const AsyncData(null);
    } catch (e, stack) {
      debugPrint('❌ CompletionState: Signature clear failed - $e');
      state = AsyncError(e, stack);
      rethrow;
    }
  }

  Future<void> finalizeJob(Job job) async {
    debugPrint('🎯 CompletionState: Finalizing job ${job.id}');
    if (state.isLoading) {
      debugPrint('⚠️ CompletionState: Already loading, ignoring finalize');
      return;
    }

    state = const AsyncLoading();
    try {
      debugPrint('⏳ CompletionState: Simulating job finalization');
      await Future.delayed(const Duration(seconds: 1));

      debugPrint('📤 CompletionState: Updating job stage to completed');
      await ref
          .read(activeJobProvider.notifier)
          .updateStage(JobStage.completed);

      debugPrint('✅ CompletionState: Job finalized successfully');
      state = const AsyncData(null);
    } catch (e, stack) {
      debugPrint('❌ CompletionState: Job finalization failed - $e');
      state = AsyncError(e, stack);
      rethrow;
    }
  }
}
