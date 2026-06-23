abstract class IPermissionService {
  Future<bool> requestCameraPermission();
  Future<bool> checkCameraPermission();

  Future<bool> requestPhotoLibraryPermission();
  Future<bool> checkPhotoLibraryPermission();

  Future<bool> requestLocationPermission();
  Future<bool> checkLocationPermission();

  Future<bool> openSettings();
}
