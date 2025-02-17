import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/models/location.dart';
import '../../../core/utils/json_converters.dart';

part 'job.freezed.dart';
part 'job.g.dart';

/// Represents the stages a job can be in
@JsonEnum()
enum JobStage {
  @JsonValue('pending')
  pending,
  @JsonValue('enRoute')
  enRoute,
  @JsonValue('atLocation')
  atLocation,
  @JsonValue('diagnosis')
  diagnosis,
  @JsonValue('quoteCreation')
  quoteCreation,
  @JsonValue('inProgress')
  inProgress,
  @JsonValue('completion')
  completion;

  String get displayName {
    return switch (this) {
      JobStage.pending => 'Pending',
      JobStage.enRoute => 'En Route',
      JobStage.atLocation => 'At Location',
      JobStage.diagnosis => 'Diagnosis',
      JobStage.quoteCreation => 'Quote Creation',
      JobStage.inProgress => 'In Progress',
      JobStage.completion => 'Completion',
    };
  }
}

/// Represents the status of a job
@JsonEnum()
enum JobStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('accepted')
  accepted,
  @JsonValue('rejected')
  rejected,
  @JsonValue('inProgress')
  inProgress,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled;

  String get displayName {
    return switch (this) {
      JobStatus.pending => 'Pending',
      JobStatus.accepted => 'Accepted',
      JobStatus.rejected => 'Rejected',
      JobStatus.inProgress => 'In Progress',
      JobStatus.completed => 'Completed',
      JobStatus.cancelled => 'Cancelled',
    };
  }
}

/// Represents the urgency level of a job
@JsonEnum()
enum JobUrgency {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('emergency')
  emergency;

  String get displayName {
    return switch (this) {
      JobUrgency.low => 'Low',
      JobUrgency.medium => 'Medium',
      JobUrgency.high => 'High',
      JobUrgency.emergency => 'Emergency',
    };
  }

  Color get color {
    return switch (this) {
      JobUrgency.low => const Color(0xFF4CAF50), // Green
      JobUrgency.medium => const Color(0xFFFF9800), // Orange
      JobUrgency.high => const Color(0xFFF44336), // Red
      JobUrgency.emergency => const Color(0xFF9C27B0), // Purple
    };
  }
}

/// Represents a job in the system
@freezed
class Job with _$Job {
  factory Job({
    required String id,
    required String homeownerName,
    required String homeownerPhoneNumber,
    required String category,
    required String subcategory,
    required String serviceType,
    required String title,
    required String description,
    @LocationConverter() required Location location,
    required JobStage stage,
    required JobStatus status,
    required JobUrgency urgency,
    required double budget,
    required int estimatedDuration,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? professionalId,
    Map<String, dynamic>? professional,
    double? finalPrice,
    double? rating,
    String? review,
    @Default([]) List<String> photos,
    String? notes,
    DateTime? completedAt,
  }) = _Job;

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
}
