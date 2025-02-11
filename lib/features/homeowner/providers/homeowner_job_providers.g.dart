// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homeowner_job_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeownerJobRepositoryHash() =>
    r'4f763ef886d28c301efd08d7a21e6589f1c138d6';

/// See also [homeownerJobRepository].
@ProviderFor(homeownerJobRepository)
final homeownerJobRepositoryProvider =
    AutoDisposeProvider<HomeownerJobRepository>.internal(
  homeownerJobRepository,
  name: r'homeownerJobRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeownerJobRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HomeownerJobRepositoryRef
    = AutoDisposeProviderRef<HomeownerJobRepository>;
String _$homeownerMyJobsHash() => r'3365b068f1e17a10ab259cfca91e2911bc5166e7';

/// See also [homeownerMyJobs].
@ProviderFor(homeownerMyJobs)
final homeownerMyJobsProvider = AutoDisposeFutureProvider<List<Job>>.internal(
  homeownerMyJobs,
  name: r'homeownerMyJobsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeownerMyJobsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HomeownerMyJobsRef = AutoDisposeFutureProviderRef<List<Job>>;
String _$homeownerActiveJobsHash() =>
    r'eddcf0ec5405ec933ad8cde9aa5be5bf7b11ee7c';

/// See also [homeownerActiveJobs].
@ProviderFor(homeownerActiveJobs)
final homeownerActiveJobsProvider =
    AutoDisposeFutureProvider<List<Job>>.internal(
  homeownerActiveJobs,
  name: r'homeownerActiveJobsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeownerActiveJobsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HomeownerActiveJobsRef = AutoDisposeFutureProviderRef<List<Job>>;
String _$homeownerCompletedJobsHash() =>
    r'2527173e8e9ec89150e652f3033c9a82c003f85c';

/// See also [homeownerCompletedJobs].
@ProviderFor(homeownerCompletedJobs)
final homeownerCompletedJobsProvider =
    AutoDisposeFutureProvider<List<Job>>.internal(
  homeownerCompletedJobs,
  name: r'homeownerCompletedJobsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeownerCompletedJobsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HomeownerCompletedJobsRef = AutoDisposeFutureProviderRef<List<Job>>;
String _$homeownerJobDetailsHash() =>
    r'98eb5b659189bb28dc039a814dbde0bf6504401e';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [homeownerJobDetails].
@ProviderFor(homeownerJobDetails)
const homeownerJobDetailsProvider = HomeownerJobDetailsFamily();

/// See also [homeownerJobDetails].
class HomeownerJobDetailsFamily extends Family<AsyncValue<Job>> {
  /// See also [homeownerJobDetails].
  const HomeownerJobDetailsFamily();

  /// See also [homeownerJobDetails].
  HomeownerJobDetailsProvider call(
    String jobId,
  ) {
    return HomeownerJobDetailsProvider(
      jobId,
    );
  }

  @override
  HomeownerJobDetailsProvider getProviderOverride(
    covariant HomeownerJobDetailsProvider provider,
  ) {
    return call(
      provider.jobId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'homeownerJobDetailsProvider';
}

/// See also [homeownerJobDetails].
class HomeownerJobDetailsProvider extends AutoDisposeFutureProvider<Job> {
  /// See also [homeownerJobDetails].
  HomeownerJobDetailsProvider(
    String jobId,
  ) : this._internal(
          (ref) => homeownerJobDetails(
            ref as HomeownerJobDetailsRef,
            jobId,
          ),
          from: homeownerJobDetailsProvider,
          name: r'homeownerJobDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$homeownerJobDetailsHash,
          dependencies: HomeownerJobDetailsFamily._dependencies,
          allTransitiveDependencies:
              HomeownerJobDetailsFamily._allTransitiveDependencies,
          jobId: jobId,
        );

  HomeownerJobDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.jobId,
  }) : super.internal();

  final String jobId;

  @override
  Override overrideWith(
    FutureOr<Job> Function(HomeownerJobDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HomeownerJobDetailsProvider._internal(
        (ref) => create(ref as HomeownerJobDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        jobId: jobId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Job> createElement() {
    return _HomeownerJobDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HomeownerJobDetailsProvider && other.jobId == jobId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, jobId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HomeownerJobDetailsRef on AutoDisposeFutureProviderRef<Job> {
  /// The parameter `jobId` of this provider.
  String get jobId;
}

class _HomeownerJobDetailsProviderElement
    extends AutoDisposeFutureProviderElement<Job> with HomeownerJobDetailsRef {
  _HomeownerJobDetailsProviderElement(super.provider);

  @override
  String get jobId => (origin as HomeownerJobDetailsProvider).jobId;
}

String _$createJobHash() => r'e4bc56fe54d92f1ab9d806af799791a9cc8eedd2';

/// See also [CreateJob].
@ProviderFor(CreateJob)
final createJobProvider =
    AutoDisposeAsyncNotifierProvider<CreateJob, void>.internal(
  CreateJob.new,
  name: r'createJobProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$createJobHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CreateJob = AutoDisposeAsyncNotifier<void>;
String _$cancelJobHash() => r'a0abbfcbcd3cd1922267dd96241b4eb0f6208104';

/// See also [CancelJob].
@ProviderFor(CancelJob)
final cancelJobProvider =
    AutoDisposeAsyncNotifierProvider<CancelJob, void>.internal(
  CancelJob.new,
  name: r'cancelJobProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cancelJobHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CancelJob = AutoDisposeAsyncNotifier<void>;
String _$rateJobHash() => r'0c53a6f2c34e3d3490f426b7e93398e66f70ae6a';

/// See also [RateJob].
@ProviderFor(RateJob)
final rateJobProvider =
    AutoDisposeAsyncNotifierProvider<RateJob, void>.internal(
  RateJob.new,
  name: r'rateJobProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$rateJobHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RateJob = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
