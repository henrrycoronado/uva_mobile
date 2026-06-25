class DailyActivityDto {
  final int day;
  final double hours;

  DailyActivityDto({required this.day, required this.hours});

  factory DailyActivityDto.fromJson(Map<String, dynamic> json) {
    return DailyActivityDto(
      day: (json['day'] as num?)?.toInt() ?? 1,
      hours: (json['hours'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class HomeSummaryDto {
  final double personalGoalHours;
  final double scholarshipGoalHours;
  final double monthLoggedHours;
  final double totalLoggedHours;
  final List<DailyActivityDto> currentMonthDailyActivities;

  HomeSummaryDto({
    required this.personalGoalHours,
    required this.scholarshipGoalHours,
    required this.monthLoggedHours,
    required this.totalLoggedHours,
    required this.currentMonthDailyActivities,
  });

  factory HomeSummaryDto.fromJson(Map<String, dynamic> json) {
    var list = json['currentMonthDailyActivities'] as List? ?? [];
    List<DailyActivityDto> dailyActivities = list
        .map((e) => DailyActivityDto.fromJson(e as Map<String, dynamic>))
        .toList();

    return HomeSummaryDto(
      personalGoalHours: (json['personalGoalHours'] as num?)?.toDouble() ?? 0.0,
      scholarshipGoalHours:
          (json['scholarshipGoalHours'] as num?)?.toDouble() ?? 0.0,
      monthLoggedHours: (json['monthLoggedHours'] as num?)?.toDouble() ?? 0.0,
      totalLoggedHours: (json['totalLoggedHours'] as num?)?.toDouble() ?? 0.0,
      currentMonthDailyActivities: dailyActivities,
    );
  }
}
