import 'create_activity_rule_dto.dart';

class CreateActivityDto {
  final String programCode;
  final String activityTypeCode;
  final String name;
  final String? description;
  final String? photoUrl;
  final DateTime startDate;
  final DateTime endDate;
  final double? locationLatitude;
  final double? locationLongitude;
  final bool requiresEnrollment;
  final bool countsVolunteerHours;
  final double? costAmount;
  final CreateActivityRuleDto? rule;

  CreateActivityDto({
    required this.programCode,
    required this.activityTypeCode,
    required this.name,
    this.description,
    this.photoUrl,
    required this.startDate,
    required this.endDate,
    this.locationLatitude,
    this.locationLongitude,
    required this.requiresEnrollment,
    required this.countsVolunteerHours,
    this.costAmount,
    this.rule,
  });

  Map<String, dynamic> toJson() {
    return {
      'programCode': programCode,
      'activityTypeCode': activityTypeCode,
      'name': name,
      if (description != null) 'description': description,
      if (photoUrl != null) 'photoUrl': photoUrl,
      'startDate': startDate.toUtc().toIso8601String(),
      'endDate': endDate.toUtc().toIso8601String(),
      if (locationLatitude != null) 'locationLatitude': locationLatitude,
      if (locationLongitude != null) 'locationLongitude': locationLongitude,
      'requiresEnrollment': requiresEnrollment,
      'countsVolunteerHours': countsVolunteerHours,
      if (costAmount != null) 'costAmount': costAmount,
      if (rule != null) 'rule': rule!.toJson(),
    };
  }
}
