import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'main_layout_screen.dart';

// Since StatefulNavigationShell is complex to mock, we provide a placeholder
@widgetbook.UseCase(name: 'Default Placeholder', type: MainLayoutScreen)
Widget buildMainLayoutScreenUseCase(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Text(
        'MainLayoutScreen requiere GoRouter StatefulNavigationShell. El layout real contiene una NavigationBar con 3 tabs: Programas, Inicio, y Perfil.',
      ),
    ),
  );
}
