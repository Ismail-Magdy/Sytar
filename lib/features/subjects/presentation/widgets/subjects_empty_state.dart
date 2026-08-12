import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';

class SubjectsEmptyState extends StatelessWidget {
  const SubjectsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: .symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Icon(
              Icons.library_books_rounded,
              size: 60.sp,
              color: Colors.grey[300],
            ),
            verticalSpace(16),
            Text(
              "مفيش مواد متسجلة للترم ده",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: .bold,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
