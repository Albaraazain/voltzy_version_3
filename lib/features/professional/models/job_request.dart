enum JobUrgency {
  low,
  medium,
  high,
  emergency;

  bool get isUrgent => this == JobUrgency.high || this == JobUrgency.emergency;
}

class JobRequest {
  final String id;
  final String title;
  final String distance;
  final String eta;
  final String location;
  final JobUrgency urgency;

  const JobRequest({
    required this.id,
    required this.title,
    required this.distance,
    required this.eta,
    required this.location,
    required this.urgency,
  });

  bool get isUrgent =>
      urgency == JobUrgency.high || urgency == JobUrgency.emergency;
}
