import 'package:freezed_annotation/freezed_annotation.dart';
import '../../jobs/models/job.dart';
import '../../../core/utils/json_converters.dart';

part 'homeowner_job.freezed.dart';
part 'homeowner_job.g.dart';

@freezed
class HomeownerJob with _$HomeownerJob {
  const factory HomeownerJob({
    @JobConverter() required Job job,
    required HomeownerJobStatus status,
    required DateTime requestedTime,
    required List<String> images,
    required String category,
    String? preferredTime,
    String? additionalNotes,
    double? budget,
  }) = _HomeownerJob;

  factory HomeownerJob.fromJson(Map<String, dynamic> json) =>
      _$HomeownerJobFromJson(json);
}

enum HomeownerJobStatus {
  draft,
  submitted,
  searching,
  accepted,
  inProgress,
  completed,
  cancelled
}
