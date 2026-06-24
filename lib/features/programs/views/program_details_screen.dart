import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/providers/user_roles_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/activities/activity_card_widget.dart';
import '../../../core/widgets/programs/program_details_widget.dart';
import '../../activities/viewmodels/activity_list_viewmodel.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProgramDetailsWidget(program: program),
            const Divider(height: 32, thickness: 8),
            _buildActivitiesSection(context, ref, program.uvaCode, canEdit),
          ],
        ),
      ),
    );
  }

  Widget _buildActivitiesSection(
    BuildContext context,
    WidgetRef ref,
    String programCode,
    bool canEdit,
  ) {
    final activitiesState = ref.watch(
      activityListViewModelProvider(programCode),
    );
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Actividades',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkSecondary,
                ),
              ),
              if (canEdit)
                FilledButton.icon(
                  onPressed: () {
                    context.push('/programs/$programCode/activities/create');
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Crear'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.darkSecondary,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          activitiesState.when(
            data: (activities) {
              if (activities.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text(
                      'No hay actividades asociadas a este programa.',
                    ),
                  ),
                );
              }
              // Mostrar solo hasta 3
              final previewList = activities.take(3).toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...previewList.map(
                    (a) => ActivityCardWidget(
                      activity: a,
                      onTap: () {
                        context.push('/activities/${a.uvaCode}');
                      },
                    ),
                  ),
                  if (activities.length > 3)
                    OutlinedButton(
                      onPressed: () {
                        context.push('/programs/$programCode/activities');
                      },
                      child: const Text('Ver todas las actividades'),
                    ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('Error: $e')),
          ),
        ],
      ),
    );
  }
}
