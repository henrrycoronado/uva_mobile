import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'suggested_activities_widget.dart';

@widgetbook.UseCase(name: 'Default', type: SuggestedActivitiesWidget)
Widget buildSuggestedActivitiesWidgetUseCase(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SuggestedActivitiesWidget(),
      ),
    ),
  );
}
