import 'package:flutter/foundation.dart';

/// A labeled numeric sample for charts.
@immutable
class HorizonChartPoint {
  const HorizonChartPoint({required this.label, required this.value});

  final String label;
  final double value;
}

/// Series used by multi-series charts.
@immutable
class HorizonChartSeries {
  const HorizonChartSeries({
    required this.id,
    required this.points,
    this.label,
  });

  final String id;
  final String? label;
  final List<HorizonChartPoint> points;
}

double chartMin(Iterable<double> values, {double fallback = 0}) {
  if (values.isEmpty) {
    return fallback;
  }
  return values.reduce((double a, double b) => a < b ? a : b);
}

double chartMax(Iterable<double> values, {double fallback = 1}) {
  if (values.isEmpty) {
    return fallback;
  }
  return values.reduce((double a, double b) => a > b ? a : b);
}
