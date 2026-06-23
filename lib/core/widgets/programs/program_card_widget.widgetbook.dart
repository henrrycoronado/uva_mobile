import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import '../../../features/programs/models/program_response_dto.dart';
import 'program_card_widget.dart';

@widgetbook.UseCase(name: 'Default', type: ProgramCardWidget)
Widget buildProgramCardWidgetUseCase(BuildContext context) {
  final program = ProgramResponseDto(
    uvaCode: 'PRG001',
    name: 'Programa de Liderazgo Universitario',
    description:
        'Un programa diseñado para potenciar las habilidades de liderazgo en los estudiantes.',
    acronym: 'PLU',
    color: '#4287f5',
    profilePhotoUrl: null,
    coverPhotoUrl: null,
    managerProfileId: '123',
    managerName: 'Ana Rodríguez',
    state: 'Activo',
    stateCode: 'ACTIVE',
    createdAt: DateTime.now(),
  );

  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProgramCardWidget(
          program: program,
          onTap: () => debugPrint('Tapped program!'),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'No Acronym or Description', type: ProgramCardWidget)
Widget buildProgramCardWidgetMinimalUseCase(BuildContext context) {
  final program = ProgramResponseDto(
    uvaCode: 'PRG002',
    name: 'Tutorías Matemáticas',
    description: null,
    acronym: null,
    color: '#ff5e3a',
    profilePhotoUrl: null,
    coverPhotoUrl: null,
    managerProfileId: '124',
    managerName: 'Carlos Gómez',
    state: 'Borrador',
    stateCode: 'DRAFT',
    createdAt: DateTime.now(),
  );

  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProgramCardWidget(program: program, onTap: () {}),
      ),
    ),
  );
}
