import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';

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
      padding: .all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: .circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
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
                      "اللي هتركز عليه النهاردة",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: .w800,
                        color: Colors.white,
                      ),
                    ),
                    //
                    verticalSpace(5),
                    //
                    Text(
                      taskTitle,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: .w500,
                        color: Colors.grey[400],
                      ),
                      maxLines: 2,
                      overflow: .ellipsis,
                    ),
                    //
                  ],
                ),
              ),
              //
              horizontalSpace(12),
              //
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: .circular(12.r),
                ),
                child: Center(
                  child: Icon(
                    Icons.local_fire_department_rounded,
                    color: Colors.orangeAccent,
                    size: 30.sp,
                  ),
                ),
              ),
            ],
          ),
          verticalSpace(16),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: onStartPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.15),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
              ),
              child: Text(
                buttonText, // بنقرأ النص من هنا
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
