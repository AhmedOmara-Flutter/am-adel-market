import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class StorageServices {
  Future<String> uploadImage(File imageFile, String path);
  Future<File> compressedImage(File imageFile);
}

class SupabaseStorage implements StorageServices {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<String> uploadImage(File imageFile, String path) async {

    final file = File(imageFile.path);

    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';

    await _supabase.storage.from(path).upload(fileName, file);

    final publicUrl = _supabase.storage.from(path).getPublicUrl(fileName);

    return publicUrl;
  }

  @override
  Future<File> compressedImage(File imageFile) async {
    return await compute(_compressImage, imageFile.path);
  }
}

File _compressImage(String path) {
  final file = File(path);
  final bytes = file.readAsBytesSync();

  final img.Image? image = img.decodeImage(bytes);

  if (image == null) {
    return file;
  }

  final resized = img.copyResize(
    image,
    width: 400,
  );

  final extension = file.path.split('.').last.toLowerCase();

  if (extension == 'png') {
    final newPath = '${file.path}_compressed.png';

    File(newPath).writeAsBytesSync(
      img.encodePng(resized),
    );

    return File(newPath);
  }

  final newPath = '${file.path}_compressed.jpg';

  File(newPath).writeAsBytesSync(
    img.encodeJpg(
      resized,
      quality: 50,
    ),
  );

  return File(newPath);
}