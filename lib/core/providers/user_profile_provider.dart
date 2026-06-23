import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/jwt_utils.dart';
import 'secure_storage_provider.dart';

final userIdProvider = FutureProvider<String?>((ref) async {
  final secureStorage = ref.watch(secureStorageProvider);
  final token = await secureStorage.getToken();

  if (token == null || token.isEmpty) {
    return null;
  }

  return JwtUtils.getUserIdFromToken(token);
});
