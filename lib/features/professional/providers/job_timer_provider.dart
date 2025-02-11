import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'job_timer_provider.g.dart';

@riverpod
class JobTimer extends _$JobTimer {
  @override
  Duration build() {
    // TODO: Implement actual job timer logic
    return const Duration(hours: 1, minutes: 30); // Hardcoded for now
  }

  void updateDuration(Duration duration) {
    state = duration;
  }
}
