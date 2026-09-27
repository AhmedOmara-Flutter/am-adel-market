import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/style_manager.dart';

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

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image == null) return;

      final file = File(image.path);

      setState(() {
        imagePath = file;
        networkImage = null;
      });

      widget.onImagePicked(file);
    } on Exception catch (e) {
      debugPrint('Image Picker Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasImage = imagePath != null || networkImage != null;

    return GestureDetector(
      onTap: _pickImage,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        width: 105.w,
        height: 115.h,
        padding: EdgeInsets.all(7.w),
        decoration: BoxDecoration(
          color: AppColor.background,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: hasImage
                ? AppColor.mainColor.withOpacity(.55)
                : AppColor.border.withOpacity(.3),
            width: hasImage ? 1.3 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withOpacity(.04),
              blurRadius: 8.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(11.r),
                child: _buildImage(),
              ),
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  hasImage
                      ? Icons.refresh_rounded
                      : Icons.add_photo_alternate_outlined,
                  color: AppColor.mainColor,
                  size: 14.sp,
                ),
                SizedBox(width: 4.w),
                Flexible(
                  child: Text(
                    hasImage ? 'تغيير الصورة' : 'إضافة صورة',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.font11Weight400.copyWith(
                      color: AppColor.mainColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    if (imagePath != null) {
      return Image.file(
        imagePath!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    }

    if (networkImage != null) {
      return Image.network(
        networkImage!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return _emptyImage();
        },
      );
    }

    return _emptyImage();
  }

  Widget _emptyImage() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(11.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: AppColor.mainColor.withOpacity(.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.cloud_upload_outlined,
              color: AppColor.mainColor,
              size: 21.sp,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            'إثبات الدفع',
            style: StyleManager.font11Weight400.copyWith(
              color: AppColor.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
