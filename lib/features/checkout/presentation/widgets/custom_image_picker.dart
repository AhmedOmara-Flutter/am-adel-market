import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/app_color.dart';

class CustomImagePicker extends StatefulWidget {
  final ValueChanged<File?> onImagePicked;
  final String? initialImage;

  const CustomImagePicker({
    super.key,
    required this.onImagePicked,
    this.initialImage,
  });

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  File? imagePath;
  String? networkImage;

  @override
  void initState() {
    super.initState();
    networkImage = widget.initialImage;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          final ImagePicker picker = ImagePicker();
          final XFile? image = await picker.pickImage(
            source: ImageSource.gallery,
          );

          if (image != null) {
            setState(() {
              imagePath = File(image.path);
              widget.onImagePicked(imagePath!);
            });
          }
        } on Exception catch (e) {
          debugPrint(e.toString());
        }
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 30.h,
              right: imagePath != null ? 5.w : 15.w,
            ),
            child: imagePath != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: SizedBox(
                height: 80.h,
                width: 80.w,
                child: Image.file(
                  imagePath!,
                  fit: BoxFit.cover,
                ),
              ),
            )
                : networkImage != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: SizedBox(
                height: 80.h,
                width: 80.w,
                child: Image.network(
                  networkImage!,
                  fit: BoxFit.cover,
                ),
              ),
            )
                : Container(
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                color: AppColor.card,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColor.border,
                ),
              ),
              child: Icon(
                Icons.photo_outlined,
                color: AppColor.mainColor,
                size: 38.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}