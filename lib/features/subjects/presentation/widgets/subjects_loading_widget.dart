import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';

class SubjectsLoadingWidget extends StatelessWidget {
  const SubjectsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(bottom: 120.h),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        separatorBuilder: (context, index) => verticalSpace(16),
        itemBuilder: (context, index) {
          return Container(
            padding: .all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: .circular(16.r),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 4.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: .circular(4.r),
                  ),
                ),
                horizontalSpace(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Container(
                        width: 140.w,
                        height: 16.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: .circular(4.r),
                        ),
                      ),
                      verticalSpace(8),
                      Container(
                        width: 90.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: .circular(4.r),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16.sp,
                  color: Colors.grey[300],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
