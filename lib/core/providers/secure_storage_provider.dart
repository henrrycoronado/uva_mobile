import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../local_storage/secure/i_secure_storage.dart';
import '../local_storage/secure/secure_storage.dart';

final secureStorageProvider = Provider<ISecureStorage>((ref) {
  return const SecureStorage();
});
