import 'package:flutter/material.dart';
import '../../../../features/home/models/home_summary_dto.dart';
import '../../theme/app_colors.dart';

class HomeCalendarHeatmapWidget extends StatelessWidget {
  final int month;
  final int year;
  final List<DailyActivityDto> dailyActivities;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const HomeCalendarHeatmapWidget({
    super.key,
    required this.month,
    required this.year,
    required this.dailyActivities,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final monthName = _getMonthName(month);
    final daysInMonth = DateUtils.getDaysInMonth(year, month);
    final firstDayOffset = DateTime(year, month, 1).weekday - 1; // 0 = Monday

    // Mapear días a horas para búsqueda rápida
    final hoursByDay = {
      for (var activity in dailyActivities) activity.day: activity.hours,
    };

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Estadísticas de Actividad',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: onPreviousMonth,
                    color: AppColors.primary,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$monthName $year',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: onNextMonth,
                    color: AppColors.primary,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Días de la semana
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['L', 'M', 'M', 'J', 'V', 'S', 'D']
                .map(
                  (day) => Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.hintColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 8),
          // Cuadrícula del mes
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: daysInMonth + firstDayOffset,
            itemBuilder: (context, index) {
              if (index < firstDayOffset) {
                return const SizedBox(); // Espacios vacíos antes del primer día
              }
              final day = index - firstDayOffset + 1;
              final hours = hoursByDay[day] ?? 0.0;
              return _buildDayCell(day, hours);
            },
          ),
          const SizedBox(height: 24),
          // Leyenda
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Menos',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor,
                ),
              ),
              const SizedBox(width: 8),
              _buildLegendCell(0.0),
              const SizedBox(width: 4),
              _buildLegendCell(2.0),
              const SizedBox(width: 4),
              _buildLegendCell(5.0),
              const SizedBox(width: 4),
              _buildLegendCell(8.0),
              const SizedBox(width: 8),
              Text(
                'Más',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayCell(int day, double hours) {
    Color cellColor = _getColorForHours(hours);

    return Container(
      decoration: BoxDecoration(
        color: cellColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          day.toString(),
          style: TextStyle(
            fontSize: 12,
            color: hours > 4 ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildLegendCell(double hours) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: _getColorForHours(hours),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Color _getColorForHours(double hours) {
    if (hours == 0) return Colors.grey[200]!;
    if (hours <= 2) return AppColors.primary.withValues(alpha: 0.3);
    if (hours <= 4) return AppColors.primary.withValues(alpha: 0.6);
    if (hours <= 6) return AppColors.primary.withValues(alpha: 0.8);
    return AppColors.primary;
  }

  String _getMonthName(int month) {
    const months = [
      'Ene',
      'Feb',
      'Mar',
      'Abr',
      'May',
      'Jun',
      'Jul',
      'Ago',
      'Sep',
      'Oct',
      'Nov',
      'Dic',
    ];
    return months[month - 1];
  }
}
