import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/programs/edit_program_form_widget.dart';
import '../models/program_response_dto.dart';
import '../viewmodels/update_program_viewmodel.dart';

class EditProgramScreen extends ConsumerWidget {
  final ProgramResponseDto program;

  const EditProgramScreen({super.key, required this.program});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final state = ref.watch(updateProgramViewModelProvider);

    ref.listen(updateProgramViewModelProvider, (previous, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Error al actualizar el programa'),
            backgroundColor: Colors.red.shade800,
          ),
        );
      } else if (previous is AsyncLoading && next is AsyncData) {
        if (next.value != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Programa actualizado exitosamente'),
              backgroundColor: Colors.green.shade800,
            ),
          );
          // Actualizamos la ruta para reflejar los nuevos datos en ProgramDetailsScreen
          // usando pushReplacement para forzar la recarga
          context.pushReplacement(
            '/programs/${program.uvaCode}',
            extra: next.value,
          );
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Programa',
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
            EditProgramFormWidget(
              initialData: program,
              isLoading: state.isLoading,
              onSubmit: (dto) async {
                await ref
                    .read(updateProgramViewModelProvider.notifier)
                    .updateProgram(program.uvaCode, dto);
              },
            ),
          ],
        ),
      ),
    );
  }
}
