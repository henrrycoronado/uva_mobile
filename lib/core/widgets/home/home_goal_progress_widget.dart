import 'package:flutter/material.dart';
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

    final totalGoal = personalGoal + scholarshipGoal;
    final progress = totalGoal > 0
        ? (currentMonthHours / totalGoal).clamp(0.0, 1.0)
        : 0.0;
    final progressPercentage = (progress * 100).toInt();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progreso de metas',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.darkSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '¡Buen trabajo! Has completado el $progressPercentage% de tus metas este mes.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCircularProgress(
                title: 'Meta Personal',
                current: currentMonthHours,
                goal: personalGoal,
                color: AppColors.primary,
                theme: theme,
              ),
              _buildCircularProgress(
                title: 'Meta de Beca',
                current: currentMonthHours,
                goal: scholarshipGoal,
                color: AppColors.lightTertiary,
                theme: theme,
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
                    color: AppColors.darkSecondary,
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
            color: AppColors.darkSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${current.toStringAsFixed(1)} / ${goal.toStringAsFixed(0)} Hrs',
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }
}
