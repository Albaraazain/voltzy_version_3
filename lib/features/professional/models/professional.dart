import 'package:freezed_annotation/freezed_annotation.dart';

part 'professional.freezed.dart';
part 'professional.g.dart';

@freezed
class Professional with _$Professional {
  const factory Professional({
    required String id,
    required String name,
    required String phoneNumber,
    required String email,
    required String profileImageUrl,
    required double rating,
    required int completedJobs,
    required double responseRate,
    required List<String> services,
    required List<String> certifications,
    required bool isAvailable,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Professional;

  factory Professional.fromJson(Map<String, dynamic> json) =>
      _$ProfessionalFromJson(json);
}
