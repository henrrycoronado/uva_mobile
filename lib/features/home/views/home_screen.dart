import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/exceptions/offline_no_profile_exception.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/home/home_calendar_heatmap_widget.dart';
import '../../../core/widgets/home/home_goal_progress_widget.dart';
import '../../../core/widgets/home/home_header_widget.dart';
import '../../../core/widgets/home/suggested_activities_widget.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/repositories/auth_repository.dart';
import '../viewmodels/home_view_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final homeStateAsync = ref.watch(homeViewModelProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.navHome,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkSecondary,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 2,
      ),
      body: homeStateAsync.when(
        data: (state) {
          return RefreshIndicator(
            onRefresh: () => ref
                .read(homeViewModelProvider.notifier)
                .refresh(forceRefresh: true),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HomeHeaderWidget(firstName: state.profile.firstName),
                  const SizedBox(height: 24),
                  HomeGoalProgressWidget(
                    personalGoal: state.summary.personalGoalHours,
                    scholarshipGoal: state.summary.scholarshipGoalHours,
                    currentMonthHours: state.summary.monthLoggedHours,
                  ),
                  const SizedBox(height: 24),
                  HomeCalendarHeatmapWidget(
                    month: state.currentMonth,
                    year: state.currentYear,
                    dailyActivities: state.summary.currentMonthDailyActivities,
                    onPreviousMonth: () {
                      final newMonth = state.currentMonth == 1
                          ? 12
                          : state.currentMonth - 1;
                      final newYear = state.currentMonth == 1
                          ? state.currentYear - 1
                          : state.currentYear;
                      ref
                          .read(homeViewModelProvider.notifier)
                          .changeMonth(newMonth, newYear);
                    },
                    onNextMonth: () {
                      final newMonth = state.currentMonth == 12
                          ? 1
                          : state.currentMonth + 1;
                      final newYear = state.currentMonth == 12
                          ? state.currentYear + 1
                          : state.currentYear;
                      ref
                          .read(homeViewModelProvider.notifier)
                          .changeMonth(newMonth, newYear);
                    },
                  ),
                  const SizedBox(height: 24),
                  const SuggestedActivitiesWidget(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) {
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
                  onPressed: () => ref
                      .read(homeViewModelProvider.notifier)
                      .refresh(forceRefresh: true),
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
