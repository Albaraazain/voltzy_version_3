// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Job _$JobFromJson(Map<String, dynamic> json) {
  return _Job.fromJson(json);
}

/// @nodoc
mixin _$Job {
  String get id => throw _privateConstructorUsedError;
  String get homeownerName => throw _privateConstructorUsedError;
  String get homeownerPhoneNumber => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get subcategory => throw _privateConstructorUsedError;
  String get serviceType => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @LocationConverter()
  Location get location => throw _privateConstructorUsedError;
  JobStage get stage => throw _privateConstructorUsedError;
  JobStatus get status => throw _privateConstructorUsedError;
  JobUrgency get urgency => throw _privateConstructorUsedError;
  double get budget => throw _privateConstructorUsedError;
  int get estimatedDuration => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String? get professionalId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get professional => throw _privateConstructorUsedError;
  double? get finalPrice => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  String? get review => throw _privateConstructorUsedError;
  List<String> get photos => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this Job to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $JobCopyWith<Job> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobCopyWith<$Res> {
  factory $JobCopyWith(Job value, $Res Function(Job) then) =
      _$JobCopyWithImpl<$Res, Job>;
  @useResult
  $Res call(
      {String id,
      String homeownerName,
      String homeownerPhoneNumber,
      String category,
      String subcategory,
      String serviceType,
      String title,
      String description,
      @LocationConverter() Location location,
      JobStage stage,
      JobStatus status,
      JobUrgency urgency,
      double budget,
      int estimatedDuration,
      DateTime createdAt,
      DateTime updatedAt,
      String? professionalId,
      Map<String, dynamic>? professional,
      double? finalPrice,
      double? rating,
      String? review,
      List<String> photos,
      String? notes,
      DateTime? completedAt});

  $LocationCopyWith<$Res> get location;
}

/// @nodoc
class _$JobCopyWithImpl<$Res, $Val extends Job> implements $JobCopyWith<$Res> {
  _$JobCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? homeownerName = null,
    Object? homeownerPhoneNumber = null,
    Object? category = null,
    Object? subcategory = null,
    Object? serviceType = null,
    Object? title = null,
    Object? description = null,
    Object? location = null,
    Object? stage = null,
    Object? status = null,
    Object? urgency = null,
    Object? budget = null,
    Object? estimatedDuration = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? professionalId = freezed,
    Object? professional = freezed,
    Object? finalPrice = freezed,
    Object? rating = freezed,
    Object? review = freezed,
    Object? photos = null,
    Object? notes = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      homeownerName: null == homeownerName
          ? _value.homeownerName
          : homeownerName // ignore: cast_nullable_to_non_nullable
              as String,
      homeownerPhoneNumber: null == homeownerPhoneNumber
          ? _value.homeownerPhoneNumber
          : homeownerPhoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      subcategory: null == subcategory
          ? _value.subcategory
          : subcategory // ignore: cast_nullable_to_non_nullable
              as String,
      serviceType: null == serviceType
          ? _value.serviceType
          : serviceType // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location,
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
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDuration: null == estimatedDuration
          ? _value.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      professionalId: freezed == professionalId
          ? _value.professionalId
          : professionalId // ignore: cast_nullable_to_non_nullable
              as String?,
      professional: freezed == professional
          ? _value.professional
          : professional // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      finalPrice: freezed == finalPrice
          ? _value.finalPrice
          : finalPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      review: freezed == review
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as String?,
      photos: null == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res> get location {
    return $LocationCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JobImplCopyWith<$Res> implements $JobCopyWith<$Res> {
  factory _$$JobImplCopyWith(_$JobImpl value, $Res Function(_$JobImpl) then) =
      __$$JobImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String homeownerName,
      String homeownerPhoneNumber,
      String category,
      String subcategory,
      String serviceType,
      String title,
      String description,
      @LocationConverter() Location location,
      JobStage stage,
      JobStatus status,
      JobUrgency urgency,
      double budget,
      int estimatedDuration,
      DateTime createdAt,
      DateTime updatedAt,
      String? professionalId,
      Map<String, dynamic>? professional,
      double? finalPrice,
      double? rating,
      String? review,
      List<String> photos,
      String? notes,
      DateTime? completedAt});

  @override
  $LocationCopyWith<$Res> get location;
}

/// @nodoc
class __$$JobImplCopyWithImpl<$Res> extends _$JobCopyWithImpl<$Res, _$JobImpl>
    implements _$$JobImplCopyWith<$Res> {
  __$$JobImplCopyWithImpl(_$JobImpl _value, $Res Function(_$JobImpl) _then)
      : super(_value, _then);

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? homeownerName = null,
    Object? homeownerPhoneNumber = null,
    Object? category = null,
    Object? subcategory = null,
    Object? serviceType = null,
    Object? title = null,
    Object? description = null,
    Object? location = null,
    Object? stage = null,
    Object? status = null,
    Object? urgency = null,
    Object? budget = null,
    Object? estimatedDuration = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? professionalId = freezed,
    Object? professional = freezed,
    Object? finalPrice = freezed,
    Object? rating = freezed,
    Object? review = freezed,
    Object? photos = null,
    Object? notes = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_$JobImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      homeownerName: null == homeownerName
          ? _value.homeownerName
          : homeownerName // ignore: cast_nullable_to_non_nullable
              as String,
      homeownerPhoneNumber: null == homeownerPhoneNumber
          ? _value.homeownerPhoneNumber
          : homeownerPhoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      subcategory: null == subcategory
          ? _value.subcategory
          : subcategory // ignore: cast_nullable_to_non_nullable
              as String,
      serviceType: null == serviceType
          ? _value.serviceType
          : serviceType // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location,
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
      budget: null == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedDuration: null == estimatedDuration
          ? _value.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      professionalId: freezed == professionalId
          ? _value.professionalId
          : professionalId // ignore: cast_nullable_to_non_nullable
              as String?,
      professional: freezed == professional
          ? _value._professional
          : professional // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      finalPrice: freezed == finalPrice
          ? _value.finalPrice
          : finalPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      review: freezed == review
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as String?,
      photos: null == photos
          ? _value._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JobImpl with DiagnosticableTreeMixin implements _Job {
  _$JobImpl(
      {required this.id,
      required this.homeownerName,
      required this.homeownerPhoneNumber,
      required this.category,
      required this.subcategory,
      required this.serviceType,
      required this.title,
      required this.description,
      @LocationConverter() required this.location,
      required this.stage,
      required this.status,
      required this.urgency,
      required this.budget,
      required this.estimatedDuration,
      required this.createdAt,
      required this.updatedAt,
      this.professionalId,
      final Map<String, dynamic>? professional,
      this.finalPrice,
      this.rating,
      this.review,
      final List<String> photos = const [],
      this.notes,
      this.completedAt})
      : _professional = professional,
        _photos = photos;

  factory _$JobImpl.fromJson(Map<String, dynamic> json) =>
      _$$JobImplFromJson(json);

  @override
  final String id;
  @override
  final String homeownerName;
  @override
  final String homeownerPhoneNumber;
  @override
  final String category;
  @override
  final String subcategory;
  @override
  final String serviceType;
  @override
  final String title;
  @override
  final String description;
  @override
  @LocationConverter()
  final Location location;
  @override
  final JobStage stage;
  @override
  final JobStatus status;
  @override
  final JobUrgency urgency;
  @override
  final double budget;
  @override
  final int estimatedDuration;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String? professionalId;
  final Map<String, dynamic>? _professional;
  @override
  Map<String, dynamic>? get professional {
    final value = _professional;
    if (value == null) return null;
    if (_professional is EqualUnmodifiableMapView) return _professional;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final double? finalPrice;
  @override
  final double? rating;
  @override
  final String? review;
  final List<String> _photos;
  @override
  @JsonKey()
  List<String> get photos {
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photos);
  }

  @override
  final String? notes;
  @override
  final DateTime? completedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Job(id: $id, homeownerName: $homeownerName, homeownerPhoneNumber: $homeownerPhoneNumber, category: $category, subcategory: $subcategory, serviceType: $serviceType, title: $title, description: $description, location: $location, stage: $stage, status: $status, urgency: $urgency, budget: $budget, estimatedDuration: $estimatedDuration, createdAt: $createdAt, updatedAt: $updatedAt, professionalId: $professionalId, professional: $professional, finalPrice: $finalPrice, rating: $rating, review: $review, photos: $photos, notes: $notes, completedAt: $completedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Job'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('homeownerName', homeownerName))
      ..add(DiagnosticsProperty('homeownerPhoneNumber', homeownerPhoneNumber))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('subcategory', subcategory))
      ..add(DiagnosticsProperty('serviceType', serviceType))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('location', location))
      ..add(DiagnosticsProperty('stage', stage))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('urgency', urgency))
      ..add(DiagnosticsProperty('budget', budget))
      ..add(DiagnosticsProperty('estimatedDuration', estimatedDuration))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('professionalId', professionalId))
      ..add(DiagnosticsProperty('professional', professional))
      ..add(DiagnosticsProperty('finalPrice', finalPrice))
      ..add(DiagnosticsProperty('rating', rating))
      ..add(DiagnosticsProperty('review', review))
      ..add(DiagnosticsProperty('photos', photos))
      ..add(DiagnosticsProperty('notes', notes))
      ..add(DiagnosticsProperty('completedAt', completedAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JobImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.homeownerName, homeownerName) ||
                other.homeownerName == homeownerName) &&
            (identical(other.homeownerPhoneNumber, homeownerPhoneNumber) ||
                other.homeownerPhoneNumber == homeownerPhoneNumber) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.subcategory, subcategory) ||
                other.subcategory == subcategory) &&
            (identical(other.serviceType, serviceType) ||
                other.serviceType == serviceType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.stage, stage) || other.stage == stage) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.urgency, urgency) || other.urgency == urgency) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.estimatedDuration, estimatedDuration) ||
                other.estimatedDuration == estimatedDuration) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.professionalId, professionalId) ||
                other.professionalId == professionalId) &&
            const DeepCollectionEquality()
                .equals(other._professional, _professional) &&
            (identical(other.finalPrice, finalPrice) ||
                other.finalPrice == finalPrice) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.review, review) || other.review == review) &&
            const DeepCollectionEquality().equals(other._photos, _photos) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        homeownerName,
        homeownerPhoneNumber,
        category,
        subcategory,
        serviceType,
        title,
        description,
        location,
        stage,
        status,
        urgency,
        budget,
        estimatedDuration,
        createdAt,
        updatedAt,
        professionalId,
        const DeepCollectionEquality().hash(_professional),
        finalPrice,
        rating,
        review,
        const DeepCollectionEquality().hash(_photos),
        notes,
        completedAt
      ]);

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JobImplCopyWith<_$JobImpl> get copyWith =>
      __$$JobImplCopyWithImpl<_$JobImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JobImplToJson(
      this,
    );
  }
}

