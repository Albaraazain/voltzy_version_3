import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repositories/professional_dashboard_repository.dart';
import '../models/metric.dart';
import '../models/job_request.dart' as request;
import '../../jobs/models/job.dart' hide JobUrgency;
import '../../jobs/models/job.dart' as job show JobUrgency;

part 'professional_dashboard_providers.g.dart';

@riverpod
ProfessionalDashboardRepository professionalDashboardRepository(
    ProfessionalDashboardRepositoryRef ref) {
  return ProfessionalDashboardRepository();
}

@riverpod
class OnlineStatus extends _$OnlineStatus {
  @override
  bool build() {
    return true; // Default to online
  }

  void toggle() {
    state = !state;
  }
}

@riverpod
Future<List<Metric>> dashboardMetrics(DashboardMetricsRef ref) async {
  final repository = ref.watch(professionalDashboardRepositoryProvider);
  return repository.getMetrics();
}

@riverpod
Future<List<request.JobRequest>> jobRequests(JobRequestsRef ref) async {
  final repository = ref.watch(professionalDashboardRepositoryProvider);
  return repository.getJobRequests();
}

@riverpod
Future<Job?> activeJob(ActiveJobRef ref) async {
  final repository = ref.watch(professionalDashboardRepositoryProvider);
  return repository.getActiveJob();
}
