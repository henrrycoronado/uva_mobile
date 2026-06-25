import 'home_summary_dto.dart';
import 'profile_response_dto.dart';
import 'scholarship_response_dto.dart';

class HomeState {
  final ProfileResponseDto profile;
  final HomeSummaryDto summary;
  final List<ScholarshipResponseDto> scholarships;
  final int currentMonth;
  final int currentYear;

  HomeState({
    required this.profile,
    required this.summary,
    required this.scholarships,
    required this.currentMonth,
    required this.currentYear,
  });

  ScholarshipResponseDto? get activeScholarship {
    try {
      return scholarships.firstWhere((s) => s.stateCode != 'stage-4');
    } catch (e) {
      return null;
    }
  }

  HomeState copyWith({
    ProfileResponseDto? profile,
    HomeSummaryDto? summary,
    List<ScholarshipResponseDto>? scholarships,
    int? currentMonth,
    int? currentYear,
  }) {
    return HomeState(
      profile: profile ?? this.profile,
      summary: summary ?? this.summary,
      scholarships: scholarships ?? this.scholarships,
      currentMonth: currentMonth ?? this.currentMonth,
      currentYear: currentYear ?? this.currentYear,
    );
  }
}
