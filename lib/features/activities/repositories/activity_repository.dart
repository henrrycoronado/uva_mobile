import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api/i_api_client.dart';
import '../../../core/providers/api_client_provider.dart';
import '../models/activity_response_dto.dart';
import '../models/create_activity_simple_dto.dart';

abstract class IActivityRepository {
  Future<List<ActivityResponseDto>> getActivitiesByProgram(String programCode);
  Future<ActivityResponseDto> getActivityByCode(String uvaCode);
  Future<ActivityResponseDto> createSimple(CreateActivitySimpleDto dto);
}

final activityRepositoryProvider = Provider<IActivityRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ActivityRepository(apiClient);
});

class ActivityRepository implements IActivityRepository {
  final IApiClient _apiClient;

  ActivityRepository(this._apiClient);

  @override
  Future<List<ActivityResponseDto>> getActivitiesByProgram(
    String programCode,
  ) async {
    final response = await _apiClient.get(
      '/api/v1/activities/by-program/$programCode',
    );
    final data = response as List;
    return data
        .map((e) => ActivityResponseDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ActivityResponseDto> getActivityByCode(String uvaCode) async {
    final response = await _apiClient.get('/api/v1/activities/$uvaCode');
    return ActivityResponseDto.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<ActivityResponseDto> createSimple(CreateActivitySimpleDto dto) async {
    final response = await _apiClient.post(
      '/api/v1/activities/simple',
      body: dto.toJson(),
    );
    return ActivityResponseDto.fromJson(response as Map<String, dynamic>);
  }
}
