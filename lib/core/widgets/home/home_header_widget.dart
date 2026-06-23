import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class HomeHeaderWidget extends StatelessWidget {
  final String firstName;
  final bool isGoalReached;
  final bool isZero;

  const HomeHeaderWidget({
    super.key,
    required this.firstName,
    required this.isGoalReached,
    required this.isZero,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    String motivationText = l10n.homeKeepGoingMsg;
    if (isGoalReached) motivationText = l10n.homeCongratsMsg;
    if (isZero) motivationText = l10n.homeStartMsg;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.homeWelcome(firstName),
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            motivationText,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isGoalReached
                  ? Colors.green
                  : (isZero ? Colors.grey : Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
