import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../features/auth/repositories/auth_repository.dart';
import '../../../../l10n/app_localizations.dart';
import '../../providers/secure_storage_provider.dart';
import '../../router/app_routes.dart';

class LogoutButtonWidget extends ConsumerWidget {
  const LogoutButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.red.withValues(alpha: 0.1),
          foregroundColor: Colors.red,
        ),
        onPressed: () async {
          final repo = ref.read(authRepositoryProvider);
          final storage = ref.read(secureStorageProvider);
          try {
            await repo.logout();
          } catch (_) {}
          await storage.deleteToken();
          await storage.deleteRefreshToken();
          if (context.mounted) {
            context.go(AppRoutes.login);
          }
        },
        icon: const Icon(Icons.logout),
        label: Text(l10n.logout),
      ),
    );
  }
}
