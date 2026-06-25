import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uva_design_system/theme/app_colors.dart';
import 'package:uva_design_system/widgets/programs/program_card_widget.dart';

import '../../../core/providers/user_roles_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../viewmodels/program_list_viewmodel.dart';

class ProgramsScreen extends ConsumerWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final programsState = ref.watch(programListViewModelProvider);
    final searchQuery = ref.watch(programSearchQueryProvider);
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: l10n.programsSearchHint,
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 16,
                      ),
                    ),
                    onChanged: (value) {
                      ref
                          .read(programSearchQueryProvider.notifier)
                          .setQuery(value);
                    },
                  ),
                ),
                if (canCreate) ...[
                  const SizedBox(width: 12),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add,
                        color: AppColors.darkSecondary,
                      ),
                      onPressed: () {
                        context.push('/programs/create');
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: programsState.when(
              data: (programs) {
                final filteredPrograms = searchQuery.isEmpty
                    ? programs
                    : programs
                          .where(
                            (p) => p.name.toLowerCase().contains(
                              searchQuery.toLowerCase(),
                            ),
                          )
                          .toList();

                if (filteredPrograms.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          searchQuery.isNotEmpty
                              ? 'No se encontraron programas'
                              : l10n.programsEmpty,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    itemCount: filteredPrograms.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final program = filteredPrograms[index];
                      return ProgramCardWidget(
                        program: program,
                        onTap: () {
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
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error al cargar programas',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => ref
                          .read(programListViewModelProvider.notifier)
                          .refresh(),
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
