class VolunteerHistoryDto {
  final String profileCode;
  final String fullName;
  final String? careerName;
  final double personalGoalHours;
  final int totalActivitiesParticipated;
  final double validatedHours;
  final double totalLoggedHours;
  final DateTime? lastActivityDate;

  VolunteerHistoryDto({
    required this.profileCode,
    required this.fullName,
    this.careerName,
    required this.personalGoalHours,
    required this.totalActivitiesParticipated,
    required this.validatedHours,
    required this.totalLoggedHours,
    this.lastActivityDate,
  });

  factory VolunteerHistoryDto.fromJson(Map<String, dynamic> json) {
    return VolunteerHistoryDto(
      profileCode: json['profileCode'] ?? '',
      fullName: json['fullName'] ?? '',
      careerName: json['careerName'],
      personalGoalHours: (json['personalGoalHours'] as num?)?.toDouble() ?? 0.0,
      totalActivitiesParticipated:
          (json['totalActivitiesParticipated'] as num?)?.toInt() ?? 0,
      validatedHours: (json['validatedHours'] as num?)?.toDouble() ?? 0.0,
      totalLoggedHours: (json['totalLoggedHours'] as num?)?.toDouble() ?? 0.0,
      lastActivityDate: json['lastActivityDate'] != null
          ? DateTime.tryParse(json['lastActivityDate'])
          : null,
    );
  }
}
