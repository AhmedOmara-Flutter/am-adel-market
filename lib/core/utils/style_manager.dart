import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';

class StyleManager {
  static const String _fontFamily = 'Cairo';

  /// Secondary Text
  static TextStyle font11Weight400 = TextStyle(
    color: AppColor.textSecondary,
    fontFamily: _fontFamily,
    fontSize: 11.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle font12Weight500 = TextStyle(
    color: AppColor.textSecondary,
    fontFamily: _fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle font13Weight400 = TextStyle(
    color: AppColor.textSecondary,
    fontFamily: _fontFamily,
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
  );

  /// Slightly Brighter Secondary
  static TextStyle font13Weight600 = TextStyle(
    color: const Color(0xFFD0D0D0),
    fontFamily: _fontFamily,
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
  );

  /// Primary Orange
  static TextStyle font13Weight700 = TextStyle(
    color: AppColor.mainColor,
    fontFamily: _fontFamily,
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle font14Weight600 = TextStyle(
    color: AppColor.mainColor,
    fontFamily: _fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
  );

  /// Primary Text
  static TextStyle font15Weight700 = TextStyle(
    color: AppColor.textPrimary,
    fontFamily: _fontFamily,
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle font15Weight800 = TextStyle(
    color: AppColor.textSecondary,
    fontFamily: _fontFamily,
    fontSize: 15.sp,
    fontWeight: FontWeight.w800,
  );

  static TextStyle font16Weight600 = TextStyle(
    color: AppColor.textPrimary,
    fontFamily: _fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle font16Weight700 = TextStyle(
    color: AppColor.textPrimary,
    fontFamily: _fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle font18Weight700 = TextStyle(
    color: AppColor.textPrimary,
    fontFamily: _fontFamily,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle font19Weight700 = TextStyle(
    color: AppColor.textPrimary,
    fontFamily: _fontFamily,
    fontSize: 19.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle font23Weight700 = TextStyle(
    color: AppColor.textPrimary,
    fontFamily: _fontFamily,
    fontSize: 23.sp,
    fontWeight: FontWeight.w700,
  );

  /// Banner
  static TextStyle font28Weight700 = TextStyle(
    color: AppColor.textPrimary,
    fontFamily: _fontFamily,
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle font32Weight700 = TextStyle(
    color: AppColor.textPrimary,
    fontFamily: _fontFamily,
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle font48Weight900 = TextStyle(
    color: AppColor.textPrimary,
    fontFamily: _fontFamily,
    fontSize: 48.sp,
    fontWeight: FontWeight.w900,
  );
}