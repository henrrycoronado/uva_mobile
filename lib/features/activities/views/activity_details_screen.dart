import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uva_design_system/models/activities/activity_response_dto.dart';
import 'package:uva_design_system/widgets/activities/activity_details_content.dart';

import '../../../core/providers/user_profile_provider.dart';
import '../repositories/activity_repository.dart';
import '../viewmodels/enrollment_list_viewmodel.dart';

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
          return _ActivityDetailsConnector(
            activity: snapshot.data!,
            activityCode: activityCode,
          );
        }
        return const Scaffold(
          body: Center(child: Text('Actividad no encontrada')),
        );
      },
    );
  }
}

/// Connects the design system widget to Riverpod providers.
class _ActivityDetailsConnector extends ConsumerWidget {
  final ActivityResponseDto activity;
  final String activityCode;

  const _ActivityDetailsConnector({
    required this.activity,
    required this.activityCode,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enrollmentsState = ref.watch(
      enrollmentListViewModelProvider(activityCode),
    );
    final userIdState = ref.watch(userIdProvider);

    return ActivityDetailsContent(
      activity: activity,
      enrollments: enrollmentsState.value ?? [],
      isLoadingEnrollments: enrollmentsState.isLoading,
      currentUserId: userIdState.value,
      onEnroll: () => ref
          .read(enrollmentListViewModelProvider(activityCode).notifier)
          .enroll(),
      onCancelEnrollment: (enrollmentCode) => ref
          .read(enrollmentListViewModelProvider(activityCode).notifier)
          .cancelEnrollment(enrollmentCode),
    );
  }
}
