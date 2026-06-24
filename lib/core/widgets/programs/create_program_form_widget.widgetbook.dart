import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'create_program_form_widget.dart';

@widgetbook.UseCase(name: 'Default', type: CreateProgramFormWidget)
Widget buildCreateProgramFormWidgetUseCase(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Crear Programa')),
    body: Padding(
      padding: const EdgeInsets.all(24.0),
      child: CreateProgramFormWidget(
        onSubmit: (name, acronym) async {
          debugPrint('Submit: $name, $acronym');
          await Future.delayed(const Duration(seconds: 1));
        },
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Loading', type: CreateProgramFormWidget)
Widget buildCreateProgramFormWidgetLoadingUseCase(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Crear Programa')),
    body: Padding(
      padding: const EdgeInsets.all(24.0),
      child: CreateProgramFormWidget(
        isLoading: true,
        onSubmit: (name, acronym) async {},
      ),
    ),
  );
}
