import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class PermissionDialog extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onGoToSettings;

  const PermissionDialog({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onGoToSettings,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onGoToSettings,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => PermissionDialog(
        title: title,
        description: description,
        icon: icon,
        onGoToSettings: onGoToSettings,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        ElevatedButton(
          onPressed: () {
            onGoToSettings();
            Navigator.of(context).pop();
          },
          child: Text(AppLocalizations.of(context)!.goToSettings),
        ),
      ],
    );
  }
}
