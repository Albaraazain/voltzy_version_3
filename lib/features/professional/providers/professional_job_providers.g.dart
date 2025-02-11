// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'professional_job_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$professionalJobRepositoryHash() =>
    r'75fb1fbf26f464ab5edc5fcf9aad85b7ce91583e';

/// See also [professionalJobRepository].
@ProviderFor(professionalJobRepository)
final professionalJobRepositoryProvider =
    AutoDisposeProvider<ProfessionalJobRepository>.internal(
  professionalJobRepository,
  name: r'professionalJobRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$professionalJobRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProfessionalJobRepositoryRef
    = AutoDisposeProviderRef<ProfessionalJobRepository>;
String _$jobRequestsHash() => r'a685cf32a68b5bea6d57cf493d494ccd86e4a265';

/// See also [jobRequests].
@ProviderFor(jobRequests)
final jobRequestsProvider = AutoDisposeFutureProvider<List<Job>>.internal(
  jobRequests,
  name: r'jobRequestsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$jobRequestsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef JobRequestsRef = AutoDisposeFutureProviderRef<List<Job>>;
String _$activeJobHash() => r'e21a5c85c24320788357192ffbae9a98f13cbbf2';

/// See also [activeJob].
@ProviderFor(activeJob)
final activeJobProvider = AutoDisposeFutureProvider<Job?>.internal(
  activeJob,
  name: r'activeJobProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$activeJobHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveJobRef = AutoDisposeFutureProviderRef<Job?>;
String _$completedJobsHash() => r'672e1a3d9ecba6b71f272a8028a828c856930fd3';

/// See also [completedJobs].
@ProviderFor(completedJobs)
final completedJobsProvider = AutoDisposeFutureProvider<List<Job>>.internal(
  completedJobs,
  name: r'completedJobsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$completedJobsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CompletedJobsRef = AutoDisposeFutureProviderRef<List<Job>>;
String _$jobRequestsControllerHash() =>
    r'2179c429182345d75ac25f4599bf6be253fc8068';

/// See also [JobRequestsController].
@ProviderFor(JobRequestsController)
final jobRequestsControllerProvider =
    AutoDisposeAsyncNotifierProvider<JobRequestsController, void>.internal(
  JobRequestsController.new,
  name: r'jobRequestsControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$jobRequestsControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$JobRequestsController = AutoDisposeAsyncNotifier<void>;
String _$activeJobControllerHash() =>
    r'0b7c9bff4b5d13cea07f04230e921a4af6bba806';

/// See also [ActiveJobController].
@ProviderFor(ActiveJobController)
final activeJobControllerProvider =
    AutoDisposeAsyncNotifierProvider<ActiveJobController, void>.internal(
  ActiveJobController.new,
  name: r'activeJobControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeJobControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ActiveJobController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
