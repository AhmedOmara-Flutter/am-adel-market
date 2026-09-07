import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage({ImageSource source = ImageSource.camera}) async {
  try {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      return File(image.path);
    }
  } catch (e) {
    print('Pick image error: $e');
  }
  return null;
}