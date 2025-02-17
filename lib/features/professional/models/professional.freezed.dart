// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'professional.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Professional _$ProfessionalFromJson(Map<String, dynamic> json) {
  return _Professional.fromJson(json);
}

/// @nodoc
mixin _$Professional {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get profileImageUrl => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  int get completedJobs => throw _privateConstructorUsedError;
  double get responseRate => throw _privateConstructorUsedError;
  List<String> get services => throw _privateConstructorUsedError;
  List<String> get certifications => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Professional to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Professional
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfessionalCopyWith<Professional> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfessionalCopyWith<$Res> {
  factory $ProfessionalCopyWith(
          Professional value, $Res Function(Professional) then) =
      _$ProfessionalCopyWithImpl<$Res, Professional>;
  @useResult
  $Res call(
      {String id,
      String name,
      String phoneNumber,
      String email,
      String profileImageUrl,
      double rating,
      int completedJobs,
      double responseRate,
      List<String> services,
      List<String> certifications,
      bool isAvailable,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$ProfessionalCopyWithImpl<$Res, $Val extends Professional>
    implements $ProfessionalCopyWith<$Res> {
  _$ProfessionalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Professional
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNumber = null,
    Object? email = null,
    Object? profileImageUrl = null,
    Object? rating = null,
    Object? completedJobs = null,
    Object? responseRate = null,
    Object? services = null,
    Object? certifications = null,
    Object? isAvailable = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      completedJobs: null == completedJobs
          ? _value.completedJobs
          : completedJobs // ignore: cast_nullable_to_non_nullable
              as int,
      responseRate: null == responseRate
          ? _value.responseRate
          : responseRate // ignore: cast_nullable_to_non_nullable
              as double,
      services: null == services
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<String>,
      certifications: null == certifications
          ? _value.certifications
          : certifications // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfessionalImplCopyWith<$Res>
    implements $ProfessionalCopyWith<$Res> {
  factory _$$ProfessionalImplCopyWith(
          _$ProfessionalImpl value, $Res Function(_$ProfessionalImpl) then) =
      __$$ProfessionalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String phoneNumber,
      String email,
      String profileImageUrl,
      double rating,
      int completedJobs,
      double responseRate,
      List<String> services,
      List<String> certifications,
      bool isAvailable,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$ProfessionalImplCopyWithImpl<$Res>
    extends _$ProfessionalCopyWithImpl<$Res, _$ProfessionalImpl>
    implements _$$ProfessionalImplCopyWith<$Res> {
  __$$ProfessionalImplCopyWithImpl(
      _$ProfessionalImpl _value, $Res Function(_$ProfessionalImpl) _then)
      : super(_value, _then);

  /// Create a copy of Professional
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNumber = null,
    Object? email = null,
    Object? profileImageUrl = null,
    Object? rating = null,
    Object? completedJobs = null,
    Object? responseRate = null,
    Object? services = null,
    Object? certifications = null,
    Object? isAvailable = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ProfessionalImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      completedJobs: null == completedJobs
          ? _value.completedJobs
          : completedJobs // ignore: cast_nullable_to_non_nullable
              as int,
      responseRate: null == responseRate
          ? _value.responseRate
          : responseRate // ignore: cast_nullable_to_non_nullable
              as double,
      services: null == services
          ? _value._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<String>,
      certifications: null == certifications
          ? _value._certifications
          : certifications // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfessionalImpl implements _Professional {
  const _$ProfessionalImpl(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.email,
      required this.profileImageUrl,
      required this.rating,
      required this.completedJobs,
      required this.responseRate,
      required final List<String> services,
      required final List<String> certifications,
      required this.isAvailable,
      required this.createdAt,
      required this.updatedAt})
      : _services = services,
        _certifications = certifications;

  factory _$ProfessionalImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfessionalImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String phoneNumber;
  @override
  final String email;
  @override
  final String profileImageUrl;
  @override
  final double rating;
  @override
  final int completedJobs;
  @override
  final double responseRate;
  final List<String> _services;
  @override
  List<String> get services {
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_services);
  }

  final List<String> _certifications;
  @override
  List<String> get certifications {
    if (_certifications is EqualUnmodifiableListView) return _certifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_certifications);
  }

  @override
  final bool isAvailable;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Professional(id: $id, name: $name, phoneNumber: $phoneNumber, email: $email, profileImageUrl: $profileImageUrl, rating: $rating, completedJobs: $completedJobs, responseRate: $responseRate, services: $services, certifications: $certifications, isAvailable: $isAvailable, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfessionalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.completedJobs, completedJobs) ||
                other.completedJobs == completedJobs) &&
            (identical(other.responseRate, responseRate) ||
                other.responseRate == responseRate) &&
            const DeepCollectionEquality().equals(other._services, _services) &&
            const DeepCollectionEquality()
                .equals(other._certifications, _certifications) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      phoneNumber,
      email,
      profileImageUrl,
      rating,
      completedJobs,
      responseRate,
      const DeepCollectionEquality().hash(_services),
      const DeepCollectionEquality().hash(_certifications),
      isAvailable,
      createdAt,
      updatedAt);

  /// Create a copy of Professional
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfessionalImplCopyWith<_$ProfessionalImpl> get copyWith =>
      __$$ProfessionalImplCopyWithImpl<_$ProfessionalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfessionalImplToJson(
      this,
    );
  }
}

abstract class _Professional implements Professional {
  const factory _Professional(
      {required final String id,
      required final String name,
      required final String phoneNumber,
      required final String email,
      required final String profileImageUrl,
      required final double rating,
      required final int completedJobs,
      required final double responseRate,
      required final List<String> services,
      required final List<String> certifications,
      required final bool isAvailable,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$ProfessionalImpl;

  factory _Professional.fromJson(Map<String, dynamic> json) =
      _$ProfessionalImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get phoneNumber;
  @override
  String get email;
  @override
  String get profileImageUrl;
  @override
  double get rating;
  @override
  int get completedJobs;
  @override
  double get responseRate;
  @override
  List<String> get services;
  @override
  List<String> get certifications;
  @override
  bool get isAvailable;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Professional
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfessionalImplCopyWith<_$ProfessionalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
