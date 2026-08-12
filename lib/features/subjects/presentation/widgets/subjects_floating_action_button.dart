import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/di/dependency_injection.dart';
import 'package:sytar/core/helpers/extensions.dart';
import 'package:sytar/core/routes/routes.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/features/home/manager/home_cubit.dart';
import 'package:sytar/features/subjects/manager/subjects/subjects_cubit.dart';

class SubjectsFloatingActionButton extends StatelessWidget {
  const SubjectsFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () async {
        final result = await context.pushNamed(Routes.addSubjectScreen);
        if (result == true) {
          getIt<SubjectsCubit>().fetchCurrentSemesterSubjects();
          getIt<HomeCubit>().getDashboardData();
        }
      },
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: .circular(14.r)),
      label: Text(
        "إضافة مادة",
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: .bold,
          color: AppColors.white,
        ),
      ),
    );
  }
}
