class ActivityRuleResponseDto {
  final String uvaCode;
  final int registrationRadiusMeters;
  final DateTime? enrollmentDeadline;
  final bool requiresApproval;
  final int? totalCapacity;
  final double? costAmount;
  final String? costCurrency;
  final bool countsVolunteerHours;

  ActivityRuleResponseDto({
    required this.uvaCode,
    required this.registrationRadiusMeters,
    this.enrollmentDeadline,
    required this.requiresApproval,
    this.totalCapacity,
    this.costAmount,
    this.costCurrency,
    required this.countsVolunteerHours,
  });

  factory ActivityRuleResponseDto.fromJson(Map<String, dynamic> json) {
    return ActivityRuleResponseDto(
      uvaCode: json['uvaCode'] as String,
      registrationRadiusMeters: json['registrationRadiusMeters'] as int? ?? 500,
      enrollmentDeadline: json['enrollmentDeadline'] != null
          ? DateTime.parse(json['enrollmentDeadline'] as String)
          : null,
      requiresApproval: json['requiresApproval'] as bool? ?? false,
      totalCapacity: json['totalCapacity'] as int?,
      costAmount: json['costAmount'] != null
          ? (json['costAmount'] as num).toDouble()
          : null,
      costCurrency: json['costCurrency'] as String?,
      countsVolunteerHours: json['countsVolunteerHours'] as bool? ?? false,
    );
  }
}
