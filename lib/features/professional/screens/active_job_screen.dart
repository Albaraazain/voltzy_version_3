import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voltzy_version_3/features/jobs/models/job.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading_view.dart';
import '../providers/active_job_provider.dart';
import 'job_stages/at_location_view.dart';
import 'job_stages/completion_view.dart';
import 'job_stages/diagnosis_view.dart';
import 'job_stages/en_route_view.dart';
import 'job_stages/in_progress_view.dart';
import 'job_stages/quote_creation_view.dart';

class ActiveJobScreen extends ConsumerWidget {
  const ActiveJobScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobAsync = ref.watch(activeJobProvider);

    // Log the current state of the jobAsync
    print('ActiveJobScreen: Current state: ${jobAsync.toString()}');

    return Scaffold(
      body: SafeArea(
        child: jobAsync.when(
          data: (job) {
            print(
                'ActiveJobScreen: Job data received: ${job?.toString() ?? "null"}');
            if (job == null) {
              return const Center(
                child: Text('No active job'),
              );
            }

            print(
                'ActiveJobScreen: Rendering view for job stage: ${job.stage}');
            return switch (job.stage) {
              JobStage.pending => const Center(
                  child: Text('Job is pending approval'),
                ),
              JobStage.enRoute => EnRouteView(job: job),
              JobStage.atLocation => AtLocationView(job: job),
              JobStage.diagnosis => DiagnosisView(job: job),
              JobStage.quoteCreation => QuoteCreationView(job: job),
              JobStage.inProgress => InProgressView(job: job),
              JobStage.completion => CompletionView(job: job),
              _ => const Center(
                  child: Text('Unknown job stage'),
                ),
            };
          },
          loading: () {
            print('ActiveJobScreen: Loading state');
            return const LoadingView();
          },
          error: (error, stack) {
            print('ActiveJobScreen: Error state: $error');
            return ErrorView(
              message: error.toString(),
              onRetry: () {
                print('ActiveJobScreen: Retrying...');
                ref.refresh(activeJobProvider);
              },
            );
          },
        ),
      ),
    );
  }
}
