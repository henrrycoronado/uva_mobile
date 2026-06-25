import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api/i_api_client.dart';
import '../../../core/providers/api_client_provider.dart';

final catalogRepositoryProvider = Provider<CatalogRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CatalogRepository(apiClient);
});

class CatalogRepository {
  final IApiClient _apiClient;

  CatalogRepository(this._apiClient);

  Future<List<Map<String, dynamic>>> getActivityTypes() async {
    final response = await _apiClient.get('/api/v1/reference-catalog/types/activity');
    final data = response as List;
    return data.cast<Map<String, dynamic>>();
  }
}
