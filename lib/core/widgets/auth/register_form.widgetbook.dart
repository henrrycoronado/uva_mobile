import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'register_form.dart';

@widgetbook.UseCase(
  name: 'Default',
  type: RegisterForm,
)
Widget buildRegisterFormUseCase(BuildContext context) {
  return Scaffold(
    body: Center(
      child: RegisterForm(
        isLoading: false,
        onRegister: (firstName, lastName, email, password) {
          debugPrint('Register attempted: $firstName $lastName');
        },
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Loading state',
  type: RegisterForm,
)
Widget buildRegisterFormLoadingUseCase(BuildContext context) {
  return Scaffold(
    body: Center(
      child: RegisterForm(
        isLoading: true,
        onRegister: (firstName, lastName, email, password) {},
      ),
    ),
  );
}
