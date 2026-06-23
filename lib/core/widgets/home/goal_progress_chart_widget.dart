import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class GoalProgressChartWidget extends StatelessWidget {
  final double validated;
  final double goal;

  const GoalProgressChartWidget({
    super.key,
    required this.validated,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    double completion = goal > 0 ? (validated / goal) * 100 : 0;
    if (completion > 100) completion = 100;

    // Si no hay horas validadas y la meta es 0, mostramos el gráfico vacío en gris
    final isZero = validated == 0 && goal == 0;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            l10n.homeGoalProgress,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 150,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 50,
                    sections: [
                      if (!isZero) ...[
                        PieChartSectionData(
                          value: completion,
                          color: Colors.green,
                          radius: 15,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: 100 - completion,
                          color: theme.colorScheme.surfaceContainerHighest,
                          radius: 15,
                          showTitle: false,
                        ),
                      ] else ...[
                        PieChartSectionData(
                          value: 100,
                          color: Colors.grey.withValues(alpha: 0.3),
                          radius: 15,
                          showTitle: false,
                        ),
                      ],
                    ],
                  ),
                ),
                Text(
                  isZero ? '0.0%' : '${completion.toStringAsFixed(1)}%',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$validated / $goal ${l10n.homeHoursLabel}',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
