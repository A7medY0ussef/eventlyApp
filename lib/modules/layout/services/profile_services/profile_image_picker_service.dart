import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ProfileImagePickerService {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> cameraPicker() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    return image != null ? File(image.path) : null;
  }

  static Future<File?> galleryPicker() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    return image != null ? File(image.path) : null;
  }
}
