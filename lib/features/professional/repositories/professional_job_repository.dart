import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voltzy_version_3/features/jobs/models/job.dart';
import 'package:voltzy_version_3/features/professional/models/professional.dart';
import 'package:voltzy_version_3/core/models/location.dart';

final professionalJobRepositoryProvider = Provider<ProfessionalJobRepository>((ref) {
  return ProfessionalJobRepository();
});

class ProfessionalJobRepository {
  // In a real app, this would be connected to your backend
  // For now, we'll simulate the data

  final String _professionalId = 'pro-123'; // Simulated logged in professional

  // Get available job requests in the area
  Future<List<Job>> getJobRequests() async {
    // TODO: Implement real API call
    return [
      Job(
        id: '1',
        title: 'Fix Leaking Pipe',
        description: 'Kitchen sink pipe is leaking',
        location: const Location(
          address: '123 Main St',
          latitude: 37.7749,
          longitude: -122.4194,
        ),
        stage: JobStage.quoteCreation,
        status: JobStatus.pending,
        urgency: JobUrgency.high,
        createdAt: DateTime.now(),
        serviceType: 'Pipe Repair',
        budget: 150.0,
        estimatedDuration: 120,
        updatedAt: DateTime.now(),
        homeownerName: 'John Doe',
        homeownerPhoneNumber: '+1234567890',
        category: 'Plumbing',
        subcategory: 'Pipe Repair',
      ),
    ];
  }

  // Get the professional's current active job
  Future<Job?> getActiveJob() async {
    // TODO: Implement real API call
    return Job(
      id: 'job-3',
      title: 'Bathroom Renovation',
      description: 'Complete bathroom remodel with new fixtures',
      location: const Location(
        address: '789 Pine St',
        latitude: 37.7749,
        longitude: -122.4194,
      ),
      stage: JobStage.inProgress,
      status: JobStatus.inProgress,
      urgency: JobUrgency.medium,
      createdAt: DateTime.now(),
      serviceType: 'Bathroom Renovation',
      budget: 5000.0,
      estimatedDuration: 4320,
      updatedAt: DateTime.now(),
      homeownerName: 'John Doe',
      homeownerPhoneNumber: '+1234567890',
      category: 'Renovation',
      subcategory: 'Bathroom',
      professional: Professional(
        id: 'pro1',
        name: 'John Smith',
        phoneNumber: '+1234567890',
        email: 'john.smith@example.com',
        profileImageUrl: 'https://example.com/profile.jpg',
        rating: 4.8,
        completedJobs: 150,
        responseRate: 0.95,
        services: ['Plumbing', 'Pipe Repair'],
        certifications: ['Certified Plumber'],
        isAvailable: true,
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      ).toJson(),
    );
  }

  // Accept a job request
  Future<Job> acceptJob(String jobId) async {
    // TODO: Implement real API call
    return Job(
      id: jobId,
      title: 'Fix Leaking Pipe',
      description: 'Kitchen sink pipe is leaking',
      location: const Location(
        address: '123 Main St',
        latitude: 37.7749,
        longitude: -122.4194,
      ),
      stage: JobStage.quoteCreation,
      status: JobStatus.accepted,
      urgency: JobUrgency.high,
      createdAt: DateTime.now(),
      serviceType: 'Pipe Repair',
      budget: 150.0,
      estimatedDuration: 120,
      updatedAt: DateTime.now(),
      homeownerName: 'John Doe',
      homeownerPhoneNumber: '+1234567890',
      category: 'Plumbing',
      subcategory: 'Pipe Repair',
      professional: Professional(
        id: 'pro1',
        name: 'John Smith',
        phoneNumber: '+1234567890',
        email: 'john.smith@example.com',
        profileImageUrl: 'https://example.com/profile.jpg',
        rating: 4.8,
        completedJobs: 150,
        responseRate: 0.95,
        services: ['Plumbing', 'Pipe Repair'],
        certifications: ['Certified Plumber'],
        isAvailable: true,
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      ).toJson(),
    );
  }

  // Reject a job request
  Future<Job> rejectJob(String jobId, String reason) async {
    // TODO: Implement real API call
    return Job(
      id: jobId,
      title: 'Fix Leaking Pipe',
      description: 'Kitchen sink pipe is leaking',
      location: const Location(
        address: '123 Main St',
        latitude: 37.7749,
        longitude: -122.4194,
      ),
      stage: JobStage.completion,
      status: JobStatus.rejected,
      urgency: JobUrgency.high,
      createdAt: DateTime.now(),
      serviceType: 'Pipe Repair',
      budget: 150.0,
      estimatedDuration: 120,
      updatedAt: DateTime.now(),
      homeownerName: 'John Doe',
      homeownerPhoneNumber: '+1234567890',
      category: 'Plumbing',
      subcategory: 'Pipe Repair',
      notes: reason,
    );
  }

  // Start an accepted job
  Future<Job> startJob(String jobId) async {
    // TODO: Implement real API call
    return Job(
      id: jobId,
      title: 'Fix Leaking Pipe',
      description: 'Kitchen sink pipe is leaking',
      location: const Location(
        address: '123 Main St',
        latitude: 37.7749,
        longitude: -122.4194,
      ),
      stage: JobStage.enRoute,
      status: JobStatus.inProgress,
      urgency: JobUrgency.high,
      createdAt: DateTime.now(),
      serviceType: 'Pipe Repair',
      budget: 150.0,
      estimatedDuration: 120,
      updatedAt: DateTime.now(),
      homeownerName: 'John Doe',
      homeownerPhoneNumber: '+1234567890',
      category: 'Plumbing',
      subcategory: 'Pipe Repair',
      professional: Professional(
        id: 'pro1',
        name: 'John Smith',
        phoneNumber: '+1234567890',
        email: 'john.smith@example.com',
        profileImageUrl: 'https://example.com/profile.jpg',
        rating: 4.8,
        completedJobs: 150,
        responseRate: 0.95,
        services: ['Plumbing', 'Pipe Repair'],
        certifications: ['Certified Plumber'],
        isAvailable: true,
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      ).toJson(),
    );
  }

