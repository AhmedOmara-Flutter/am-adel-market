
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../errors/failure.dart';

abstract class UploadImageRepo {
  Future<Either<Failure, String>> uploadImage(File imageFile,);

  Future<Either<Failure, List<String>>> uploadSubImages(List<File> subImages);

}

