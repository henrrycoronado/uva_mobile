import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../../features/programs/models/program_response_dto.dart';
import 'program_details_widget.dart';

@widgetbook.UseCase(name: 'Default', type: ProgramDetailsWidget)
Widget buildProgramDetailsWidgetUseCase(BuildContext context) {
  final program = ProgramResponseDto(
    uvaCode: 'PRG001',
    name: 'Programa de Liderazgo Universitario',
    description:
        'Un programa diseñado para potenciar las habilidades de liderazgo en los estudiantes a través de actividades prácticas y proyectos comunitarios de alto impacto.',
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

  return Scaffold(body: ProgramDetailsWidget(program: program));
}
