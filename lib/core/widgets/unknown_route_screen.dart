import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/extensions.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';

class UnknownRouteScreen extends StatelessWidget {
  const UnknownRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: .symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: .center,
            children: [
              //
              Lottie.asset(
                "assets/lottie/no_data.json",
                width: 250.w,
                height: 250.h,
              ),
              //
              verticalSpace(30),
              //
              Text(
                "المكان ده مش على الخريطة",
                textAlign: .center,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: .bold,
                  color: AppColors.primaryColor,
                ),
              ),
              //
              verticalSpace(12),
              //
              Text(
                "يبدو أن الصفحة التي تبحث عنها غير موجودة أو تم نقلها",
                textAlign: .center,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
              ),
              //
              verticalSpace(40),
              //
              SizedBox(
                width: .infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () => context.pop(),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: .circular(12.r),
                    ),
                  ),
                  child: Text(
                    "الرجوع للسابق",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
