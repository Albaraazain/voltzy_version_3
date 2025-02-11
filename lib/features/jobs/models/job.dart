import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:voltzy_version_3/features/professional/models/professional.dart';
import 'package:flutter/material.dart';

part 'job.freezed.dart';
part 'job.g.dart';

enum JobStage {
  quoteCreation,
  enRoute,
  atLocation,
  diagnosis,
  inProgress,
  completion,
  completed
}

extension JobStageX on JobStage {
  String get displayName {
    switch (this) {
      case JobStage.quoteCreation:
        return 'Quote Creation';
      case JobStage.enRoute:
        return 'En Route';
      case JobStage.atLocation:
        return 'At Location';
      case JobStage.diagnosis:
        return 'Diagnosis';
      case JobStage.inProgress:
        return 'In Progress';
      case JobStage.completion:
        return 'Completion';
      case JobStage.completed:
        return 'Completed';
    }
  }
}

enum JobStatus { pending, accepted, rejected, inProgress, completed, cancelled }

extension JobStatusX on JobStatus {
  String get displayName {
    switch (this) {
      case JobStatus.pending:
        return 'Pending';
      case JobStatus.accepted:
        return 'Accepted';
      case JobStatus.rejected:
        return 'Rejected';
      case JobStatus.inProgress:
        return 'In Progress';
      case JobStatus.completed:
        return 'Completed';
      case JobStatus.cancelled:
        return 'Cancelled';
    }
  }

  bool get isActive => this == JobStatus.inProgress;
}

enum JobUrgency { low, medium, high, emergency }

extension JobUrgencyX on JobUrgency {
  String get displayName {
    switch (this) {
      case JobUrgency.low:
        return 'Low';
      case JobUrgency.medium:
        return 'Medium';
      case JobUrgency.high:
        return 'High';
      case JobUrgency.emergency:
        return 'Emergency';
    }
  }

  Color get color {
    switch (this) {
      case JobUrgency.low:
        return Colors.green;
      case JobUrgency.medium:
        return Colors.orange;
      case JobUrgency.high:
        return Colors.red;
      case JobUrgency.emergency:
        return Colors.red.shade900;
    }
  }
}

@freezed
class Location with _$Location {
  const factory Location({
    required String address,
    required double latitude,
    required double longitude,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@freezed
class Job with _$Job {
  const factory Job({
    required String id,
    required String title,
    required String description,
    required Location location,
    required JobStage stage,
    required JobStatus status,
    required JobUrgency urgency,
    required DateTime createdAt,
    required String homeownerId,
    required String homeownerName,
    required String homeownerPhoneNumber,
    Professional? professional,
    String? category,
    String? subcategory,
    List<String>? photos,
    String? notes,
    double? finalPrice,
    double? rating,
    String? review,
    DateTime? completedAt,
    double? budget,
    Duration? estimatedDuration,
  }) = _Job;

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
}
