import 'package:flutter/material.dart';

import 'package:uva_design_system/models/programs/program_response_dto.dart';
import '../../utils/image_utils.dart';

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
              child: getFullImageUrl(program.coverPhotoUrl) != null
                  ? Image.network(
                      getFullImageUrl(program.coverPhotoUrl)!,
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
                  Text(
                    program.name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 14,
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
}
