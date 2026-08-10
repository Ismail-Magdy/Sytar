import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/features/home/presentation/widgets/home_setup_step.dart';

class HomeSetupProgressCard extends StatelessWidget {
  const HomeSetupProgressCard({
    super.key,
    required this.completedSteps,
    required this.progress,
    required this.hasSubjects,
    required this.hasTasks,
  });

  final int completedSteps;
  final double progress;
  final bool hasSubjects;
  final bool hasTasks;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(16.w),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor.withValues(alpha: 0.08),
        borderRadius: .circular(16.r),
        border: .all(color: AppColors.secondaryColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          //
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              //
              Text(
                "تجهيز الترم",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: .bold,
                  color: AppColors.primaryColor,
                ),
              ),
              //
              Text(
                "$completedSteps/2",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: .bold,
                  color: AppColors.primaryColor,
                ),
              ),
              //
            ],
          ),
          //
          verticalSpace(12),
          //
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.secondaryColor.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondaryColor),
            borderRadius: .circular(10.r),
            minHeight: 8.h,
          ),
          //
          verticalSpace(16),
          //
          HomeSetupStep(title: "إضافة أول مادة في الجدول", isDone: hasSubjects),
          //
          verticalSpace(8),
          //
          HomeSetupStep(title: "إضافة أول تاسك أو تسليم", isDone: hasTasks),
          //
        ],
      ),
    );
  }
}