  // Complete a job
  Future<Job> completeJob(
    String jobId, {
    required double finalPrice,
    String? notes,
    List<String>? photos,
  }) async {
    // TODO: Implement real API call
    return Job(
      id: jobId,
      title: 'Fix Leaking Pipe',
      description: 'Kitchen sink pipe is leaking',
      location: const Location(
        address: '123 Main St',
        latitude: 37.7749,
        longitude: -122.4194,
      ),
      stage: JobStage.completion,
      status: JobStatus.completed,
      urgency: JobUrgency.high,
      createdAt: DateTime.now(),
      serviceType: 'Pipe Repair',
      budget: 150.0,
      estimatedDuration: 120,
      updatedAt: DateTime.now(),
      homeownerName: 'John Doe',
      homeownerPhoneNumber: '+1234567890',
      category: 'Plumbing',
      subcategory: 'Pipe Repair',
      professional: Professional(
        id: 'pro1',
        name: 'John Smith',
        phoneNumber: '+1234567890',
        email: 'john.smith@example.com',
        profileImageUrl: 'https://example.com/profile.jpg',
        rating: 4.8,
        completedJobs: 150,
        responseRate: 0.95,
        services: ['Plumbing', 'Pipe Repair'],
        certifications: ['Certified Plumber'],
        isAvailable: true,
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      ).toJson(),
      finalPrice: finalPrice,
      notes: notes,
      photos: photos ?? [],
    );
  }

  // Cancel a job
  Future<Job> cancelJob(String jobId, String reason) async {
    // TODO: Implement real API call
    return Job(
      id: jobId,
      title: 'Fix Leaking Pipe',
      description: 'Kitchen sink pipe is leaking',
      location: const Location(
        address: '123 Main St',
        latitude: 37.7749,
        longitude: -122.4194,
      ),
      stage: JobStage.completion,
      status: JobStatus.cancelled,
      urgency: JobUrgency.high,
      createdAt: DateTime.now(),
      serviceType: 'Pipe Repair',
      budget: 150.0,
      estimatedDuration: 120,
      updatedAt: DateTime.now(),
      homeownerName: 'John Doe',
      homeownerPhoneNumber: '+1234567890',
      category: 'Plumbing',
      subcategory: 'Pipe Repair',
      professional: Professional(
        id: 'pro1',
        name: 'John Smith',
        phoneNumber: '+1234567890',
        email: 'john.smith@example.com',
        profileImageUrl: 'https://example.com/profile.jpg',
        rating: 4.8,
        completedJobs: 150,
        responseRate: 0.95,
        services: ['Plumbing', 'Pipe Repair'],
        certifications: ['Certified Plumber'],
        isAvailable: true,
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      ).toJson(),
      notes: reason,
    );
  }

  // Get completed jobs history
  Future<List<Job>> getCompletedJobs() async {
    // TODO: Implement real API call
    return [
      Job(
        id: 'job-4',
        title: 'Install New Sink',
        description: 'Install new kitchen sink with disposal',
        location: const Location(
          address: '321 Elm St',
          latitude: 37.7749,
          longitude: -122.4194,
        ),
        stage: JobStage.completion,
        status: JobStatus.completed,
        urgency: JobUrgency.low,
        createdAt: DateTime.now(),
        serviceType: 'Installation',
        budget: 450.0,
        estimatedDuration: 180,
        updatedAt: DateTime.now(),
        homeownerName: 'John Doe',
        homeownerPhoneNumber: '+1234567890',
        category: 'Plumbing',
        subcategory: 'Installation',
        professional: Professional(
          id: 'pro1',
          name: 'John Smith',
          phoneNumber: '+1234567890',
          email: 'john.smith@example.com',
          profileImageUrl: 'https://example.com/profile.jpg',
          rating: 4.8,
          completedJobs: 150,
          responseRate: 0.95,
          services: ['Plumbing', 'Installation'],
          certifications: ['Certified Plumber'],
          isAvailable: true,
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        ).toJson(),
        finalPrice: 450.0,
        rating: 5.0,
        review: 'Excellent work, very professional!',
      ),
    ];
  }

  Future<Job> rateJob(String jobId, double rating, String review) async {
    // TODO: Implement real API call
    return Job(
      id: jobId,
      title: 'Fix Leaking Pipe',
      description: 'Kitchen sink pipe is leaking',
      location: const Location(
        address: '123 Main St',
        latitude: 37.7749,
        longitude: -122.4194,
      ),
      stage: JobStage.completion,
      status: JobStatus.completed,
      urgency: JobUrgency.high,
      createdAt: DateTime.now(),
      serviceType: 'Pipe Repair',
      budget: 150.0,
      estimatedDuration: 120,
      updatedAt: DateTime.now(),
      homeownerName: 'John Doe',
      homeownerPhoneNumber: '+1234567890',
      category: 'Plumbing',
      subcategory: 'Pipe Repair',
      professional: Professional(
        id: 'pro1',
        name: 'John Smith',
        phoneNumber: '+1234567890',
        email: 'john.smith@example.com',
        profileImageUrl: 'https://example.com/profile.jpg',
        rating: 4.8,
        completedJobs: 150,
        responseRate: 0.95,
        services: ['Plumbing', 'Pipe Repair'],
        certifications: ['Certified Plumber'],
        isAvailable: true,
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      ).toJson(),
      finalPrice: 150.0,
      rating: rating,
      review: review,
    );
  }
}
