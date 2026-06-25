import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:uva_design_system/theme/app_colors.dart';
import 'package:uva_design_system/widgets/activities/activity_card_widget.dart';
import '../viewmodels/activity_list_viewmodel.dart';

class ProgramActivitiesScreen extends ConsumerWidget {
  final String programCode;

  const ProgramActivitiesScreen({super.key, required this.programCode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activitiesState = ref.watch(
      activityListViewModelProvider(programCode),
    );
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Actividades'),
        backgroundColor: AppColors.primary,
        elevation: 1,
        iconTheme: const IconThemeData(color: AppColors.darkSecondary),
        titleTextStyle: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.darkSecondary,
        ),
      ),
      body: Column(
        children: [
          // Search and add row
          Container(
            padding: const EdgeInsets.all(16.0),
            color: theme.colorScheme.surface,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar actividades...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () {
                      context.push('/programs/$programCode/activities/create');
                    },
                    icon: const Icon(Icons.add, color: AppColors.darkSecondary),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: activitiesState.when(
              data: (activities) {
                if (activities.isEmpty) {
                  return const Center(child: Text('No hay actividades.'));
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    await ref
                        .read(
                          activityListViewModelProvider(programCode).notifier,
                        )
                        .refresh();
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: activities.length,
                    itemBuilder: (context, index) {
                      final activity = activities[index];
                      return ActivityCardWidget(
                        activity: activity,
                        onTap: () {
                          context.push('/activities/${activity.uvaCode}');
                        },
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
