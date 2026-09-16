import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/themes/app_colors.dart';

class AddTaskSectionTitle extends StatelessWidget {
  const AddTaskSectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: .bold,
        color: AppColors.primaryColor,
      ),
    );
  }
}
