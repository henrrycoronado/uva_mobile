import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import '../../../features/activities/models/activity_response_dto.dart';
import 'activity_card_widget.dart';

@widgetbook.UseCase(name: 'Default', type: ActivityCardWidget)
Widget buildActivityCardWidgetUseCase(BuildContext context) {
  final activity = ActivityResponseDto(
    uvaCode: 'ACT001',
    programCode: 'PRG001',
    programName: 'Programa de prueba',
    name: 'Tutorías de Matemáticas',
    description: 'Apoyo a estudiantes de escuela primaria',
    startDate: DateTime.now().add(const Duration(days: 1)),
    endDate: DateTime.now().add(const Duration(days: 1, hours: 2)),
    requiresEnrollment: true,
    state: 'Activo',
    stateCode: 'ACTIVE',
  );

  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ActivityCardWidget(activity: activity, onTap: () {}),
      ),
    ),
  );
}
