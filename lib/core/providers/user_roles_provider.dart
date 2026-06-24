import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/secure_storage_provider.dart';
import '../utils/jwt_utils.dart';

final userRolesProvider = FutureProvider<List<String>>((ref) async {
  final secureStorage = ref.watch(secureStorageProvider);
  final token = await secureStorage.getToken();

  if (token == null || token.isEmpty) {
    return [];
  }

  return JwtUtils.getRolesFromToken(token);
});

final isSuperUserOrAdminProvider = FutureProvider<bool>((ref) async {
  final roles = await ref.watch(userRolesProvider.future);
  return roles.contains('SuperUser') || roles.contains('Admin');
});
