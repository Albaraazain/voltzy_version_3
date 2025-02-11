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

Location _$LocationFromJson(Map<String, dynamic> json) {
  return _Location.fromJson(json);
}

/// @nodoc
mixin _$Location {
  String get address => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  /// Serializes this Location to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Location
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationCopyWith<Location> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationCopyWith<$Res> {
  factory $LocationCopyWith(Location value, $Res Function(Location) then) =
      _$LocationCopyWithImpl<$Res, Location>;
  @useResult
  $Res call({String address, double latitude, double longitude});
}

/// @nodoc
class _$LocationCopyWithImpl<$Res, $Val extends Location>
    implements $LocationCopyWith<$Res> {
  _$LocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Location
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationImplCopyWith<$Res>
    implements $LocationCopyWith<$Res> {
  factory _$$LocationImplCopyWith(
          _$LocationImpl value, $Res Function(_$LocationImpl) then) =
      __$$LocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String address, double latitude, double longitude});
}

/// @nodoc
class __$$LocationImplCopyWithImpl<$Res>
    extends _$LocationCopyWithImpl<$Res, _$LocationImpl>
    implements _$$LocationImplCopyWith<$Res> {
  __$$LocationImplCopyWithImpl(
      _$LocationImpl _value, $Res Function(_$LocationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Location
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$LocationImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationImpl implements _Location {
  const _$LocationImpl(
      {required this.address, required this.latitude, required this.longitude});

  factory _$LocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationImplFromJson(json);

  @override
  final String address;
  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'Location(address: $address, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, address, latitude, longitude);

  /// Create a copy of Location
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationImplCopyWith<_$LocationImpl> get copyWith =>
      __$$LocationImplCopyWithImpl<_$LocationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationImplToJson(
      this,
    );
  }
}

abstract class _Location implements Location {
  const factory _Location(
      {required final String address,
      required final double latitude,
      required final double longitude}) = _$LocationImpl;

  factory _Location.fromJson(Map<String, dynamic> json) =
      _$LocationImpl.fromJson;

  @override
  String get address;
  @override
  double get latitude;
  @override
  double get longitude;

  /// Create a copy of Location
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationImplCopyWith<_$LocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Job _$JobFromJson(Map<String, dynamic> json) {
  return _Job.fromJson(json);
}

/// @nodoc
mixin _$Job {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Location get location => throw _privateConstructorUsedError;
  JobStage get stage => throw _privateConstructorUsedError;
  JobStatus get status => throw _privateConstructorUsedError;
  JobUrgency get urgency => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get homeownerId => throw _privateConstructorUsedError;
  String get homeownerName => throw _privateConstructorUsedError;
  String get homeownerPhoneNumber => throw _privateConstructorUsedError;
  Professional? get professional => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get subcategory => throw _privateConstructorUsedError;
  List<String>? get photos => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  double? get finalPrice => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  String? get review => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  double? get budget => throw _privateConstructorUsedError;
  Duration? get estimatedDuration => throw _privateConstructorUsedError;

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
      String title,
      String description,
      Location location,
      JobStage stage,
      JobStatus status,
      JobUrgency urgency,
      DateTime createdAt,
      String homeownerId,
      String homeownerName,
      String homeownerPhoneNumber,
      Professional? professional,
      String? category,
      String? subcategory,
      List<String>? photos,
      String? notes,
      double? finalPrice,
      double? rating,
      String? review,
      DateTime? completedAt,
      double? budget,
      Duration? estimatedDuration});

  $LocationCopyWith<$Res> get location;
  $ProfessionalCopyWith<$Res>? get professional;
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
    Object? title = null,
    Object? description = null,
    Object? location = null,
    Object? stage = null,
    Object? status = null,
    Object? urgency = null,
    Object? createdAt = null,
    Object? homeownerId = null,
    Object? homeownerName = null,
    Object? homeownerPhoneNumber = null,
    Object? professional = freezed,
    Object? category = freezed,
    Object? subcategory = freezed,
    Object? photos = freezed,
    Object? notes = freezed,
    Object? finalPrice = freezed,
    Object? rating = freezed,
    Object? review = freezed,
    Object? completedAt = freezed,
    Object? budget = freezed,
    Object? estimatedDuration = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      homeownerId: null == homeownerId
          ? _value.homeownerId
          : homeownerId // ignore: cast_nullable_to_non_nullable
              as String,
      homeownerName: null == homeownerName
          ? _value.homeownerName
          : homeownerName // ignore: cast_nullable_to_non_nullable
              as String,
      homeownerPhoneNumber: null == homeownerPhoneNumber
          ? _value.homeownerPhoneNumber
          : homeownerPhoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      professional: freezed == professional
          ? _value.professional
          : professional // ignore: cast_nullable_to_non_nullable
              as Professional?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      subcategory: freezed == subcategory
          ? _value.subcategory
          : subcategory // ignore: cast_nullable_to_non_nullable
              as String?,
      photos: freezed == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
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
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      budget: freezed == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as double?,
      estimatedDuration: freezed == estimatedDuration
          ? _value.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as Duration?,
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

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProfessionalCopyWith<$Res>? get professional {
    if (_value.professional == null) {
      return null;
    }

    return $ProfessionalCopyWith<$Res>(_value.professional!, (value) {
      return _then(_value.copyWith(professional: value) as $Val);
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
      String title,
      String description,
      Location location,
      JobStage stage,
      JobStatus status,
      JobUrgency urgency,
      DateTime createdAt,
      String homeownerId,
      String homeownerName,
      String homeownerPhoneNumber,
      Professional? professional,
      String? category,
      String? subcategory,
      List<String>? photos,
      String? notes,
      double? finalPrice,
      double? rating,
      String? review,
      DateTime? completedAt,
      double? budget,
      Duration? estimatedDuration});

  @override
  $LocationCopyWith<$Res> get location;
  @override
  $ProfessionalCopyWith<$Res>? get professional;
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
    Object? title = null,
    Object? description = null,
    Object? location = null,
    Object? stage = null,
    Object? status = null,
    Object? urgency = null,
    Object? createdAt = null,
    Object? homeownerId = null,
    Object? homeownerName = null,
    Object? homeownerPhoneNumber = null,
    Object? professional = freezed,
    Object? category = freezed,
    Object? subcategory = freezed,
    Object? photos = freezed,
    Object? notes = freezed,
    Object? finalPrice = freezed,
    Object? rating = freezed,
    Object? review = freezed,
    Object? completedAt = freezed,
    Object? budget = freezed,
    Object? estimatedDuration = freezed,
  }) {
    return _then(_$JobImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
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
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      homeownerId: null == homeownerId
          ? _value.homeownerId
          : homeownerId // ignore: cast_nullable_to_non_nullable
              as String,
      homeownerName: null == homeownerName
          ? _value.homeownerName
          : homeownerName // ignore: cast_nullable_to_non_nullable
              as String,
      homeownerPhoneNumber: null == homeownerPhoneNumber
          ? _value.homeownerPhoneNumber
          : homeownerPhoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      professional: freezed == professional
          ? _value.professional
          : professional // ignore: cast_nullable_to_non_nullable
              as Professional?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      subcategory: freezed == subcategory
          ? _value.subcategory
          : subcategory // ignore: cast_nullable_to_non_nullable
              as String?,
      photos: freezed == photos
          ? _value._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
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
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      budget: freezed == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as double?,
      estimatedDuration: freezed == estimatedDuration
          ? _value.estimatedDuration
          : estimatedDuration // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$JobImpl implements _Job {
  const _$JobImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.location,
      required this.stage,
      required this.status,
      required this.urgency,
      required this.createdAt,
      required this.homeownerId,
      required this.homeownerName,
      required this.homeownerPhoneNumber,
      this.professional,
      this.category,
      this.subcategory,
      final List<String>? photos,
      this.notes,
      this.finalPrice,
      this.rating,
      this.review,
      this.completedAt,
      this.budget,
      this.estimatedDuration})
      : _photos = photos;

  factory _$JobImpl.fromJson(Map<String, dynamic> json) =>
      _$$JobImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final Location location;
  @override
  final JobStage stage;
  @override
  final JobStatus status;
  @override
  final JobUrgency urgency;
  @override
  final DateTime createdAt;
  @override
  final String homeownerId;
  @override
  final String homeownerName;
  @override
  final String homeownerPhoneNumber;
  @override
  final Professional? professional;
  @override
  final String? category;
  @override
  final String? subcategory;
  final List<String>? _photos;
  @override
  List<String>? get photos {
    final value = _photos;
    if (value == null) return null;
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? notes;
  @override
  final double? finalPrice;
  @override
  final double? rating;
  @override
  final String? review;
  @override
  final DateTime? completedAt;
  @override
  final double? budget;
  @override
  final Duration? estimatedDuration;

  @override
  String toString() {
    return 'Job(id: $id, title: $title, description: $description, location: $location, stage: $stage, status: $status, urgency: $urgency, createdAt: $createdAt, homeownerId: $homeownerId, homeownerName: $homeownerName, homeownerPhoneNumber: $homeownerPhoneNumber, professional: $professional, category: $category, subcategory: $subcategory, photos: $photos, notes: $notes, finalPrice: $finalPrice, rating: $rating, review: $review, completedAt: $completedAt, budget: $budget, estimatedDuration: $estimatedDuration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JobImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.stage, stage) || other.stage == stage) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.urgency, urgency) || other.urgency == urgency) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.homeownerId, homeownerId) ||
                other.homeownerId == homeownerId) &&
            (identical(other.homeownerName, homeownerName) ||
                other.homeownerName == homeownerName) &&
            (identical(other.homeownerPhoneNumber, homeownerPhoneNumber) ||
                other.homeownerPhoneNumber == homeownerPhoneNumber) &&
            (identical(other.professional, professional) ||
                other.professional == professional) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.subcategory, subcategory) ||
                other.subcategory == subcategory) &&
            const DeepCollectionEquality().equals(other._photos, _photos) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.finalPrice, finalPrice) ||
                other.finalPrice == finalPrice) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.review, review) || other.review == review) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.budget, budget) || other.budget == budget) &&
            (identical(other.estimatedDuration, estimatedDuration) ||
                other.estimatedDuration == estimatedDuration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        description,
        location,
        stage,
        status,
        urgency,
        createdAt,
        homeownerId,
        homeownerName,
        homeownerPhoneNumber,
        professional,
        category,
        subcategory,
        const DeepCollectionEquality().hash(_photos),
        notes,
        finalPrice,
        rating,
        review,
        completedAt,
        budget,
        estimatedDuration
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
  const factory _Job(
      {required final String id,
      required final String title,
      required final String description,
      required final Location location,
      required final JobStage stage,
      required final JobStatus status,
      required final JobUrgency urgency,
      required final DateTime createdAt,
      required final String homeownerId,
      required final String homeownerName,
      required final String homeownerPhoneNumber,
      final Professional? professional,
      final String? category,
      final String? subcategory,
      final List<String>? photos,
      final String? notes,
      final double? finalPrice,
      final double? rating,
      final String? review,
      final DateTime? completedAt,
      final double? budget,
      final Duration? estimatedDuration}) = _$JobImpl;

  factory _Job.fromJson(Map<String, dynamic> json) = _$JobImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  Location get location;
  @override
  JobStage get stage;
  @override
  JobStatus get status;
  @override
  JobUrgency get urgency;
  @override
  DateTime get createdAt;
  @override
  String get homeownerId;
  @override
  String get homeownerName;
  @override
  String get homeownerPhoneNumber;
  @override
  Professional? get professional;
  @override
  String? get category;
  @override
  String? get subcategory;
  @override
  List<String>? get photos;
  @override
  String? get notes;
  @override
  double? get finalPrice;
  @override
  double? get rating;
  @override
  String? get review;
  @override
  DateTime? get completedAt;
  @override
  double? get budget;
  @override
  Duration? get estimatedDuration;

  /// Create a copy of Job
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JobImplCopyWith<_$JobImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
