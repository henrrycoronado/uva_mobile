class CreateActivityRuleDto {
  final int registrationRadiusMeters;
  final DateTime? enrollmentDeadline;
  final bool requiresApproval;
  final int? totalCapacity;

  CreateActivityRuleDto({
    required this.registrationRadiusMeters,
    this.enrollmentDeadline,
    required this.requiresApproval,
    this.totalCapacity,
  });

  Map<String, dynamic> toJson() {
    return {
      'registrationRadiusMeters': registrationRadiusMeters,
      if (enrollmentDeadline != null)
        'enrollmentDeadline': enrollmentDeadline!.toIso8601String(),
      'requiresApproval': requiresApproval,
      if (totalCapacity != null) 'totalCapacity': totalCapacity,
      'groups': [], // Groups not supported yet in frontend creation
    };
  }
}
