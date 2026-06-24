class EnrollmentResponseDto {
  final String uvaCode;
  final String activityCode;
  final String activityName;
  final String enrolledProfileCode;
  final String enrolledProfileName;
  final String stateCode;
  final DateTime createdAt;

  EnrollmentResponseDto({
    required this.uvaCode,
    required this.activityCode,
    required this.activityName,
    required this.enrolledProfileCode,
    required this.enrolledProfileName,
    required this.stateCode,
    required this.createdAt,
  });

  factory EnrollmentResponseDto.fromJson(Map<String, dynamic> json) {
    return EnrollmentResponseDto(
      uvaCode: json['uvaCode'] ?? '',
      activityCode: json['activityCode'] ?? '',
      activityName: json['activityName'] ?? '',
      enrolledProfileCode: json['enrolledProfileCode'] ?? '',
      enrolledProfileName: json['enrolledProfileName'] ?? '',
      stateCode: json['stateCode'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
}
