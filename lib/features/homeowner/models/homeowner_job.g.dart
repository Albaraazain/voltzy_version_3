// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homeowner_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeownerJobImpl _$$HomeownerJobImplFromJson(Map<String, dynamic> json) =>
    _$HomeownerJobImpl(
      job: const JobConverter().fromJson(json['job'] as Map<String, dynamic>),
      status: $enumDecode(_$HomeownerJobStatusEnumMap, json['status']),
      requestedTime: DateTime.parse(json['requestedTime'] as String),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      category: json['category'] as String,
      preferredTime: json['preferredTime'] as String?,
      additionalNotes: json['additionalNotes'] as String?,
      budget: (json['budget'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$HomeownerJobImplToJson(_$HomeownerJobImpl instance) =>
    <String, dynamic>{
      'job': const JobConverter().toJson(instance.job),
      'status': _$HomeownerJobStatusEnumMap[instance.status]!,
      'requestedTime': instance.requestedTime.toIso8601String(),
      'images': instance.images,
      'category': instance.category,
      'preferredTime': instance.preferredTime,
      'additionalNotes': instance.additionalNotes,
      'budget': instance.budget,
    };

const _$HomeownerJobStatusEnumMap = {
  HomeownerJobStatus.draft: 'draft',
  HomeownerJobStatus.submitted: 'submitted',
  HomeownerJobStatus.searching: 'searching',
  HomeownerJobStatus.accepted: 'accepted',
  HomeownerJobStatus.inProgress: 'inProgress',
  HomeownerJobStatus.completed: 'completed',
  HomeownerJobStatus.cancelled: 'cancelled',
};
