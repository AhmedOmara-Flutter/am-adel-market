import 'dart:io';

import 'package:flutter/services.dart';

void getFileSize(String fullPath) async {
  final data = await rootBundle.load(fullPath);

  int bytes = data.lengthInBytes;

  double kb = bytes / 1024;
  double mb = kb / 1024;

  print('Size in bytes: $bytes');
  print('Size in KB: ${kb.toStringAsFixed(2)}');
  print('Size in MB: ${mb.toStringAsFixed(2)}');
}