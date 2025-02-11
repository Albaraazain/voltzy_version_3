// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'professional.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfessionalImpl _$$ProfessionalImplFromJson(Map<String, dynamic> json) =>
    _$ProfessionalImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      rating: (json['rating'] as num).toDouble(),
      completedJobs: (json['completedJobs'] as num).toInt(),
      responseRate: (json['responseRate'] as num).toDouble(),
    );

Map<String, dynamic> _$$ProfessionalImplToJson(_$ProfessionalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profileImageUrl': instance.profileImageUrl,
      'rating': instance.rating,
      'completedJobs': instance.completedJobs,
      'responseRate': instance.responseRate,
    };
