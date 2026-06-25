import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_plus/share_plus.dart';

import 'package:uva_design_system/models/activities/activity_response_dto.dart';
import 'package:uva_design_system/models/activities/enrollment_response_dto.dart';
import '../../../features/activities/viewmodels/enrollment_list_viewmodel.dart';
import '../../../l10n/app_localizations.dart';
import '../../providers/user_profile_provider.dart';
import '../../theme/app_colors.dart';
import '../../utils/image_utils.dart';

class ActivityDetailsContent extends ConsumerWidget {
  final ActivityResponseDto activity;

  const ActivityDetailsContent({super.key, required this.activity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
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
        title: Text(l10n.details),
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
            if (getFullImageUrl(activity.photoUrl) != null)
              Image.network(
                getFullImageUrl(activity.photoUrl)!,
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

                  // Details Card
                  Card(
                    elevation: 0,
                    color: theme.colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.3,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: theme.colorScheme.outlineVariant),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                  '${l10n.startDateLabel}: ${_formatDate(activity.startDate)}\n${l10n.endDateLabel}: ${_formatDate(activity.endDate)}',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Location Card
                  Card(
                    elevation: 0,
                    color: theme.colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.3,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: theme.colorScheme.outlineVariant),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.category,
                                size: 20,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${l10n.activityTypeLabel}: Actividad',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 20,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Ubicación: ${activity.locationLatitude != null ? '${activity.locationLatitude}, ${activity.locationLongitude}' : l10n.hqLocation}',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Stack(
                              children: [
                                if (activity.locationLatitude != null &&
                                    activity.locationLongitude != null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: FlutterMap(
                                      options: MapOptions(
                                        initialCenter: LatLng(
                                          activity.locationLatitude!,
                                          activity.locationLongitude!,
                                        ),
                                        initialZoom: 15.0,
                                        interactionOptions:
                                            const InteractionOptions(
                                              flags:
                                                  InteractiveFlag.all &
                                                  ~InteractiveFlag.rotate,
                                            ),
                                      ),
                                      children: [
                                        TileLayer(
                                          urlTemplate:
                                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                          userAgentPackageName:
                                              'com.uvoluntapp.uva_mobile',
                                        ),
                                        MarkerLayer(
                                          markers: [
                                            Marker(
                                              point: LatLng(
                                                activity.locationLatitude!,
                                                activity.locationLongitude!,
                                              ),
                                              width: 40,
                                              height: 40,
                                              child: const Icon(
                                                Icons.location_pin,
                                                color: Colors.red,
                                                size: 40,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                else
                                  Center(
                                    child: Icon(
                                      Icons.map,
                                      size: 64,
                                      color: theme.colorScheme.onSurfaceVariant
                                          .withValues(alpha: 0.5),
                                    ),
                                  ),
                                Positioned(
                                  bottom: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.surface,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      '${l10n.radiusLabel}: ${activity.rule?.registrationRadiusMeters ?? 500} ${l10n.metersLabel}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  if (activity.description != null &&
                      activity.description!.isNotEmpty) ...[
                    Text(
                      l10n.aboutActivity,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      activity.description!,
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Reglas de la Actividad
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        l10n.activityRules,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      childrenPadding: const EdgeInsets.all(16),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(l10n.requiresRegistration),
                            Switch(
                              value: activity.requiresEnrollment,
                              onChanged: null,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(l10n.requiresApproval),
                            Switch(
                              value: activity.rule?.requiresApproval ?? false,
                              onChanged: null,
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(l10n.capacity),
                            Text(
                              '${activity.rule?.totalCapacity ?? l10n.noLimit}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(l10n.costPrice),
                            Text(
                              '\$${activity.rule?.costAmount?.toStringAsFixed(2) ?? '0.00'}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(l10n.countsAsVolunteer),
                            Icon(
                              activity.rule?.countsVolunteerHours == true
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: activity.rule?.countsVolunteerHours == true
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Participants
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${l10n.enrolled} (${enrollments.length})',
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
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.05),
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
