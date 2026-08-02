import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CameraService {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> takePhoto() async {
    return await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
  }

  Future<XFile?> pickFromGallery() async {
    return await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
  }
}

final cameraServiceProvider = Provider<CameraService>((ref) {
  return CameraService();
});
