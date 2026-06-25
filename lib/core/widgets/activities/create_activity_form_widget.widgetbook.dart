import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'create_activity_form_widget.dart';

@widgetbook.UseCase(name: 'Default', type: CreateActivityFormWidget)
Widget buildCreateActivityFormWidgetUseCase(BuildContext context) {
  final activityTypes = [
    {'uvaCode': 'TUT', 'name': 'Tutorías'},
    {'uvaCode': 'VOL', 'name': 'Voluntariado General'},
  ];

  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: CreateActivityFormWidget(
            programCode: 'PRG001',
            activityTypes: activityTypes,
            onSubmit: (dto) async {
              debugPrint('Submitted: \$dto');
            },
          ),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Loading state', type: CreateActivityFormWidget)
Widget buildCreateActivityFormWidgetLoadingUseCase(BuildContext context) {
  final activityTypes = [
    {'uvaCode': 'TUT', 'name': 'Tutorías'},
  ];

  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: CreateActivityFormWidget(
            programCode: 'PRG001',
            activityTypes: activityTypes,
            isLoading: true,
            onSubmit: (dto) async {},
          ),
        ),
      ),
    ),
  );
}
