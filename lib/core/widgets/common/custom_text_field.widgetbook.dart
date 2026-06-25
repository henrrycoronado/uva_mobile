import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'custom_text_field.dart';

@widgetbook.UseCase(name: 'Default', type: CustomTextField)
Widget buildCustomTextFieldUseCase(BuildContext context) {
  final controller = TextEditingController();
  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomTextField(
          controller: controller,
          label: 'Nombre Completo',
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Password (Obscure)', type: CustomTextField)
Widget buildCustomTextFieldObscureUseCase(BuildContext context) {
  final controller = TextEditingController(text: 'secret_password');
  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomTextField(
          controller: controller,
          label: 'Contraseña',
          obscureText: true,
        ),
      ),
    ),
  );
}