abstract class _Job implements Job {
  factory _Job(
      {required final String id,
      required final String homeownerName,
      required final String homeownerPhoneNumber,
      required final String category,
      required final String subcategory,
      required final String serviceType,
      required final String title,
      required final String description,
      @LocationConverter() required final Location location,
      required final JobStage stage,
      required final JobStatus status,
      required final JobUrgency urgency,
      required final double budget,
      required final int estimatedDuration,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final String? professionalId,
      final Map<String, dynamic>? professional,
      final double? finalPrice,
      final double? rating,
      final String? review,
      final List<String> photos,
      final String? notes,
      final DateTime? completedAt}) = _$JobImpl;

  factory _Job.fromJson(Map<String, dynamic> json) = _$JobImpl.fromJson;

  @override
  String get id;
  @override
  String get homeownerName;
  @override
  String get homeownerPhoneNumber;
  @override
  String get category;
  @override
  String get subcategory;
  @override
  String get serviceType;
  @override
  String get title;
  @override
  String get description;
  @override
  @LocationConverter()
  Location get location;
  @override
  JobStage get stage;
  @override
  JobStatus get status;
  @override
  JobUrgency get urgency;
  @override
  double get budget;
  @override
  int get estimatedDuration;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  String? get professionalId;
  @override
  Map<String, dynamic>? get professional;
  @override
  double? get finalPrice;
  @override
  double? get rating;
  @override
  String? get review;
  @override
  List<String> get photos;
  @override
  String? get notes;
  @override
  DateTime? get completedAt;

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JobImplCopyWith<_$JobImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
