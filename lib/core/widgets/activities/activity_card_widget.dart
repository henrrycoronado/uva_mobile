import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../features/activities/models/activity_response_dto.dart';
import '../../theme/app_colors.dart';

class ActivityCardWidget extends StatelessWidget {
  final ActivityResponseDto activity;
  final VoidCallback? onTap;

  const ActivityCardWidget({super.key, required this.activity, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon box
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.volunteer_activism,
                      color: AppColors.darkSecondary,
                    ),
                  ),
                  const Spacer(),
                  // State chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getStateBackgroundColor(activity.stateCode),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      activity.state.toUpperCase(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: _getStateTextColor(activity.stateCode),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Title
              Text(
                activity.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // Description
              Text(
                activity.description?.isNotEmpty == true
                    ? activity.description!
                    : 'Sin descripción',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Divider(height: 1, color: theme.colorScheme.outlineVariant),
              const SizedBox(height: 12),
              // Time
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${dateFormat.format(activity.startDate)} - ${dateFormat.format(activity.endDate)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStateBackgroundColor(String stateCode) {
    switch (stateCode.toUpperCase()) {
      case 'ACTIVE':
        return Colors.black87;
      case 'COMPLETED':
        return Colors.grey.shade300;
      case 'DRAFT':
        return Colors.orange.shade100;
      default:
        return Colors.grey.shade300;
    }
  }

  Color _getStateTextColor(String stateCode) {
    switch (stateCode.toUpperCase()) {
      case 'ACTIVE':
        return Colors.white;
      default:
        return Colors.black87;
    }
  }
}
