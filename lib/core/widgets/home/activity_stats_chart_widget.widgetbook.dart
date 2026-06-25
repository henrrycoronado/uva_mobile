import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'activity_stats_chart_widget.dart';

@widgetbook.UseCase(name: 'Default', type: ActivityStatsChartWidget)
Widget buildActivityStatsChartWidgetUseCase(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ActivityStatsChartWidget(activities: 12, hours: 45),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Empty State', type: ActivityStatsChartWidget)
Widget buildActivityStatsChartWidgetEmptyUseCase(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ActivityStatsChartWidget(activities: 0, hours: 0),
      ),
    ),
  );
}
