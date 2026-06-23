import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../hardware/i_permission_service.dart';
import '../hardware/permission_service.dart';

final permissionServiceProvider = Provider<IPermissionService>((ref) {
  return PermissionService();
});
