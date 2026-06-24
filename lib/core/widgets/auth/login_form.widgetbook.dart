import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'login_form.dart';

@widgetbook.UseCase(name: 'Default', type: LoginForm)
Widget buildLoginFormUseCase(BuildContext context) {
  return Scaffold(
    body: Center(
      child: LoginForm(
        isLoading: false,
        onLogin: (email, password) {
          debugPrint('Login attempted: $email');
        },
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Loading state', type: LoginForm)
Widget buildLoginFormLoadingUseCase(BuildContext context) {
  return Scaffold(
    body: Center(
      child: LoginForm(isLoading: true, onLogin: (email, password) {}),
    ),
  );
}
