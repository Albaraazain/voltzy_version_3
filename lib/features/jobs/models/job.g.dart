// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JobImpl _$$JobImplFromJson(Map<String, dynamic> json) => _$JobImpl(
      id: json['id'] as String,
      homeownerName: json['homeownerName'] as String,
      homeownerPhoneNumber: json['homeownerPhoneNumber'] as String,
      category: json['category'] as String,
      subcategory: json['subcategory'] as String,
      serviceType: json['serviceType'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      location: const LocationConverter()
          .fromJson(json['location'] as Map<String, dynamic>),
      stage: $enumDecode(_$JobStageEnumMap, json['stage']),
      status: $enumDecode(_$JobStatusEnumMap, json['status']),
      urgency: $enumDecode(_$JobUrgencyEnumMap, json['urgency']),
      budget: (json['budget'] as num).toDouble(),
      estimatedDuration: (json['estimatedDuration'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      professionalId: json['professionalId'] as String?,
      professional: json['professional'] as Map<String, dynamic>?,
      finalPrice: (json['finalPrice'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      review: json['review'] as String?,
      photos: (json['photos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      notes: json['notes'] as String?,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$JobImplToJson(_$JobImpl instance) => <String, dynamic>{
      'id': instance.id,
      'homeownerName': instance.homeownerName,
      'homeownerPhoneNumber': instance.homeownerPhoneNumber,
      'category': instance.category,
      'subcategory': instance.subcategory,
      'serviceType': instance.serviceType,
      'title': instance.title,
      'description': instance.description,
      'location': const LocationConverter().toJson(instance.location),
      'stage': _$JobStageEnumMap[instance.stage]!,
      'status': _$JobStatusEnumMap[instance.status]!,
      'urgency': _$JobUrgencyEnumMap[instance.urgency]!,
      'budget': instance.budget,
      'estimatedDuration': instance.estimatedDuration,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'professionalId': instance.professionalId,
      'professional': instance.professional,
      'finalPrice': instance.finalPrice,
      'rating': instance.rating,
      'review': instance.review,
      'photos': instance.photos,
      'notes': instance.notes,
      'completedAt': instance.completedAt?.toIso8601String(),
    };

const _$JobStageEnumMap = {
  JobStage.pending: 'pending',
  JobStage.enRoute: 'enRoute',
  JobStage.atLocation: 'atLocation',
  JobStage.diagnosis: 'diagnosis',
  JobStage.quoteCreation: 'quoteCreation',
  JobStage.inProgress: 'inProgress',
  JobStage.completion: 'completion',
};

const _$JobStatusEnumMap = {
  JobStatus.pending: 'pending',
  JobStatus.accepted: 'accepted',
  JobStatus.rejected: 'rejected',
  JobStatus.inProgress: 'inProgress',
  JobStatus.completed: 'completed',
  JobStatus.cancelled: 'cancelled',
};

const _$JobUrgencyEnumMap = {
  JobUrgency.low: 'low',
  JobUrgency.medium: 'medium',
  JobUrgency.high: 'high',
  JobUrgency.emergency: 'emergency',
};
