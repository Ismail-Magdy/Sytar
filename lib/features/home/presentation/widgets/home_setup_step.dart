import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';

class HomeSetupStep extends StatelessWidget {
  const HomeSetupStep({super.key, required this.title, required this.isDone});

  final String title;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //
        Icon(
          isDone ? Icons.check_circle_rounded : Icons.circle_outlined,
          color: isDone ? Colors.green : Colors.grey[500],
          size: 20.sp,
        ),
        //
        horizontalSpace(8),
        //
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: .w600,
            color: isDone ? Colors.grey[700] : AppColors.secondaryColor,
            decoration: isDone ? .lineThrough : .none,
          ),
        ),
        //
      ],
    );
  }
}
