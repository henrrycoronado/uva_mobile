class ScholarshipResponseDto {
  final String uvaCode;
  final String profileCode;
  final String volunteerName;
  final String scholarshipTypeCode;
  final String scholarshipType;
  final String reason;
  final double requiredHours;
  final DateTime? startDate;
  final DateTime? endDate;
  final String stateCode;

  ScholarshipResponseDto({
    required this.uvaCode,
    required this.profileCode,
    required this.volunteerName,
    required this.scholarshipTypeCode,
    required this.scholarshipType,
    required this.reason,
    required this.requiredHours,
    this.startDate,
    this.endDate,
    required this.stateCode,
  });

  factory ScholarshipResponseDto.fromJson(Map<String, dynamic> json) {
    return ScholarshipResponseDto(
      uvaCode: json['uvaCode'] ?? '',
      profileCode: json['profileCode'] ?? '',
      volunteerName: json['volunteerName'] ?? '',
      scholarshipTypeCode: json['scholarshipTypeCode'] ?? '',
      scholarshipType: json['scholarshipType'] ?? '',
      reason: json['reason'] ?? '',
      requiredHours: (json['requiredHours'] as num?)?.toDouble() ?? 0.0,
      startDate: json['startDate'] != null
          ? DateTime.tryParse(json['startDate'])
          : null,
      endDate: json['endDate'] != null
          ? DateTime.tryParse(json['endDate'])
          : null,
      stateCode: json['stateCode'] ?? '',
    );
  }
}
