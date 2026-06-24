import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/activities/create_activity_form_widget.dart';
import '../../catalogs/viewmodels/catalog_viewmodel.dart';
import '../viewmodels/create_activity_viewmodel.dart';

class CreateActivityScreen extends ConsumerWidget {
  final String programCode;

  const CreateActivityScreen({super.key, required this.programCode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(createActivityViewModelProvider);
    final catalogState = ref.watch(activityTypesCatalogViewModelProvider);

    ref.listen(createActivityViewModelProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Error al crear la actividad'),
            backgroundColor: Colors.red.shade800,
          ),
        );
      } else if (previous is AsyncLoading && next is AsyncData) {
        if (next.value != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Actividad creada exitosamente'),
              backgroundColor: Colors.green.shade800,
            ),
          );
          context.pop();
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nueva Actividad',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkSecondary,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 1,
        iconTheme: const IconThemeData(color: AppColors.darkSecondary),
      ),
      body: catalogState.when(
        data: (types) {
          if (types.isEmpty) {
            return const Center(
              child: Text('No hay tipos de actividad disponibles.'),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: CreateActivityFormWidget(
              programCode: programCode,
              activityTypes: types,
              isLoading: state.isLoading,
              onSubmit: (dto) async {
                await ref
                    .read(createActivityViewModelProvider.notifier)
                    .createActivity(dto);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error al cargar catálogo: $e')),
      ),
    );
  }
}
