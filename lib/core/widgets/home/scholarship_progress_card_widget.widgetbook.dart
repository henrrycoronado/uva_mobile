import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import '../../../../features/home/models/scholarship_response_dto.dart';
import 'scholarship_progress_card_widget.dart';

@widgetbook.UseCase(name: 'Default', type: ScholarshipProgressCardWidget)
Widget buildScholarshipProgressCardWidgetUseCase(BuildContext context) {
  final scholarship = ScholarshipResponseDto(
    uvaCode: 'SCH001',
    profileCode: 'PRF001',
    volunteerName: 'Juan Pérez',
    scholarshipTypeCode: 'EXC',
    scholarshipType: 'Beca de Excelencia',
    reason: 'Motivo de beca',
    requiredHours: 40,
    stateCode: 'ACTIVE',
  );

  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ScholarshipProgressCardWidget(
          scholarship: scholarship,
          validatedHours: 15,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'No Scholarship', type: ScholarshipProgressCardWidget)
Widget buildScholarshipProgressCardWidgetNoScholarshipUseCase(BuildContext context) {
  final scholarship = ScholarshipResponseDto(
    uvaCode: 'SCH002',
    profileCode: 'PRF001',
    volunteerName: 'Juan Pérez',
    scholarshipTypeCode: 'NONE',
    scholarshipType: 'Sin beca',
    reason: 'Ninguna',
    requiredHours: 0,
    stateCode: 'ACTIVE',
  );

  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ScholarshipProgressCardWidget(
          scholarship: scholarship,
          validatedHours: 0,
        ),
      ),
    ),
  );
}
