import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'home_goal_progress_widget.dart';

@widgetbook.UseCase(name: 'Default', type: HomeGoalProgressWidget)
Widget buildHomeGoalProgressWidgetUseCase(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: HomeGoalProgressWidget(
          personalGoal: 100,
          scholarshipGoal: 50,
          currentMonthHours: 35.5,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Completed Goal', type: HomeGoalProgressWidget)
Widget buildHomeGoalProgressWidgetCompletedUseCase(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: HomeGoalProgressWidget(
          personalGoal: 40,
          scholarshipGoal: 0,
          currentMonthHours: 45,
        ),
      ),
    ),
  );
}
