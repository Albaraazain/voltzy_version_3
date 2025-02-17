import 'package:flutter/material.dart';
import 'package:voltzy_version_3/core/models/location.dart';
import '../models/metric.dart';
import '../models/job_request.dart' as request;
import '../../../features/jobs/models/job.dart';

class ProfessionalDashboardRepository {
  Future<List<Metric>> getMetrics() async {
    // Simulating API delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      const Metric(
        title: "Today's Earnings",
        value: '\$245.50',
        trend: '15% increase',
        backgroundColor: 'pink',
      ),
      const Metric(
        title: 'Response Rate',
        value: '95%',
        trend: 'Last 7 days',
        backgroundColor: 'blue',
      ),
    ];
  }

  Future<List<request.JobRequest>> getJobRequests() async {
    // Simulating API delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      request.JobRequest(
        id: '1',
        title: 'Electrical Installation',
        distance: '2.5 miles',
        eta: '15',
        location: '456 Oak St, Boston',
        urgency: request.JobUrgency.high,
      ),
      request.JobRequest(
        id: '2',
        title: 'Power Outage',
        distance: '1.8 miles',
        eta: '10',
        location: '789 Pine St, Boston',
        urgency: request.JobUrgency.medium,
      ),
    ];
  }

  Future<Job?> getActiveJob() async {
    // Simulating API delay
    await Future.delayed(const Duration(milliseconds: 500));

    return Job(
      id: 'active-1',
      title: 'Emergency Circuit Repair',
      description: 'Main circuit breaker needs immediate repair',
      location: const Location(
        address: '123 Main St, Boston',
        latitude: 42.3601,
        longitude: -71.0589,
      ),
      stage: JobStage.enRoute,
      status: JobStatus.inProgress,
      urgency: JobUrgency.high,
      createdAt: DateTime.now(),
      serviceType: 'Circuit Repair',
      budget: 200.0,
      estimatedDuration: 120,
      updatedAt: DateTime.now(),
      homeownerName: 'Sarah Johnson',
      homeownerPhoneNumber: '+1234567890',
      category: 'Electrical',
      subcategory: 'Circuit Repair',
    );
  }

  Future<bool> acceptJobRequest(String jobId) async {
    // Simulating API delay
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  Future<bool> toggleOnlineStatus(bool isOnline) async {
    // Simulating API delay
    await Future.delayed(const Duration(milliseconds: 500));
    return isOnline;
  }
}
