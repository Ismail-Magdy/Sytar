import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/core/widgets/custom_button.dart';

class FocusTodayCard extends StatelessWidget {
  final String taskTitle;
  final String buttonText;
  final VoidCallback onStartPressed;

  const FocusTodayCard({
    super.key,
    required this.taskTitle,
    required this.buttonText,
    required this.onStartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .infinity,
      padding: .all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: .circular(16.r),
        border: .all(color: AppColors.secondaryColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          //
          Row(
            crossAxisAlignment: .start,
            mainAxisAlignment: .spaceBetween,
            children: [
              //
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    //
                    Text(
                      "التركيز اليومي",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: .w800,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    //
                    verticalSpace(8),
                    //
                    Text(
                      taskTitle,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: .w500,
                        color: AppColors.secondaryColor,
                      ),
                      maxLines: 2,
                      overflow: .ellipsis,
                    ),
                    //
                  ],
                ),
              ),
              //
              horizontalSpace(16),
              //
              // أيقونة الهدف
              Container(
                width: 45.w,
                height: 45.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.08),
                  borderRadius: .circular(12.r),
                ),
                child: Center(
                  child: Icon(
                    CupertinoIcons.triangle_lefthalf_fill,
                    color: AppColors.primaryColor,
                    size: 22.sp,
                  ),
                ),
              ),
              //
            ],
          ),
          //
          verticalSpace(20),
          //
          // زرار بعرض الكارت
          CustomButton(text: buttonText, onPressed: onStartPressed),
          //
        ],
      ),
    );
  }
}
