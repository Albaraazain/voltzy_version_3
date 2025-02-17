import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';
part 'auth_user.g.dart';

@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String id,
    required String email,
    required String userType,
    String? displayName,
    String? photoUrl,
    @Default(false) bool emailVerified,
    required DateTime createdAt,
    DateTime? lastLoginAt,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}
