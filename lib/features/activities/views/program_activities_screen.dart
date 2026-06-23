import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/activities/activity_card_widget.dart';
import '../viewmodels/activity_list_viewmodel.dart';

class ProgramActivitiesScreen extends ConsumerWidget {
  final String programCode;

  const ProgramActivitiesScreen({
    super.key,
    required this.programCode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesState = ref.watch(activityListViewModelProvider(programCode));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Actividades'),
        backgroundColor: AppColors.primary,
        elevation: 1,
        iconTheme: const IconThemeData(color: AppColors.darkSecondary),
        titleTextStyle: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.darkSecondary,
        ),
      ),
      body: activitiesState.when(
        data: (activities) {
          if (activities.isEmpty) {
            return const Center(child: Text('No hay actividades.'));
          }
          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(activityListViewModelProvider(programCode).notifier).refresh();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                return ActivityCardWidget(activity: activities[index]);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
