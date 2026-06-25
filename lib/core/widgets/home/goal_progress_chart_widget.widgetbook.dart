import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'goal_progress_chart_widget.dart';

@widgetbook.UseCase(name: 'Default', type: GoalProgressChartWidget)
Widget buildGoalProgressChartWidgetUseCase(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 200,
          child: GoalProgressChartWidget(
            validated: 25,
            goal: 50,
          ),
        ),
      ),
    ),
  );
}
