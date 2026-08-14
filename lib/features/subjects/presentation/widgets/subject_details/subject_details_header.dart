import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
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
      padding: .symmetric(vertical: 30.h, horizontal: 24.w),
      decoration: BoxDecoration(
        color: subjectColor.withValues(alpha: 0.05),
        borderRadius: .only(
          bottomLeft: .circular(30.r),
          bottomRight: .circular(30.r),
        ),
      ),
      child: Column(
        children: [
          //
          Container(
            padding: .all(16.w),
            decoration: BoxDecoration(
              color: subjectColor.withValues(alpha: 0.15),
              shape: .circle,
            ),
            child: Icon(
              Icons.menu_book_rounded,
              size: 40.sp,
              color: subjectColor,
            ),
          ),
          //
          verticalSpace(16),
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
            verticalSpace(8),
            //
            Text(
              "د. ${subject.instructorName}",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[800]),
            ),
            //
          ],
        ],
      ),
    );
  }
}
