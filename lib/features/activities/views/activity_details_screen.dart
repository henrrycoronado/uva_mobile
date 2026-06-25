import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/activities/activity_details_content.dart';
import '../models/activity_response_dto.dart';
import '../repositories/activity_repository.dart';

class ActivityDetailsScreen extends ConsumerWidget {
  final String activityCode;

  const ActivityDetailsScreen({super.key, required this.activityCode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityFuture = ref
        .watch(activityRepositoryProvider)
        .getActivityByCode(activityCode);

    return FutureBuilder<ActivityResponseDto>(
      future: activityFuture,
      builder: (context, snapshot) {
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
        if (snapshot.hasData) {
          return ActivityDetailsContent(activity: snapshot.data!);
        }
        return const Scaffold(
          body: Center(child: Text('Actividad no encontrada')),
        );
      },
    );
  }
}

