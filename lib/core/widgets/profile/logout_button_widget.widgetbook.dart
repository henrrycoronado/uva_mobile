import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'logout_button_widget.dart';

@widgetbook.UseCase(name: 'Default', type: LogoutButtonWidget)
Widget buildLogoutButtonWidgetUseCase(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LogoutButtonWidget(
          onLogout: () {
            debugPrint('Logout clicked');
          },
        ),
      ),
    ),
  );
}
