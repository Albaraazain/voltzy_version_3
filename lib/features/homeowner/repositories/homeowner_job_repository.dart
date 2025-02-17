import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voltzy_version_3/features/jobs/models/job.dart';
import 'package:voltzy_version_3/features/professional/models/professional.dart';
import 'package:voltzy_version_3/core/models/location.dart';

final homeownerJobRepositoryProvider = Provider<HomeownerJobRepository>((ref) {
  return HomeownerJobRepository();
});

class HomeownerJobRepository {
  Future<List<Job>> getMyJobs() async {
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
        professional: (Professional(
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
        )).toJson(),
        category: 'Plumbing',
        subcategory: 'Pipe Repair',
      ),
      Job(
        id: '2',
        title: 'AC Maintenance',
        description: 'Annual AC maintenance and cleaning',
        location: const Location(
          address: '123 Main St',
          latitude: 37.7749,
          longitude: -122.4194,
        ),
        stage: JobStage.quoteCreation,
        status: JobStatus.pending,
        urgency: JobUrgency.medium,
        createdAt: DateTime.now(),
        serviceType: 'AC Maintenance',
        budget: 200.0,
        estimatedDuration: 180,
        updatedAt: DateTime.now(),
        homeownerName: 'John Doe',
        homeownerPhoneNumber: '+1234567890',
        category: 'HVAC',
        subcategory: 'Maintenance',
      ),
    ];
  }

  Future<List<Job>> getCompletedJobs() async {
    // TODO: Implement real API call
    return [
      Job(
        id: '3',
        title: 'Bathroom Renovation',
        description: 'Complete bathroom remodel',
        location: const Location(
          address: '123 Main St',
          latitude: 37.7749,
          longitude: -122.4194,
        ),
        stage: JobStage.completion,
        status: JobStatus.completed,
        urgency: JobUrgency.medium,
        createdAt: DateTime.now(),
        serviceType: 'Bathroom Renovation',
        budget: 5000.0,
        estimatedDuration: 4320,
        updatedAt: DateTime.now(),
        homeownerName: 'John Doe',
        homeownerPhoneNumber: '+1234567890',
        professional: (Professional(
          id: 'pro2',
          name: 'Mike Johnson',
          phoneNumber: '+1987654321',
          email: 'mike.johnson@example.com',
          profileImageUrl: 'https://example.com/profile2.jpg',
          rating: 4.9,
          completedJobs: 200,
          responseRate: 0.98,
          services: ['Renovation', 'Bathroom Remodeling'],
          certifications: ['Master Builder'],
          isAvailable: true,
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        )).toJson(),
        category: 'Renovation',
        subcategory: 'Bathroom',
        finalPrice: 5000.0,
        rating: 4.9,
        review: 'Excellent work!',
      ),
    ];
  }

  Future<Job> getJob(String jobId) async {
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
        professional: (Professional(
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
        )).toJson(),
      category: 'Plumbing',
      subcategory: 'Pipe Repair',
    );
  }

  Future<Job> createJob({
    required String title,
    required String description,
    required String address,
    required double latitude,
    required double longitude,
    required JobUrgency urgency,
    required String category,
    required String subcategory,
    required String homeownerName,
    required String homeownerPhoneNumber,
  }) async {
    // TODO: Implement real API call
    return Job(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      location: Location(
        address: address,
        latitude: latitude,
        longitude: longitude,
      ),
      stage: JobStage.quoteCreation,
      status: JobStatus.pending,
      urgency: urgency,
      createdAt: DateTime.now(),
        serviceType: subcategory,
        budget: 0.0,
        estimatedDuration: 60,
        updatedAt: DateTime.now(),
      homeownerName: homeownerName,
      homeownerPhoneNumber: homeownerPhoneNumber,
      category: category,
      subcategory: subcategory,
    );
  }

  Future<Job> cancelJob(String id, String reason) async {
    // TODO: Implement real API call
    return Job(
      id: id,
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
      notes: reason,
    );
  }

  Future<Job> rateJob(String id, double rating, String review) async {
    // TODO: Implement real API call
    return Job(
      id: id,
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
        professional: (Professional(
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
        )).toJson(),
      category: 'Plumbing',
      subcategory: 'Pipe Repair',
      finalPrice: 150.0,
      rating: rating,
      review: review,
    );
  }
}
