import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:sytar/core/themes/app_colors.dart";
import "../helpers/spacing.dart";

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.errorText});

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: .symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            Center(
              child: Image.asset(
                "assets/images/error-404.png",
                height: 100.h,
                width: 100.w,
                color: AppColors.primaryColor,
              ),
            ),
            //
            verticalSpace(30),
            //
            Text(
              "حدث خطأ",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: .bold,
                color: Colors.black,
              ),
            ),
            //
            verticalSpace(16),
            //
            Text(
              "حدث خطأ أثناء تحميل الصفحة.\nبرجاء المحاولة لاحقاً",
              textAlign: .center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: .bold,
                height: 1.5.h,
                color: AppColors.primaryColor,
              ),
            ),
            //
            //
          ],
        ),
      ),
    );
  }
}
