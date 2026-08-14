import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';

class SubjectDetailsInfoCard extends StatelessWidget {
  const SubjectDetailsInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.subjectColor,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color subjectColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .symmetric(vertical: 16.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: .circular(16.r),
        border: .all(color: Colors.grey.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: subjectColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          //
          Icon(icon, color: subjectColor, size: 28.sp),
          //
          verticalSpace(12),
          //
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: .bold,
              color: Colors.black87,
            ),
          ),
          //
          verticalSpace(4),
          //
          Text(
            title,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
          ),
          //
        ],
      ),
    );
  }
}
