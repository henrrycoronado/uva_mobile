import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/exceptions/offline_no_profile_exception.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/profile/logout_button_widget.dart';
import '../../../core/widgets/profile/profile_actions_widget.dart';
import '../../../core/widgets/profile/profile_details_widget.dart';
import '../../../core/widgets/profile/profile_settings_widget.dart';
import '../../../features/portfolio/views/portfolio_contact_view.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/repositories/auth_repository.dart';
import '../viewmodels/profile_view_model.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final profileStateAsync = ref.watch(profileViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.navProfile,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkSecondary,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 2,
      ),
      body: profileStateAsync.when(
        data: (profile) {
          return RefreshIndicator(
            onRefresh: () =>
                ref.read(profileViewModelProvider.notifier).refresh(forceRefresh: true),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProfileDetailsWidget(profile: profile),
                  const SizedBox(height: 24),
                  const ProfileActionsWidget(),
                  const SizedBox(height: 24),
                  const ProfileSettingsWidget(),
                  const SizedBox(height: 24),
                  const PortfolioContactView(),
                  const SizedBox(height: 32),
                  const LogoutButtonWidget(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) {
          if (err is OfflineNoProfileException) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              final repo = ref.read(authRepositoryProvider);
              await repo.logout();
              if (context.mounted) context.go(AppRoutes.login);
            });
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Cerrando sesión por seguridad...'),
                ],
              ),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 50),
                const SizedBox(height: 10),
                Text(err.toString(), textAlign: TextAlign.center),
                TextButton(
                  onPressed: () =>
                      ref.read(profileViewModelProvider.notifier).refresh(forceRefresh: true),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
