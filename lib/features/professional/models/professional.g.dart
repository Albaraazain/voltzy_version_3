// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'professional.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfessionalImpl _$$ProfessionalImplFromJson(Map<String, dynamic> json) =>
    _$ProfessionalImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      completedJobs: (json['completedJobs'] as num).toInt(),
      responseRate: (json['responseRate'] as num).toDouble(),
      services:
          (json['services'] as List<dynamic>).map((e) => e as String).toList(),
      certifications: (json['certifications'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isAvailable: json['isAvailable'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ProfessionalImplToJson(_$ProfessionalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'profileImageUrl': instance.profileImageUrl,
      'rating': instance.rating,
      'completedJobs': instance.completedJobs,
      'responseRate': instance.responseRate,
      'services': instance.services,
      'certifications': instance.certifications,
      'isAvailable': instance.isAvailable,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
