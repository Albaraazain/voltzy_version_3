// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'professional_job.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProfessionalJob _$ProfessionalJobFromJson(Map<String, dynamic> json) {
  return _ProfessionalJob.fromJson(json);
}

/// @nodoc
mixin _$ProfessionalJob {
  @JobConverter()
  Job get job => throw _privateConstructorUsedError;
  JobStage get stage => throw _privateConstructorUsedError;
  JobStatus get status => throw _privateConstructorUsedError;
  JobUrgency get urgency => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get completionTime => throw _privateConstructorUsedError;

  /// Serializes this ProfessionalJob to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfessionalJob
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfessionalJobCopyWith<ProfessionalJob> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfessionalJobCopyWith<$Res> {
  factory $ProfessionalJobCopyWith(
          ProfessionalJob value, $Res Function(ProfessionalJob) then) =
      _$ProfessionalJobCopyWithImpl<$Res, ProfessionalJob>;
  @useResult
  $Res call(
      {@JobConverter() Job job,
      JobStage stage,
      JobStatus status,
      JobUrgency urgency,
      DateTime createdAt,
      String? notes,
      DateTime? completionTime});

  $JobCopyWith<$Res> get job;
}

/// @nodoc
class _$ProfessionalJobCopyWithImpl<$Res, $Val extends ProfessionalJob>
    implements $ProfessionalJobCopyWith<$Res> {
  _$ProfessionalJobCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfessionalJob
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? job = null,
    Object? stage = null,
    Object? status = null,
    Object? urgency = null,
    Object? createdAt = null,
    Object? notes = freezed,
    Object? completionTime = freezed,
  }) {
    return _then(_value.copyWith(
      job: null == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as Job,
      stage: null == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as JobStage,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as JobStatus,
      urgency: null == urgency
          ? _value.urgency
          : urgency // ignore: cast_nullable_to_non_nullable
              as JobUrgency,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      completionTime: freezed == completionTime
          ? _value.completionTime
          : completionTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of ProfessionalJob
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $JobCopyWith<$Res> get job {
    return $JobCopyWith<$Res>(_value.job, (value) {
      return _then(_value.copyWith(job: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfessionalJobImplCopyWith<$Res>
    implements $ProfessionalJobCopyWith<$Res> {
  factory _$$ProfessionalJobImplCopyWith(_$ProfessionalJobImpl value,
          $Res Function(_$ProfessionalJobImpl) then) =
      __$$ProfessionalJobImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JobConverter() Job job,
      JobStage stage,
      JobStatus status,
      JobUrgency urgency,
      DateTime createdAt,
      String? notes,
      DateTime? completionTime});

  @override
  $JobCopyWith<$Res> get job;
}

/// @nodoc
class __$$ProfessionalJobImplCopyWithImpl<$Res>
    extends _$ProfessionalJobCopyWithImpl<$Res, _$ProfessionalJobImpl>
    implements _$$ProfessionalJobImplCopyWith<$Res> {
  __$$ProfessionalJobImplCopyWithImpl(
      _$ProfessionalJobImpl _value, $Res Function(_$ProfessionalJobImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfessionalJob
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? job = null,
    Object? stage = null,
    Object? status = null,
    Object? urgency = null,
    Object? createdAt = null,
    Object? notes = freezed,
    Object? completionTime = freezed,
  }) {
    return _then(_$ProfessionalJobImpl(
      job: null == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as Job,
      stage: null == stage
          ? _value.stage
          : stage // ignore: cast_nullable_to_non_nullable
              as JobStage,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as JobStatus,
      urgency: null == urgency
          ? _value.urgency
          : urgency // ignore: cast_nullable_to_non_nullable
              as JobUrgency,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      completionTime: freezed == completionTime
          ? _value.completionTime
          : completionTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfessionalJobImpl implements _ProfessionalJob {
  const _$ProfessionalJobImpl(
      {@JobConverter() required this.job,
      required this.stage,
      required this.status,
      required this.urgency,
      required this.createdAt,
      this.notes,
      this.completionTime});

  factory _$ProfessionalJobImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfessionalJobImplFromJson(json);

  @override
  @JobConverter()
  final Job job;
  @override
  final JobStage stage;
  @override
  final JobStatus status;
  @override
  final JobUrgency urgency;
  @override
  final DateTime createdAt;
  @override
  final String? notes;
  @override
  final DateTime? completionTime;

  @override
  String toString() {
    return 'ProfessionalJob(job: $job, stage: $stage, status: $status, urgency: $urgency, createdAt: $createdAt, notes: $notes, completionTime: $completionTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfessionalJobImpl &&
            (identical(other.job, job) || other.job == job) &&
            (identical(other.stage, stage) || other.stage == stage) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.urgency, urgency) || other.urgency == urgency) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.completionTime, completionTime) ||
                other.completionTime == completionTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, job, stage, status, urgency,
      createdAt, notes, completionTime);

  /// Create a copy of ProfessionalJob
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfessionalJobImplCopyWith<_$ProfessionalJobImpl> get copyWith =>
      __$$ProfessionalJobImplCopyWithImpl<_$ProfessionalJobImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfessionalJobImplToJson(
      this,
    );
  }
}

abstract class _ProfessionalJob implements ProfessionalJob {
  const factory _ProfessionalJob(
      {@JobConverter() required final Job job,
      required final JobStage stage,
      required final JobStatus status,
      required final JobUrgency urgency,
      required final DateTime createdAt,
      final String? notes,
      final DateTime? completionTime}) = _$ProfessionalJobImpl;

  factory _ProfessionalJob.fromJson(Map<String, dynamic> json) =
      _$ProfessionalJobImpl.fromJson;

  @override
  @JobConverter()
  Job get job;
  @override
  JobStage get stage;
  @override
  JobStatus get status;
  @override
  JobUrgency get urgency;
  @override
  DateTime get createdAt;
  @override
  String? get notes;
  @override
  DateTime? get completionTime;

  /// Create a copy of ProfessionalJob
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfessionalJobImplCopyWith<_$ProfessionalJobImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
