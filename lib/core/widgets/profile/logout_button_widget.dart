import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class LogoutButtonWidget extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutButtonWidget({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.red.withValues(alpha: 0.1),
          foregroundColor: Colors.red,
        ),
        onPressed: onLogout,
        icon: const Icon(Icons.logout),
        label: Text(l10n.logout),
      ),
    );
  }
}
