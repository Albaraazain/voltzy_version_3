// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationImpl _$$LocationImplFromJson(Map<String, dynamic> json) =>
    _$LocationImpl(
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$$LocationImplToJson(_$LocationImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

_$JobImpl _$$JobImplFromJson(Map<String, dynamic> json) => _$JobImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      stage: $enumDecode(_$JobStageEnumMap, json['stage']),
      status: $enumDecode(_$JobStatusEnumMap, json['status']),
      urgency: $enumDecode(_$JobUrgencyEnumMap, json['urgency']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      homeownerId: json['homeownerId'] as String,
      homeownerName: json['homeownerName'] as String,
      homeownerPhoneNumber: json['homeownerPhoneNumber'] as String,
      professional: json['professional'] == null
          ? null
          : Professional.fromJson(json['professional'] as Map<String, dynamic>),
      category: json['category'] as String?,
      subcategory: json['subcategory'] as String?,
      photos:
          (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      notes: json['notes'] as String?,
      finalPrice: (json['finalPrice'] as num?)?.toDouble(),
      rating: (json['rating'] as num?)?.toDouble(),
      review: json['review'] as String?,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      budget: (json['budget'] as num?)?.toDouble(),
      estimatedDuration: json['estimatedDuration'] == null
          ? null
          : Duration(microseconds: (json['estimatedDuration'] as num).toInt()),
    );

Map<String, dynamic> _$$JobImplToJson(_$JobImpl instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'stage': _$JobStageEnumMap[instance.stage]!,
      'status': _$JobStatusEnumMap[instance.status]!,
      'urgency': _$JobUrgencyEnumMap[instance.urgency]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'homeownerId': instance.homeownerId,
      'homeownerName': instance.homeownerName,
      'homeownerPhoneNumber': instance.homeownerPhoneNumber,
      'professional': instance.professional,
      'category': instance.category,
      'subcategory': instance.subcategory,
      'photos': instance.photos,
      'notes': instance.notes,
      'finalPrice': instance.finalPrice,
      'rating': instance.rating,
      'review': instance.review,
      'completedAt': instance.completedAt?.toIso8601String(),
      'budget': instance.budget,
      'estimatedDuration': instance.estimatedDuration?.inMicroseconds,
    };

const _$JobStageEnumMap = {
  JobStage.quoteCreation: 'quoteCreation',
  JobStage.enRoute: 'enRoute',
  JobStage.atLocation: 'atLocation',
  JobStage.diagnosis: 'diagnosis',
  JobStage.inProgress: 'inProgress',
  JobStage.completion: 'completion',
  JobStage.completed: 'completed',
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
