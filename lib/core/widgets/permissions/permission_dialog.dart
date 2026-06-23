import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/permission_provider.dart';

class PermissionDialog extends ConsumerWidget {
  final String title;
  final String description;
  final IconData icon;

  const PermissionDialog({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) =>
          PermissionDialog(title: title, description: description, icon: icon),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Column(
        children: [
          Icon(icon, size: 48, color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge,
          ),
        ],
      ),
      content: Text(
        description,
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium,
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () async {
            final permissionService = ref.read(permissionServiceProvider);
            await permissionService.openSettings();
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: const Text('Ir a Configuración'),
        ),
      ],
    );
  }
}
