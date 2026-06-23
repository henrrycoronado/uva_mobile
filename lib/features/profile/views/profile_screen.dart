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
import '../../catalogs/models/catalog_groups.dart';
import '../../catalogs/viewmodels/catalogs_view_model.dart';
import '../../home/viewmodels/home_view_model.dart';
import '../models/update_profile_dto.dart';
import '../repositories/profile_repository.dart';
import '../viewmodels/profile_view_model.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  int _imageVersion = DateTime.now().millisecondsSinceEpoch;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      ref.read(catalogsViewModelProvider.notifier).fetchTypeCatalog(CatalogTypeGroup.career);
    });
  }

  Future<void> _handleSaveProfile(UpdateProfileDto dto) async {
    final repo = ref.read(profileRepositoryProvider);
    await repo.updateProfile(dto);
    
    // Refresh global states
    await ref.read(homeViewModelProvider.notifier).refresh(forceRefresh: true);
    await ref.read(profileViewModelProvider.notifier).refresh(forceRefresh: true);
  }

  Future<void> _handlePhotoUpload(String filePath) async {
    final repo = ref.read(profileRepositoryProvider);
    await repo.updateProfilePhoto(filePath);

    // Refresh global state to get new URL
    await ref.read(homeViewModelProvider.notifier).refresh(forceRefresh: true);
    await ref.read(profileViewModelProvider.notifier).refresh(forceRefresh: true);

    // Clear Flutter's image cache and update version to force UI refresh
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();

    if (mounted) {
      setState(() {
        _imageVersion = DateTime.now().millisecondsSinceEpoch;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final profileStateAsync = ref.watch(profileViewModelProvider);
    
    final catalogsState = ref.watch(catalogsViewModelProvider);
    final careerOptions = catalogsState.cachedTypes[CatalogTypeGroup.career] ?? [];

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
                  ProfileDetailsWidget(
                    profile: profile,
                    careerOptions: careerOptions,
                    isCatalogsLoading: catalogsState.isLoading,
                    imageVersion: _imageVersion,
                    onSave: _handleSaveProfile,
                    onPhotoUpload: _handlePhotoUpload,
                  ),
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

