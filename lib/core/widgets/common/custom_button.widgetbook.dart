import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'custom_button.dart';

@widgetbook.UseCase(name: 'Default', type: CustomButton)
Widget buildCustomButtonUseCase(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(onPressed: () {}, text: 'Continuar'),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Loading state', type: CustomButton)
Widget buildCustomButtonLoadingUseCase(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          onPressed: () {},
          text: 'Enviando...',
          isLoading: true,
        ),
      ),
    ),
  );
}
