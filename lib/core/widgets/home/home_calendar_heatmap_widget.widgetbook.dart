import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import '../../../../features/home/models/home_summary_dto.dart';
import 'home_calendar_heatmap_widget.dart';

@widgetbook.UseCase(name: 'Default', type: HomeCalendarHeatmapWidget)
Widget buildHomeCalendarHeatmapWidgetUseCase(BuildContext context) {
  final now = DateTime.now();
  final dailyActivities = [
    DailyActivityDto(day: 1, hours: 2.5),
    DailyActivityDto(day: 3, hours: 5.0),
    DailyActivityDto(day: 10, hours: 1.0),
    DailyActivityDto(day: 15, hours: 8.0),
    DailyActivityDto(day: 20, hours: 3.5),
  ];

  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: HomeCalendarHeatmapWidget(
          year: now.year,
          month: now.month,
          dailyActivities: dailyActivities,
          onPreviousMonth: () {},
          onNextMonth: () {},
        ),
      ),
    ),
  );
}
