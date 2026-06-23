import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/local_storage/hive/cache_service.dart';
import '../../../core/network/api/i_api_client.dart';
import '../../../core/providers/api_client_provider.dart';
import '../models/catalog_item_dto.dart';

part 'catalogs_repository.g.dart';

class CatalogsRepository {
  final IApiClient _apiClient;
  final CacheService _cache;

  CatalogsRepository(this._apiClient, this._cache);

  Future<List<CatalogItemDto>> getTypes(String typeGroup, {bool forceRefresh = false}) async {
    final key = 'catalog_types_$typeGroup';
    if (!forceRefresh) {
      final cached = await _cache.get(key, maxAge: const Duration(minutes: 5));
      if (cached != null) return (cached as List).map((json) => CatalogItemDto.fromJson(json as Map<String, dynamic>)).toList();
    }

    try {
      final response = await _apiClient.get('/api/v1/reference-catalog/types/$typeGroup');
      await _cache.set(key, response);
      return (response as List).map((json) => CatalogItemDto.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      final fallback = await _cache.get(key, ignoreExpiration: true);
      if (fallback != null) return (fallback as List).map((json) => CatalogItemDto.fromJson(json as Map<String, dynamic>)).toList();
      rethrow;
    }
  }

  Future<List<CatalogItemDto>> getStates(String stateGroup, {bool forceRefresh = false}) async {
    final key = 'catalog_states_$stateGroup';
    if (!forceRefresh) {
      final cached = await _cache.get(key, maxAge: const Duration(minutes: 5));
      if (cached != null) return (cached as List).map((json) => CatalogItemDto.fromJson(json as Map<String, dynamic>)).toList();
    }

    try {
      final response = await _apiClient.get('/api/v1/reference-catalog/states/$stateGroup');
      await _cache.set(key, response);
      return (response as List).map((json) => CatalogItemDto.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      final fallback = await _cache.get(key, ignoreExpiration: true);
      if (fallback != null) return (fallback as List).map((json) => CatalogItemDto.fromJson(json as Map<String, dynamic>)).toList();
      rethrow;
    }
  }
}

@riverpod
CatalogsRepository catalogsRepository(Ref ref) {
  return CatalogsRepository(ref.watch(apiClientProvider), ref.watch(cacheServiceProvider));
}
