import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/user_roles_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/programs/program_card_widget.dart';
import '../../../l10n/app_localizations.dart';
import '../viewmodels/program_list_viewmodel.dart';

class ProgramsScreen extends ConsumerWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final programsState = ref.watch(programListViewModelProvider);
    final canCreate = ref.watch(isSuperUserOrAdminProvider).value ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.navPrograms,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkSecondary,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 2,
      ),
      body: programsState.when(
        data: (programs) {
          if (programs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox,
                    size: 64,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay programas disponibles',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(programListViewModelProvider.notifier).refresh(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: programs.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final program = programs[index];
                return ProgramCardWidget(
                  program: program,
                  onTap: () {
                    // Navigate to details screen
                    context.push(
                      '/programs/${program.uvaCode}',
                      extra: program,
                    );
                  },
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error al cargar programas',
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () =>
                    ref.read(programListViewModelProvider.notifier).refresh(),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: canCreate
          ? FloatingActionButton(
              onPressed: () {
                context.push('/programs/create');
              },
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add, color: AppColors.darkSecondary),
            )
          : null,
    );
  }
}
