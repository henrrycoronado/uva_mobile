import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../../features/programs/models/program_response_dto.dart';
import 'edit_program_form_widget.dart';

@widgetbook.UseCase(name: 'Default', type: EditProgramFormWidget)
Widget buildEditProgramFormWidgetUseCase(BuildContext context) {
  final program = ProgramResponseDto(
    uvaCode: 'PROG-001',
    name: 'Programa de Liderazgo',
    description: 'Descripción de prueba para el form',
    acronym: 'LID',
    color: '#FF5733',
    managerProfileId: '123',
    managerName: 'Juan Perez',
    state: 'Activo',
    stateCode: 'ACTIVE',
    createdAt: DateTime.now(),
  );

  return Scaffold(
    appBar: AppBar(title: const Text('Editar Programa')),
    body: Padding(
      padding: const EdgeInsets.all(24.0),
      child: EditProgramFormWidget(
        initialData: program,
        onSubmit: (dto) async {
          debugPrint('Update: ${dto.toJson()}');
          await Future.delayed(const Duration(seconds: 1));
        },
      ),
    ),
  );
}
