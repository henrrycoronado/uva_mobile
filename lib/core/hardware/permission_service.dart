import 'package:permission_handler/permission_handler.dart';
import 'i_permission_service.dart';

class PermissionService implements IPermissionService {
  @override
  Future<bool> checkCameraPermission() async {
    return await Permission.camera.isGranted;
  }

  @override
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  @override
  Future<bool> checkLocationPermission() async {
    return await Permission.locationWhenInUse.isGranted;
  }

  @override
  Future<bool> requestLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();
    return status.isGranted;
  }

  @override
  Future<bool> checkPhotoLibraryPermission() async {
    return await Permission.photos.isGranted;
  }

  @override
  Future<bool> requestPhotoLibraryPermission() async {
    final status = await Permission.photos.request();
    return status.isGranted;
  }

  @override
  Future<bool> openSettings() async {
    return await openAppSettings();
  }
}
