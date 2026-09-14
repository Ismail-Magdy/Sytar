import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';

class SubjectDetailsCompactInteractiveCard extends StatelessWidget {
  const SubjectDetailsCompactInteractiveCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 24.w),
      child: Container(
        padding: .all(12.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: .all(color: AppColors.grey.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            //
            Container(
              padding: .all(10.w),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                shape: .circle,
              ),
              child: Icon(icon, color: iconColor, size: 24.sp),
            ),
            //
            horizontalSpace(12),
            //
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  //
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: .bold,
                      color: AppColors.black,
                    ),
                  ),
                  //
                  verticalSpace(4),
                  //
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  //
                ],
              ),
            ),
            //
            horizontalSpace(8),
            //
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                minimumSize: Size.zero,
                shape: RoundedRectangleBorder(borderRadius: .circular(10.r)),
              ),
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: .bold,
                  color: AppColors.white,
                ),
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
