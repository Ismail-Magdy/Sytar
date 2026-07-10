import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';

class BuildChip extends StatelessWidget {
  const BuildChip({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor.withValues(alpha: 0.08),
        borderRadius: .circular(20.r),
        border: .all(color: AppColors.primaryColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          //
          Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: .w600,
              color: AppColors.primaryColor,
            ),
          ),
          //
          horizontalSpace(4),
          //
          Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.primaryColor,
            size: 18.sp,
          ),
          //
        ],
      ),
    );
  }
}
