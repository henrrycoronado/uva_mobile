import 'package:flutter/material.dart';
import 'package:uva_design_system/models/home/scholarship_response_dto.dart';

import '../../../../l10n/app_localizations.dart';

class ScholarshipProgressCardWidget extends StatelessWidget {
  final ScholarshipResponseDto scholarship;
  final double validatedHours;

  const ScholarshipProgressCardWidget({
    super.key,
    required this.scholarship,
    required this.validatedHours,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    double progress = scholarship.requiredHours > 0
        ? validatedHours / scholarship.requiredHours
        : 0;
    if (progress > 1.0) progress = 1.0;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
        border: Border.all(color: theme.colorScheme.primaryContainer),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.school, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                l10n.homeScholarshipProgress,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(scholarship.scholarshipType, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: theme.colorScheme.surface,
            color: Colors.blue,
            minHeight: 10,
            borderRadius: BorderRadius.circular(5),
          ),
          const SizedBox(height: 8),
          Text(
            '$validatedHours / ${scholarship.requiredHours} ${l10n.homeHoursLabel}',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
