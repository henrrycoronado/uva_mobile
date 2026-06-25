import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../theme/app_colors.dart';

class HomeGoalProgressWidget extends StatelessWidget {
  final double personalGoal;
  final double scholarshipGoal;
  final double currentMonthHours;

  const HomeGoalProgressWidget({
    super.key,
    required this.personalGoal,
    required this.scholarshipGoal,
    required this.currentMonthHours,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final totalGoal = personalGoal + scholarshipGoal;
    final progress = totalGoal > 0
        ? (currentMonthHours / totalGoal).clamp(0.0, 1.0)
        : 0.0;
    final progressPercentage = (progress * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.homeGoalProgress,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            progressPercentage >= 100
                ? l10n.homeCongratsMsg
                : l10n.homeKeepGoingMsg,
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCircularProgress(
                title: l10n.homeGoalTitle,
                current: currentMonthHours,
                goal: personalGoal,
                color: AppColors.primary,
                theme: theme,
                l10n: l10n,
              ),
              _buildCircularProgress(
                title: l10n.homeScholarshipProgress,
                current: currentMonthHours,
                goal: scholarshipGoal,
                color: AppColors.lightTertiary,
                theme: theme,
                l10n: l10n,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCircularProgress({
    required String title,
    required double current,
    required double goal,
    required Color color,
    required ThemeData theme,
    required AppLocalizations l10n,
  }) {
    final percentage = goal > 0 ? (current / goal).clamp(0.0, 1.0) : 0.0;

    return Column(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: percentage,
                strokeWidth: 8,
                backgroundColor: color.withValues(alpha: 0.2),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
              Center(
                child: Text(
                  '${(percentage * 100).toInt()}%',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${current.toStringAsFixed(1)} / ${goal.toStringAsFixed(0)} ${l10n.homeHoursLabel}',
          style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor),
        ),
      ],
    );
  }
}
