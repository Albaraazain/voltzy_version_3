class Metric {
  final String title;
  final String value;
  final String? trend;
  final String backgroundColor;

  const Metric({
    required this.title,
    required this.value,
    this.trend,
    required this.backgroundColor,
  });
}
