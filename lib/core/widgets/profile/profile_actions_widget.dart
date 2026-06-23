import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class ProfileActionsWidget extends StatelessWidget {
  const ProfileActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 2.5,
      children: [
        _buildActionCard(
          context,
          Icons.app_registration,
          l10n.profileEnrolments,
        ),
        _buildActionCard(context, Icons.track_changes, l10n.profileTrackings),
        _buildActionCard(context, Icons.school, l10n.profileScholarships),
        _buildActionCard(context, Icons.insert_chart, l10n.profileReports),
        _buildActionCard(
          context,
          Icons.admin_panel_settings,
          'Solicitudes de rol',
        ),
      ],
    );
  }

  Widget _buildActionCard(BuildContext context, IconData icon, String title) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        // TODO: Navigate to specific list
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(
            alpha: 0.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(title, style: theme.textTheme.labelLarge),
          ],
        ),
      ),
    );
  }
}
