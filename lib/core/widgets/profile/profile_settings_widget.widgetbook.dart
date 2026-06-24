import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'profile_settings_widget.dart';

@widgetbook.UseCase(name: 'Default', type: ProfileSettingsWidget)
Widget buildProfileSettingsWidgetUseCase(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProfileSettingsWidget(
          currentLocale: const Locale('es'),
          currentTheme: ThemeMode.system,
          currentTextScale: 1.0,
          onChangeLocale: (val) => debugPrint('Locale changed: $val'),
          onChangeTheme: (val) => debugPrint('Theme changed: $val'),
          onChangeTextScale: (val) => debugPrint('Scale changed: $val'),
        ),
      ),
    ),
  );
}
