import 'package:flutter/material.dart';
import 'package:uva_design_system/theme/app_colors.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'l10n/app_localizations.dart';
import 'widgetbook.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: [
        ThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light',
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
              ),
            ),
            WidgetbookTheme(
              name: 'Dark',
              data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: AppColors.primary,
                  brightness: Brightness.dark,
                ),
              ),
            ),
          ],
          themeBuilder: (context, theme, child) {
            return Theme(data: theme, child: child);
          },
        ),
        LocalizationAddon(
          locales: const [Locale('es'), Locale('en')],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          initialLocale: const Locale('es'),
        ),
        // ignore: deprecated_member_use
        DeviceFrameAddon(
          devices: [Devices.ios.iPhone13, Devices.android.samsungGalaxyS20],
        ),
      ],
    );
  }
}
