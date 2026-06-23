class CreateActivitySimpleDto {
  final String programCode;
  final String activityTypeCode;
  final String name;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final bool requiresEnrollment;
  final bool requiresApproval;

  CreateActivitySimpleDto({
    required this.programCode,
    required this.activityTypeCode,
    required this.name,
    this.description,
    required this.startDate,
    required this.endDate,
    this.requiresEnrollment = false,
    this.requiresApproval = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'programCode': programCode,
      'activityTypeCode': activityTypeCode,
      'name': name,
      if (description != null) 'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'requiresEnrollment': requiresEnrollment,
      'requiresApproval': requiresApproval,
    };
  }
}
