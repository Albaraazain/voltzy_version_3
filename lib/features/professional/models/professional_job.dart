import 'package:freezed_annotation/freezed_annotation.dart';
import '../../jobs/models/job.dart';
import '../../../core/utils/json_converters.dart';

part 'professional_job.freezed.dart';
part 'professional_job.g.dart';

@freezed
class ProfessionalJob with _$ProfessionalJob {
  const factory ProfessionalJob({
    @JobConverter() required Job job,
    required JobStage stage,
    required JobStatus status,
    required JobUrgency urgency,
    required DateTime createdAt,
    String? notes,
    DateTime? completionTime,
  }) = _ProfessionalJob;

  factory ProfessionalJob.fromJson(Map<String, dynamic> json) =>
      _$ProfessionalJobFromJson(json);
}

@JsonEnum()
enum JobStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('accepted')
  accepted,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled
}

@JsonEnum()
enum JobUrgency {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('emergency')
  emergency
}
