import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/local_storage/hive/cache_service.dart';
import '../../../core/network/api/i_api_client.dart';
import '../../../core/providers/api_client_provider.dart';
import '../models/program_response_dto.dart';
import '../models/update_program_dto.dart';

part 'program_repository.g.dart';

class ProgramRepository {
  final IApiClient _apiClient;
  final CacheService _cache;

  ProgramRepository(this._apiClient, this._cache);

  Future<List<ProgramResponseDto>> getPrograms({bool forceRefresh = false}) async {
    const key = 'programs_list';
    if (!forceRefresh) {
      final cached = await _cache.get(key, maxAge: const Duration(minutes: 5));
      if (cached != null && cached is List) {
        return cached.map((e) => ProgramResponseDto.fromJson(e as Map<String, dynamic>)).toList();
      }
    }

    try {
      final response = await _apiClient.get('/api/v1/programs');
      if (response is List) {
        await _cache.set(key, response);
        return response.map((e) => ProgramResponseDto.fromJson(e as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (e) {
      final fallback = await _cache.get(key, ignoreExpiration: true);
      if (fallback != null && fallback is List) {
        return fallback.map((e) => ProgramResponseDto.fromJson(e as Map<String, dynamic>)).toList();
      }
      rethrow;
    }
  }

  Future<ProgramResponseDto> getProgramByCode(String uvaCode, {bool forceRefresh = false}) async {
    final key = 'program_detail_$uvaCode';
    if (!forceRefresh) {
      final cached = await _cache.get(key, maxAge: const Duration(minutes: 5));
      if (cached != null) {
        return ProgramResponseDto.fromJson(cached as Map<String, dynamic>);
      }
    }

    try {
      final response = await _apiClient.get('/api/v1/programs/$uvaCode');
      await _cache.set(key, response);
      return ProgramResponseDto.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      final fallback = await _cache.get(key, ignoreExpiration: true);
      if (fallback != null) {
        return ProgramResponseDto.fromJson(fallback as Map<String, dynamic>);
      }
      rethrow;
    }
  }

  Future<ProgramResponseDto> createProgram(String name, String? acronym) async {
    final response = await _apiClient.post(
      '/api/v1/programs',
      body: {
        'name': name,
        if (acronym != null && acronym.isNotEmpty) 'acronym': acronym,
      },
    );
    
    final created = ProgramResponseDto.fromJson(response as Map<String, dynamic>);
    // We don't cache locally directly here, we let the list view model refresh itself.
    return created;
  }

  Future<ProgramResponseDto> updateProgram(String uvaCode, UpdateProgramDto dto) async {
    final response = await _apiClient.put(
      '/api/v1/programs/$uvaCode',
      body: dto.toJson(),
    );
    
    final updated = ProgramResponseDto.fromJson(response as Map<String, dynamic>);
    
    // Update local cache for details
    await _cache.set('program_detail_$uvaCode', response);
    
    return updated;
  }
}

@riverpod
ProgramRepository programRepository(Ref ref) {
  return ProgramRepository(
    ref.watch(apiClientProvider), 
    ref.watch(cacheServiceProvider)
  );
}
