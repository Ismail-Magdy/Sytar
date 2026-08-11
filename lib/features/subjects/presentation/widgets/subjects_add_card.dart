import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/di/dependency_injection.dart';
import 'package:sytar/core/helpers/extensions.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/routes/routes.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/features/home/manager/home_cubit.dart';
import 'package:sytar/features/subjects/manager/subjects/subjects_cubit.dart';

class SubjectsAddCard extends StatelessWidget {
  const SubjectsAddCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await context.pushNamed(Routes.addSubjectScreen);
        if (result == true) {
          getIt<SubjectsCubit>().fetchCurrentSemesterSubjects();
          getIt<HomeCubit>().getDashboardData();
        }
      },
      child: Container(
        padding: .symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withValues(alpha: 0.03),
          borderRadius: .circular(16.r),
          border: Border.all(
            color: AppColors.primaryColor.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: .center,
          children: [
            Container(
              padding: .all(8.w),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                shape: .circle,
              ),
              child: Icon(
                Icons.add_rounded,
                color: AppColors.primaryColor,
                size: 24.sp,
              ),
            ),
            horizontalSpace(12),
            Text(
              "إضافة مادة جديدة",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: .bold,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
