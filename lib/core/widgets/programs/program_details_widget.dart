import 'package:flutter/material.dart';

import '../../../features/programs/models/program_response_dto.dart';

class ProgramDetailsWidget extends StatelessWidget {
  final ProgramResponseDto program;
  final String? stateName;

  const ProgramDetailsWidget({
    super.key,
    required this.program,
    this.stateName,
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
    final headerColor = _parseHexColor(program.color, theme.colorScheme.primaryContainer);
    final displayState = stateName ?? program.state;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header section
          Container(
            height: 200,
            decoration: BoxDecoration(color: headerColor),
            child: Stack(
              children: [
                if (program.coverPhotoUrl != null && program.coverPhotoUrl!.isNotEmpty)
                  Positioned.fill(
                    child: Image.network(
                      program.coverPhotoUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const SizedBox.shrink(),
                    ),
                  ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Avatar Profile Photo
                      if (program.profilePhotoUrl != null && program.profilePhotoUrl!.isNotEmpty)
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 38,
                            backgroundImage: NetworkImage(program.profilePhotoUrl!),
                          ),
                        )
                      else
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 38,
                            backgroundColor: headerColor.withValues(alpha: 0.5),
                            child: Icon(Icons.business, size: 40, color: theme.colorScheme.onPrimaryContainer),
                          ),
                        ),
                      const SizedBox(width: 16),
                      // Title
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            program.name,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tags
                Row(
                  children: [
                    if (program.acronym != null && program.acronym!.isNotEmpty) ...[
                      Chip(
                        label: Text(program.acronym!),
                        backgroundColor: theme.colorScheme.secondaryContainer,
                      ),
                      const SizedBox(width: 8),
                    ],
                    Chip(
                      label: Text(displayState),
                      backgroundColor: _getStateColor(program.stateCode).withValues(alpha: 0.2),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Description
                if (program.description != null && program.description!.isNotEmpty) ...[
                  Text(
                    'Acerca del Programa',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    program.description!,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                ],
                
                // Manager Info
                Card(
                  elevation: 0,
                  color: theme.colorScheme.surfaceContainerHighest,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: theme.colorScheme.primary,
                          child: Icon(Icons.person, color: theme.colorScheme.onPrimary),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Responsable del Programa',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
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
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Extra metadata
                Text(
                  'Detalles adicionales',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Código de Programa: ${program.uvaCode}',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Fecha de Creación: ${_formatDate(program.createdAt)}',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Color _getStateColor(String stateCode) {
    switch (stateCode.toUpperCase()) {
      case 'ACTIVE': return Colors.green;
      case 'INACTIVE': return Colors.grey;
      case 'DRAFT': return Colors.orange;
      case 'ARCHIVED': return Colors.red;
      default: return Colors.blue;
    }
  }
}
