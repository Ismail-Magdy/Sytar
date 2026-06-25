import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/themes/app_colors.dart';

class CustomVerticalIndicator extends StatelessWidget {
  const CustomVerticalIndicator({
    super.key,
    required this.onBoardingDataLength,
    required this.currentIndex,
  });
  final int onBoardingDataLength;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: List.generate(
        onBoardingDataLength,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutBack,
          margin: .symmetric(vertical: 4.h),
          height: currentIndex == index ? 35.h : 12.h,
          width: 6.w,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? AppColors.primaryColor
                : Colors.grey.shade400,
            borderRadius: .circular(10.r),
          ),
        ),
      ),
    );
  }
}
