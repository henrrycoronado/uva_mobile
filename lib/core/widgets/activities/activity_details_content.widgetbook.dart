import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import '../../../features/activities/models/activity_response_dto.dart';
import '../../../features/activities/models/activity_rule_response_dto.dart';
import 'activity_details_content.dart';

@widgetbook.UseCase(name: 'Default', type: ActivityDetailsContent)
Widget buildActivityDetailsContentUseCase(BuildContext context) {
  final activity = ActivityResponseDto(
    uvaCode: 'ACT001',
    programCode: 'PRG001',
    programName: 'Programa de prueba',
    name: 'Tutorías de Matemáticas',
    description:
        'Actividad para apoyar estudiantes en el área de ciencias exactas.',
    startDate: DateTime.now().add(const Duration(days: 1)),
    endDate: DateTime.now().add(const Duration(days: 1, hours: 2)),
    requiresEnrollment: true,
    state: 'Activo',
    stateCode: 'ACTIVE',
    photoUrl: 'https://via.placeholder.com/600x400',
    locationLatitude: 19.4326,
    locationLongitude: -99.1332,
    rule: ActivityRuleResponseDto(
      uvaCode: 'RULE001',
      registrationRadiusMeters: 500,
      requiresApproval: false,
      totalCapacity: 50,
      costAmount: 0.0,
      countsVolunteerHours: true,
    ),
  );

  return Scaffold(
    body: ProviderScope(child: ActivityDetailsContent(activity: activity)),
  );
}
