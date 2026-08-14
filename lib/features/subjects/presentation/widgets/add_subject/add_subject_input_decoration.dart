import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/themes/app_colors.dart';

InputDecoration addSubjectsInputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Colors.grey, fontSize: 13.sp),
    filled: true,
    fillColor: Colors.grey[100],
    border: OutlineInputBorder(
      borderRadius: .circular(12.r),
      borderSide: .none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: .circular(12.r),
      borderSide: const BorderSide(color: AppColors.primaryColor),
    ),
    contentPadding: .symmetric(horizontal: 16.w, vertical: 12.h),
  );
}
