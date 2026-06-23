import 'package:flutter/material.dart';

import '../../../features/programs/models/program_response_dto.dart';

class ProgramCardWidget extends StatelessWidget {
  final ProgramResponseDto program;
  final String? stateName;
  final VoidCallback onTap;

  const ProgramCardWidget({
    super.key,
    required this.program,
    required this.onTap,
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
    final cardColor = _parseHexColor(
      program.color,
      theme.colorScheme.primaryContainer,
    );
    final displayState = stateName ?? program.state;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Cover Image or Color block
            Container(
              height: 120,
              decoration: BoxDecoration(color: cardColor),
              child:
                  program.coverPhotoUrl != null &&
                      program.coverPhotoUrl!.isNotEmpty
                  ? Image.network(
                      program.coverPhotoUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildFallbackCover(cardColor, theme),
                    )
                  : _buildFallbackCover(cardColor, theme),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          program.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (program.acronym != null &&
                          program.acronym!.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            program.acronym!,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSecondaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (program.description != null &&
                      program.description!.isNotEmpty) ...[
                    Text(
                      program.description!,
                      style: theme.textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 16,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            program.managerName,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      Chip(
                        label: Text(
                          displayState,
                          style: theme.textTheme.labelSmall,
                        ),
                        backgroundColor: _getStateColor(
                          program.stateCode,
                        ).withValues(alpha: 0.2),
                        side: BorderSide.none,
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackCover(Color backgroundColor, ThemeData theme) {
    return Center(
      child: Icon(
        Icons.volunteer_activism,
        size: 48,
        color: backgroundColor.computeLuminance() > 0.5
            ? Colors.black54
            : Colors.white70,
      ),
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
