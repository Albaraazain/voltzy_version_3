// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'homeowner_job.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HomeownerJob _$HomeownerJobFromJson(Map<String, dynamic> json) {
  return _HomeownerJob.fromJson(json);
}

/// @nodoc
mixin _$HomeownerJob {
  @JobConverter()
  Job get job => throw _privateConstructorUsedError;
  HomeownerJobStatus get status => throw _privateConstructorUsedError;
  DateTime get requestedTime => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String? get preferredTime => throw _privateConstructorUsedError;
  String? get additionalNotes => throw _privateConstructorUsedError;
  double? get budget => throw _privateConstructorUsedError;

  /// Serializes this HomeownerJob to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeownerJob
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeownerJobCopyWith<HomeownerJob> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeownerJobCopyWith<$Res> {
  factory $HomeownerJobCopyWith(
          HomeownerJob value, $Res Function(HomeownerJob) then) =
      _$HomeownerJobCopyWithImpl<$Res, HomeownerJob>;
  @useResult
  $Res call(
      {@JobConverter() Job job,
      HomeownerJobStatus status,
      DateTime requestedTime,
      List<String> images,
      String category,
      String? preferredTime,
      String? additionalNotes,
      double? budget});

  $JobCopyWith<$Res> get job;
}

/// @nodoc
class _$HomeownerJobCopyWithImpl<$Res, $Val extends HomeownerJob>
    implements $HomeownerJobCopyWith<$Res> {
  _$HomeownerJobCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeownerJob
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? job = null,
    Object? status = null,
    Object? requestedTime = null,
    Object? images = null,
    Object? category = null,
    Object? preferredTime = freezed,
    Object? additionalNotes = freezed,
    Object? budget = freezed,
  }) {
    return _then(_value.copyWith(
      job: null == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as Job,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as HomeownerJobStatus,
      requestedTime: null == requestedTime
          ? _value.requestedTime
          : requestedTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      preferredTime: freezed == preferredTime
          ? _value.preferredTime
          : preferredTime // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalNotes: freezed == additionalNotes
          ? _value.additionalNotes
          : additionalNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      budget: freezed == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }

  /// Create a copy of HomeownerJob
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
abstract class _$$HomeownerJobImplCopyWith<$Res>
    implements $HomeownerJobCopyWith<$Res> {
  factory _$$HomeownerJobImplCopyWith(
          _$HomeownerJobImpl value, $Res Function(_$HomeownerJobImpl) then) =
      __$$HomeownerJobImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JobConverter() Job job,
      HomeownerJobStatus status,
      DateTime requestedTime,
      List<String> images,
      String category,
      String? preferredTime,
      String? additionalNotes,
      double? budget});

  @override
  $JobCopyWith<$Res> get job;
}

/// @nodoc
class __$$HomeownerJobImplCopyWithImpl<$Res>
    extends _$HomeownerJobCopyWithImpl<$Res, _$HomeownerJobImpl>
    implements _$$HomeownerJobImplCopyWith<$Res> {
  __$$HomeownerJobImplCopyWithImpl(
      _$HomeownerJobImpl _value, $Res Function(_$HomeownerJobImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeownerJob
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? job = null,
    Object? status = null,
    Object? requestedTime = null,
    Object? images = null,
    Object? category = null,
    Object? preferredTime = freezed,
    Object? additionalNotes = freezed,
    Object? budget = freezed,
  }) {
    return _then(_$HomeownerJobImpl(
      job: null == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as Job,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as HomeownerJobStatus,
      requestedTime: null == requestedTime
          ? _value.requestedTime
          : requestedTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      preferredTime: freezed == preferredTime
          ? _value.preferredTime
          : preferredTime // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalNotes: freezed == additionalNotes
          ? _value.additionalNotes
          : additionalNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      budget: freezed == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeownerJobImpl implements _HomeownerJob {
  const _$HomeownerJobImpl(
      {@JobConverter() required this.job,
      required this.status,
      required this.requestedTime,
      required final List<String> images,
      required this.category,
      this.preferredTime,
      this.additionalNotes,
      this.budget})
      : _images = images;

  factory _$HomeownerJobImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeownerJobImplFromJson(json);

  @override
  @JobConverter()
  final Job job;
  @override
  final HomeownerJobStatus status;
  @override
  final DateTime requestedTime;
  final List<String> _images;
  @override
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final String category;
  @override
  final String? preferredTime;
  @override
  final String? additionalNotes;
  @override
  final double? budget;

  @override
  String toString() {
    return 'HomeownerJob(job: $job, status: $status, requestedTime: $requestedTime, images: $images, category: $category, preferredTime: $preferredTime, additionalNotes: $additionalNotes, budget: $budget)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeownerJobImpl &&
            (identical(other.job, job) || other.job == job) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.requestedTime, requestedTime) ||
                other.requestedTime == requestedTime) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.preferredTime, preferredTime) ||
                other.preferredTime == preferredTime) &&
            (identical(other.additionalNotes, additionalNotes) ||
                other.additionalNotes == additionalNotes) &&
            (identical(other.budget, budget) || other.budget == budget));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      job,
      status,
      requestedTime,
      const DeepCollectionEquality().hash(_images),
      category,
      preferredTime,
      additionalNotes,
      budget);

  /// Create a copy of HomeownerJob
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeownerJobImplCopyWith<_$HomeownerJobImpl> get copyWith =>
      __$$HomeownerJobImplCopyWithImpl<_$HomeownerJobImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeownerJobImplToJson(
      this,
    );
  }
}

abstract class _HomeownerJob implements HomeownerJob {
  const factory _HomeownerJob(
      {@JobConverter() required final Job job,
      required final HomeownerJobStatus status,
      required final DateTime requestedTime,
      required final List<String> images,
      required final String category,
      final String? preferredTime,
      final String? additionalNotes,
      final double? budget}) = _$HomeownerJobImpl;

  factory _HomeownerJob.fromJson(Map<String, dynamic> json) =
      _$HomeownerJobImpl.fromJson;

  @override
  @JobConverter()
  Job get job;
  @override
  HomeownerJobStatus get status;
  @override
  DateTime get requestedTime;
  @override
  List<String> get images;
  @override
  String get category;
  @override
  String? get preferredTime;
  @override
  String? get additionalNotes;
  @override
  double? get budget;

  /// Create a copy of HomeownerJob
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeownerJobImplCopyWith<_$HomeownerJobImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
