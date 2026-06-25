import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../features/activities/models/activity_response_dto.dart';
import '../../../features/activities/models/enrollment_response_dto.dart';
import '../../../features/activities/viewmodels/enrollment_list_viewmodel.dart';
import '../../providers/user_profile_provider.dart';
import '../../theme/app_colors.dart';

class ActivityDetailsContent extends ConsumerWidget {
  final ActivityResponseDto activity;

  const ActivityDetailsContent({super.key, required this.activity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final enrollmentsState = ref.watch(
      enrollmentListViewModelProvider(activity.uvaCode),
    );
    final userIdState = ref.watch(userIdProvider);

    final String? myUserId = userIdState.value;
    final List<EnrollmentResponseDto> enrollments =
        enrollmentsState.value ?? [];

    final myEnrollment = enrollments
        .where((e) => e.enrolledProfileCode == myUserId)
        .firstOrNull;
    final isEnrolled =
        myEnrollment != null &&
        myEnrollment.stateCode != 'CANCELED' &&
        myEnrollment.stateCode != 'REJECTED';
    final hasStarted = DateTime.now().isAfter(activity.startDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Actividad'),
        backgroundColor: AppColors.primary,
        elevation: 1,
        leading: context.canPop()
            ? const BackButton()
            : BackButton(onPressed: () => context.go('/home')),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Compartir Actividad',
            onPressed: () {
              final String shareText =
                  '¡Mira esta actividad en UvoluntApp!\n\nhttps://uvoluntapp.hc-server.xyz/activities/${activity.uvaCode}';
              SharePlus.instance.share(ShareParams(text: shareText));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Image
            if (activity.photoUrl != null && activity.photoUrl!.isNotEmpty)
              Image.network(
                activity.photoUrl!,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _buildPlaceholderHeader(theme),
              )
            else
              _buildPlaceholderHeader(theme),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Chip(
                        label: Text(activity.state),
                        backgroundColor: AppColors.primary.withValues(
                          alpha: 0.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    activity.name,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Programa: ${activity.programName}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Dates
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 20,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Inicio: ${_formatDate(activity.startDate)}\nFin: ${_formatDate(activity.endDate)}',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  if (activity.description != null &&
                      activity.description!.isNotEmpty) ...[
                    Text(
                      'Acerca de la Actividad',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      activity.description!,
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 32),
                  ],

                  // Participants
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Inscritos (${enrollments.length})',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  if (enrollmentsState.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (enrollments.isEmpty)
                    const Text('Aún no hay participantes inscritos.')
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: enrollments.length,
                      itemBuilder: (context, index) {
                        final enrollment = enrollments[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundColor: AppColors.primary.withValues(
                              alpha: 0.2,
                            ),
                            child: const Icon(
                              Icons.person,
                              color: AppColors.primary,
                            ),
                          ),
                          title: Text(enrollment.enrolledProfileName),
                          subtitle: Text(enrollment.stateCode),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(
        context,
        ref,
        isEnrolled,
        hasStarted,
        myEnrollment,
      ),
    );
  }

  Widget _buildPlaceholderHeader(ThemeData theme) {
    return Container(
      height: 200,
      color: theme.colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.event,
          size: 80,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildBottomBar(
    BuildContext context,
    WidgetRef ref,
    bool isEnrolled,
    bool hasStarted,
    EnrollmentResponseDto? myEnrollment,
  ) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -4),
            blurRadius: 8,
          ),
        ],
      ),
      child: SafeArea(
        child: _getActionButton(
          context,
          ref,
          isEnrolled,
          hasStarted,
          myEnrollment,
        ),
      ),
    );
  }

  Widget _getActionButton(
    BuildContext context,
    WidgetRef ref,
    bool isEnrolled,
    bool hasStarted,
    EnrollmentResponseDto? myEnrollment,
  ) {
    if (!isEnrolled) {
      return FilledButton(
        onPressed: () => _handleEnroll(context, ref),
        child: const Text('Inscribirse'),
      );
    } else {
      if (!hasStarted) {
        return FilledButton.tonal(
          onPressed: () => _handleCancel(context, ref, myEnrollment!),
          child: const Text('Cancelar Inscripción'),
        );
      } else {
        return FilledButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Marcar entrada: Aún no implementado'),
              ),
            );
          },
          child: const Text('Marcar entrada'),
        );
      }
    }
  }

  void _handleEnroll(BuildContext context, WidgetRef ref) async {
    try {
      await ref
          .read(enrollmentListViewModelProvider(activity.uvaCode).notifier)
          .enroll();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('¡Te has inscrito exitosamente!')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  void _handleCancel(
    BuildContext context,
    WidgetRef ref,
    EnrollmentResponseDto enrollment,
  ) async {
    try {
      await ref
          .read(enrollmentListViewModelProvider(activity.uvaCode).notifier)
          .cancelEnrollment(enrollment.uvaCode);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Inscripción cancelada')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
