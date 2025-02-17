// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'professional_job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfessionalJobImpl _$$ProfessionalJobImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfessionalJobImpl(
      job: const JobConverter().fromJson(json['job'] as Map<String, dynamic>),
      stage: $enumDecode(_$JobStageEnumMap, json['stage']),
      status: $enumDecode(_$JobStatusEnumMap, json['status']),
      urgency: $enumDecode(_$JobUrgencyEnumMap, json['urgency']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      notes: json['notes'] as String?,
      completionTime: json['completionTime'] == null
          ? null
          : DateTime.parse(json['completionTime'] as String),
    );

Map<String, dynamic> _$$ProfessionalJobImplToJson(
        _$ProfessionalJobImpl instance) =>
    <String, dynamic>{
      'job': const JobConverter().toJson(instance.job),
      'stage': _$JobStageEnumMap[instance.stage]!,
      'status': _$JobStatusEnumMap[instance.status]!,
      'urgency': _$JobUrgencyEnumMap[instance.urgency]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'notes': instance.notes,
      'completionTime': instance.completionTime?.toIso8601String(),
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
  JobStatus.inProgress: 'in_progress',
  JobStatus.completed: 'completed',
  JobStatus.cancelled: 'cancelled',
};

const _$JobUrgencyEnumMap = {
  JobUrgency.low: 'low',
  JobUrgency.medium: 'medium',
  JobUrgency.high: 'high',
  JobUrgency.emergency: 'emergency',
};
