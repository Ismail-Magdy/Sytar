import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/themes/app_colors.dart';

class AddSubjectSectionTitle extends StatelessWidget {
  const AddSubjectSectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: .bold,
        color: AppColors.primaryColor,
      ),
    );
  }
}
