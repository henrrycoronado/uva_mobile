import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api/i_api_client.dart';
import '../../../core/providers/api_client_provider.dart';
import '../models/profile_response_dto.dart';
import '../models/scholarship_response_dto.dart';
import '../models/volunteer_history_dto.dart';

part 'home_repository.g.dart';

class HomeRepository {
  final IApiClient _apiClient;

  HomeRepository(this._apiClient);

  Future<ProfileResponseDto> getMe() async {
    final response = await _apiClient.get('/api/v1/profiles/me');
    return ProfileResponseDto.fromJson(response as Map<String, dynamic>);
  }

  Future<VolunteerHistoryDto> getMyVolunteerHistory() async {
    final response = await _apiClient.get('/api/v1/reports/volunteers/me');
    return VolunteerHistoryDto.fromJson(response as Map<String, dynamic>);
  }

  Future<List<ScholarshipResponseDto>> getMyScholarships() async {
    final response = await _apiClient.get('/api/v1/scholarships/mine');
    final data = response as List;
    return data
        .map((e) => ScholarshipResponseDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

@riverpod
HomeRepository homeRepository(Ref ref) {
  return HomeRepository(ref.watch(apiClientProvider));
}
