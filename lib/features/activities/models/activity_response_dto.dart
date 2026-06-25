import 'activity_rule_response_dto.dart';

class ActivityResponseDto {
  final String uvaCode;
  final String programCode;
  final String programName;
  final String name;
  final String? description;
  final String? photoUrl;
  final DateTime startDate;
  final DateTime endDate;
  final String state;
  final String stateCode;
  final double? locationLatitude;
  final double? locationLongitude;
  final bool requiresEnrollment;
  final ActivityRuleResponseDto? rule;

  ActivityResponseDto({
    required this.uvaCode,
    required this.programCode,
    required this.programName,
    required this.name,
    this.description,
    this.photoUrl,
    required this.startDate,
    required this.endDate,
    required this.state,
    required this.stateCode,
    this.locationLatitude,
    this.locationLongitude,
    required this.requiresEnrollment,
    this.rule,
  });

  factory ActivityResponseDto.fromJson(Map<String, dynamic> json) {
    return ActivityResponseDto(
      uvaCode: json['uvaCode'] as String,
      programCode: json['programCode'] as String,
      programName: json['programName'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      photoUrl: json['photoUrl'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      state: json['state'] as String,
      stateCode: json['stateCode'] as String,
      locationLatitude: json['locationLatitude'] != null
          ? (json['locationLatitude'] as num).toDouble()
          : null,
      locationLongitude: json['locationLongitude'] != null
          ? (json['locationLongitude'] as num).toDouble()
          : null,
      requiresEnrollment: json['requiresEnrollment'] as bool? ?? false,
      rule: json['rule'] != null
          ? ActivityRuleResponseDto.fromJson(
              json['rule'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}
