import 'profile_response_dto.dart';
import 'scholarship_response_dto.dart';
import 'volunteer_history_dto.dart';

class HomeState {
  final ProfileResponseDto profile;
  final VolunteerHistoryDto history;
  final List<ScholarshipResponseDto> scholarships;

  const HomeState({
    required this.profile,
    required this.history,
    required this.scholarships,
  });

  ScholarshipResponseDto? get activeScholarship {
    if (scholarships.isEmpty) return null;
    return scholarships.first;
  }
}
