// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'professional_dashboard_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$professionalDashboardRepositoryHash() =>
    r'c8d2a10df6d5c85fd405dae83dbcd7eb3aa18099';

/// See also [professionalDashboardRepository].
@ProviderFor(professionalDashboardRepository)
final professionalDashboardRepositoryProvider =
    AutoDisposeProvider<ProfessionalDashboardRepository>.internal(
  professionalDashboardRepository,
  name: r'professionalDashboardRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$professionalDashboardRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProfessionalDashboardRepositoryRef
    = AutoDisposeProviderRef<ProfessionalDashboardRepository>;
String _$dashboardMetricsHash() => r'68b607767c42404e096cda1d041a87e230c5c9c5';

/// See also [dashboardMetrics].
@ProviderFor(dashboardMetrics)
final dashboardMetricsProvider =
    AutoDisposeFutureProvider<List<Metric>>.internal(
  dashboardMetrics,
  name: r'dashboardMetricsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dashboardMetricsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DashboardMetricsRef = AutoDisposeFutureProviderRef<List<Metric>>;
String _$jobRequestsHash() => r'08eb805e93cd72f72d067f65f0bf5302925eb906';

/// See also [jobRequests].
@ProviderFor(jobRequests)
final jobRequestsProvider =
    AutoDisposeFutureProvider<List<request.JobRequest>>.internal(
  jobRequests,
  name: r'jobRequestsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$jobRequestsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef JobRequestsRef = AutoDisposeFutureProviderRef<List<request.JobRequest>>;
String _$activeJobHash() => r'fc28d1f376cdeccd70d50ee2c5510274fd110ec4';

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
String _$onlineStatusHash() => r'0faf1772a0d479673cd054006efe0d3ee1990996';

/// See also [OnlineStatus].
@ProviderFor(OnlineStatus)
final onlineStatusProvider =
    AutoDisposeNotifierProvider<OnlineStatus, bool>.internal(
  OnlineStatus.new,
  name: r'onlineStatusProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$onlineStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OnlineStatus = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
