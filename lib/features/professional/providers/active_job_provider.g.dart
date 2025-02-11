// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_job_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activeJobHash() => r'dea7455d0dbe2f308594da39b65325cc9985dba0';

/// See also [ActiveJob].
@ProviderFor(ActiveJob)
final activeJobProvider =
    AutoDisposeStreamNotifierProvider<ActiveJob, Job?>.internal(
  ActiveJob.new,
  name: r'activeJobProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$activeJobHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ActiveJob = AutoDisposeStreamNotifier<Job?>;
String _$activeJobStageHash() => r'7f65ccc0ced50229d92a2a296b8ebb62017b8cba';

/// See also [ActiveJobStage].
@ProviderFor(ActiveJobStage)
final activeJobStageProvider =
    AutoDisposeNotifierProvider<ActiveJobStage, JobStage>.internal(
  ActiveJobStage.new,
  name: r'activeJobStageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$activeJobStageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ActiveJobStage = AutoDisposeNotifier<JobStage>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
