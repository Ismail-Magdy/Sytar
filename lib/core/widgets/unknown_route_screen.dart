import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/extensions.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/core/widgets/custom_button.dart';

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
              verticalSpace(0),
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
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.secondaryColor,
                ),
              ),
              //
              verticalSpace(40),
              //
              CustomButton(
                text: "الرجوع للسابق",
                onPressed: () => context.pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
