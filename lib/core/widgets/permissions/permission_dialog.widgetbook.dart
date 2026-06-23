import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'permission_dialog.dart';

@widgetbook.UseCase(
  name: 'Default',
  type: PermissionDialog,
)
Widget buildPermissionDialogUseCase(BuildContext context) {
  return Scaffold(
    body: Center(
      child: PermissionDialog(
        title: 'Permiso Requerido',
        description: 'La aplicación necesita acceso a la cámara para tomar fotos de perfil.',
        icon: Icons.camera_alt,
        onGoToSettings: () => debugPrint('Go to settings clicked'),
      ),
    ),
  );
}
