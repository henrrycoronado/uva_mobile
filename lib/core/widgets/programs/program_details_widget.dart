import 'package:flutter/material.dart';

import '../../../features/programs/models/program_response_dto.dart';

class ProgramDetailsWidget extends StatelessWidget {
  final ProgramResponseDto program;
  final String? stateName;
  final Widget? actionButtons;

  const ProgramDetailsWidget({
    super.key,
    required this.program,
    this.stateName,
    this.actionButtons,
  });

  Color _parseHexColor(String? hexColor, Color fallback) {
    if (hexColor == null || hexColor.isEmpty) return fallback;
    try {
      String hex = hexColor.replaceAll('#', '');
      if (hex.length == 6) {
        hex = 'FF$hex';
      }
      return Color(int.parse(hex, radix: 16));
    } catch (e) {
      return fallback;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerColor = _parseHexColor(
      program.color,
      theme.colorScheme.primaryContainer,
    );
    final displayState = stateName ?? program.state;
    final acronymText = program.acronym?.isNotEmpty == true
        ? program.acronym!
        : 'UVA';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header section (Cover + Avatar)
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(color: headerColor),
              child:
                  program.coverPhotoUrl != null &&
                      program.coverPhotoUrl!.isNotEmpty
                  ? Image.network(
                      program.coverPhotoUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const SizedBox.shrink(),
                    )
                  : null,
            ),
            Positioned(
              bottom: -40,
              left: 24,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  color: Colors.white,
                ),
                child: CircleAvatar(
                  radius: 36,
                  backgroundColor:
                      program.profilePhotoUrl != null &&
                          program.profilePhotoUrl!.isNotEmpty
                      ? Colors.transparent
                      : theme.colorScheme.primaryContainer,
                  backgroundImage:
                      program.profilePhotoUrl != null &&
                          program.profilePhotoUrl!.isNotEmpty
                      ? NetworkImage(program.profilePhotoUrl!)
                      : null,
                  child:
                      program.profilePhotoUrl == null ||
                          program.profilePhotoUrl!.isEmpty
                      ? Text(
                          acronymText.length > 3
                              ? acronymText.substring(0, 3)
                              : acronymText,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 48),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                program.name,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),

              // Acronym
              if (program.acronym != null && program.acronym!.isNotEmpty) ...[
                Text(
                  'Acronym: ${program.acronym}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 4),
              ],

              // State Chip
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStateColor(program.stateCode),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  displayState.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Manager Info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Icon(
                        Icons.person,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ENCARGADO',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            program.managerName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              if (actionButtons != null) ...[
                actionButtons!,
                const SizedBox(height: 24),
              ],

              // Description
              _buildSectionTitle(theme, 'Descripción'),
              const SizedBox(height: 12),
              Text(
                program.description?.isNotEmpty == true
                    ? program.description!
                    : 'Sin descripción disponible.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),

              // Mission
              _buildSectionTitle(theme, 'Misión'),
              const SizedBox(height: 12),
              Text(
                program.missionStatement?.isNotEmpty == true
                    ? program.missionStatement!
                    : 'Sin misión definida.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),

              // Schedule
              _buildSectionTitle(theme, 'Información de Horarios'),
              const SizedBox(height: 12),
              Text(
                program.scheduleInfo?.isNotEmpty == true
                    ? program.scheduleInfo!
                    : 'Horarios no disponibles.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),

              // Contact Info
              _buildSectionTitle(theme, 'Información de Contacto'),
              const SizedBox(height: 12),
              Text(
                program.contactInfo?.isNotEmpty == true
                    ? program.contactInfo!
                    : 'Contacto no disponible.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Divider(color: theme.colorScheme.outlineVariant),
      ],
    );
  }

  Color _getStateColor(String stateCode) {
    switch (stateCode.toUpperCase()) {
      case 'ACTIVE':
        return Colors.green;
      case 'INACTIVE':
        return Colors.grey;
      case 'DRAFT':
        return Colors.orange;
      case 'ARCHIVED':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
