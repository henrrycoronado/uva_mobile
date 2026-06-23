import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/api/api_client.dart';
import '../network/api/i_api_client.dart';
import 'secure_storage_provider.dart';

final apiClientProvider = Provider<IApiClient>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return ApiClient(secureStorage: secureStorage);
});
