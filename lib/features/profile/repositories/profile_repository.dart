import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/local_storage/hive/cache_service.dart';
import '../../../core/network/api/i_api_client.dart';
import '../../../core/network/exceptions/offline_no_profile_exception.dart';
import '../../../core/providers/api_client_provider.dart';
import '../../home/models/profile_response_dto.dart';
import '../models/update_profile_dto.dart';

part 'profile_repository.g.dart';

class ProfileRepository {
  final IApiClient _apiClient;
  final CacheService _cache;

  ProfileRepository(this._apiClient, this._cache);

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

  Future<void> updateProfile(UpdateProfileDto dto) async {
    await _apiClient.put('/api/v1/profiles/me', body: dto.toJson());
  }

  Future<void> updateProfilePhoto(String filePath) async {
    await _apiClient.patchMultipart(
      '/api/v1/profiles/me/photo',
      filePath: filePath,
      fileFieldName: 'photo',
    );
  }
}

@riverpod
ProfileRepository profileRepository(Ref ref) {
  return ProfileRepository(
    ref.watch(apiClientProvider),
    ref.watch(cacheServiceProvider),
  );
}
