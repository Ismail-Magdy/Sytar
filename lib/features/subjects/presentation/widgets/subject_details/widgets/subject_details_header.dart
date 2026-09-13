import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/features/subjects/data/models/subject_model.dart';

class SubjectDetailsHeader extends StatelessWidget {
  const SubjectDetailsHeader({
    super.key,
    required this.subject,
    required this.subjectColor,
  });

  final SubjectModel subject;
  final Color subjectColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: .infinity,
      padding: .only(bottom: 30.h, left: 24.w, right: 24.w),
      decoration: BoxDecoration(
        borderRadius: .only(
          bottomLeft: .circular(30.r),
          bottomRight: .circular(30.r),
        ),
      ),
      child: Column(
        children: [
          //
          Lottie.asset("assets/lottie/subject.json", height: 260.h, fit: .fill),
          //
          Text(
            subject.subjectName,
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: .bold,
              color: Colors.black87,
            ),
            textAlign: .center,
          ),
          //
          if (subject.instructorName != null &&
              subject.instructorName!.isNotEmpty) ...[
            //
            verticalSpace(2),
            //
            Text(
              "د. ${subject.instructorName}",
              style: TextStyle(fontSize: 15.sp, color: AppColors.grey),
            ),
            //
          ],
        ],
      ),
    );
  }
}
