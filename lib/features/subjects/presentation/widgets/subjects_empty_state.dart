import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sytar/core/helpers/spacing.dart';

class SubjectsEmptyState extends StatelessWidget {
  const SubjectsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: .symmetric(horizontal: 24.w),
        child: Column(
          children: [
            //
            verticalSpace(100),
            //
            Lottie.asset(
              "assets/lottie/no_subjects.json",
              width: 300.w,
              height: 300.h,
              fit: .contain,
            ),
            //
            verticalSpace(25),
            //
            Text(
              "مفيش مواد متسجلة للترم ده",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: .bold,
                color: Colors.grey[500],
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
