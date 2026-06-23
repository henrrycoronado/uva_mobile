import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/programs/create_program_form_widget.dart';
import '../viewmodels/create_program_viewmodel.dart';

class CreateProgramScreen extends ConsumerWidget {
  const CreateProgramScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(createProgramViewModelProvider);

    // Listen for errors
    ref.listen(createProgramViewModelProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Error al crear el programa'),
            backgroundColor: Colors.red.shade800,
          ),
        );
      } else if (previous is AsyncLoading && next is AsyncData) {
        if (next.value != null) {
          // Success
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Programa creado exitosamente'),
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
          'Crear Nuevo Programa',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.darkSecondary,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 1,
        iconTheme: const IconThemeData(color: AppColors.darkSecondary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Ingresa los datos del nuevo programa. El estado inicial será Inactivo.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            CreateProgramFormWidget(
              isLoading: state.isLoading,
              onSubmit: (name, acronym) async {
                await ref
                    .read(createProgramViewModelProvider.notifier)
                    .createProgram(name, acronym);
              },
            ),
          ],
        ),
      ),
    );
  }
}
