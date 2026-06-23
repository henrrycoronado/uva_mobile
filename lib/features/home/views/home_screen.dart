import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/home/activity_stats_chart_widget.dart';
import '../../../core/widgets/home/goal_progress_chart_widget.dart';
import '../../../core/widgets/home/home_header_widget.dart';
import '../../../core/widgets/home/scholarship_progress_card_widget.dart';
import '../../../l10n/app_localizations.dart';
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
          final isGoalReached =
              state.history.validatedHours >= state.history.personalGoalHours &&
              state.history.personalGoalHours > 0;
          final isZero = state.history.validatedHours == 0;

          return RefreshIndicator(
            onRefresh: () => ref.read(homeViewModelProvider.notifier).refresh(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HomeHeaderWidget(
                    firstName: state.profile.firstName,
                    isGoalReached: isGoalReached,
                    isZero: isZero,
                  ),
                  const SizedBox(height: 24),
                  GoalProgressChartWidget(
                    validated: state.history.validatedHours,
                    goal: state.history.personalGoalHours,
                  ),
                  const SizedBox(height: 24),
                  ActivityStatsChartWidget(
                    activities: state.history.totalActivitiesParticipated
                        .toDouble(),
                    hours: state.history.totalLoggedHours,
                  ),
                  const SizedBox(height: 24),
                  if (state.activeScholarship != null)
                    ScholarshipProgressCardWidget(
                      scholarship: state.activeScholarship!,
                      validatedHours: state.history.validatedHours,
                    ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 50),
              const SizedBox(height: 10),
              Text(err.toString(), textAlign: TextAlign.center),
              TextButton(
                onPressed: () =>
                    ref.read(homeViewModelProvider.notifier).refresh(),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
