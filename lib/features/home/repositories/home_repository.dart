import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/local_storage/hive/cache_service.dart';
import '../../../core/network/api/i_api_client.dart';
import '../../../core/network/exceptions/offline_no_profile_exception.dart';
import '../../../core/providers/api_client_provider.dart';
import '../models/profile_response_dto.dart';
import '../models/scholarship_response_dto.dart';
import '../models/volunteer_history_dto.dart';

part 'home_repository.g.dart';

class HomeRepository {
  final IApiClient _apiClient;
  final CacheService _cache;

  HomeRepository(this._apiClient, this._cache);

  Future<ProfileResponseDto> getMe({bool forceRefresh = false}) async {
    const key = 'profile_me';
    if (!forceRefresh) {
      final cached = await _cache.get(key, maxAge: const Duration(minutes: 5));
      if (cached != null) {
        return ProfileResponseDto.fromJson(cached as Map<String, dynamic>);
      }
    }

    try {
      final response = await _apiClient.get('/api/v1/profiles/me');
      await _cache.set(key, response);
      return ProfileResponseDto.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      final fallback = await _cache.get(key, ignoreExpiration: true);
      if (fallback != null) {
        return ProfileResponseDto.fromJson(fallback as Map<String, dynamic>);
      }
      throw const OfflineNoProfileException();
    }
  }

  Future<VolunteerHistoryDto> getMyVolunteerHistory({
    bool forceRefresh = false,
  }) async {
    const key = 'volunteer_history_me';
    if (!forceRefresh) {
      final cached = await _cache.get(key, maxAge: const Duration(minutes: 5));
      if (cached != null) {
        return VolunteerHistoryDto.fromJson(cached as Map<String, dynamic>);
      }
    }

    try {
      final response = await _apiClient.get('/api/v1/reports/volunteers/me');
      await _cache.set(key, response);
      return VolunteerHistoryDto.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      final fallback = await _cache.get(key, ignoreExpiration: true);
      if (fallback != null) {
        return VolunteerHistoryDto.fromJson(fallback as Map<String, dynamic>);
      }
      rethrow;
    }
  }

  Future<List<ScholarshipResponseDto>> getMyScholarships({
    bool forceRefresh = false,
  }) async {
    const key = 'scholarships_mine';
    if (!forceRefresh) {
      final cached = await _cache.get(key, maxAge: const Duration(minutes: 5));
      if (cached != null) {
        return (cached as List)
            .map(
              (e) => ScholarshipResponseDto.fromJson(e as Map<String, dynamic>),
            )
            .toList();
      }
    }

    try {
      final response = await _apiClient.get('/api/v1/scholarships/mine');
      await _cache.set(key, response);
      return (response as List)
          .map(
            (e) => ScholarshipResponseDto.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      final fallback = await _cache.get(key, ignoreExpiration: true);
      if (fallback != null) {
        return (fallback as List)
            .map(
              (e) => ScholarshipResponseDto.fromJson(e as Map<String, dynamic>),
            )
            .toList();
      }
      rethrow;
    }
  }
}

@riverpod
HomeRepository homeRepository(Ref ref) {
  return HomeRepository(
    ref.watch(apiClientProvider),
    ref.watch(cacheServiceProvider),
  );
}
