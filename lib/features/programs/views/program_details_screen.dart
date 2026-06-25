import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/providers/user_roles_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/programs/program_details_widget.dart';
import '../models/program_response_dto.dart';
import '../repositories/program_repository.dart';

class ProgramDetailsScreen extends ConsumerWidget {
  final String programCode;
  final ProgramResponseDto? programExtra;

  const ProgramDetailsScreen({
    super.key,
    required this.programCode,
    this.programExtra,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canEdit = ref.watch(isSuperUserOrAdminProvider).value ?? false;

    // Obtener los detalles del programa (desde API o extra)
    final futureProgram = ref
        .watch(programRepositoryProvider)
        .getProgramByCode(programCode);

    return FutureBuilder<ProgramResponseDto>(
      initialData: programExtra,
      future: futureProgram,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final program = snapshot.data!;
          return _buildContent(context, ref, program, canEdit);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        return const Scaffold(
          body: Center(child: Text('No se encontró el programa')),
        );
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    ProgramResponseDto program,
    bool canEdit,
  ) {
    final theme = Theme.of(context);
    // Scaffold extrañado aquí para poder sobreescribir el AppBar con los datos correctos
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Programa'),
        backgroundColor: AppColors.primary,
        elevation: 1,
        leading: context.canPop()
            ? const BackButton()
            : BackButton(onPressed: () => context.go('/home')),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Compartir Programa',
            onPressed: () {
              final String programName = program.name;
              final String shareText =
                  '¡Mira $programName en UvoluntApp!\n\nhttps://uvoluntapp.hc-server.xyz/programs/${program.uvaCode}';
              SharePlus.instance.share(ShareParams(text: shareText));
            },
          ),
          if (canEdit)
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                context.push(
                  '/programs/${program.uvaCode}/edit',
                  extra: program,
                );
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: ProgramDetailsWidget(
          program: program,
          actionButtons: Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {
                    context.push('/programs/${program.uvaCode}/activities');
                  },
                  icon: const Icon(Icons.list_alt, size: 18),
                  label: const Text('Actividades'),
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
              if (canEdit) ...[
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.push(
                        '/programs/${program.uvaCode}/edit',
                        extra: program,
                      );
                    },
                    icon: const Icon(Icons.edit, size: 18),
                    label: const Text('Editar'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
