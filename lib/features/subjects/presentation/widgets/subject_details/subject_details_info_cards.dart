import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/features/subjects/presentation/widgets/subject_details/subject_details_info_card.dart';

class SubjectDetailsInfoCards extends StatelessWidget {
  const SubjectDetailsInfoCards({
    super.key,
    required this.subjectColor,
    required this.valueCreditHours,
    required this.valueTotalMarks,
    required this.valueTargetGrade,
  });

  final Color subjectColor;
  final String valueCreditHours;
  final String valueTotalMarks;
  final String valueTargetGrade;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 24.w),
      child: Row(
        children: [
          //
          Expanded(
            child: SubjectDetailsInfoCard(
              title: "الساعات",
              value: valueCreditHours,
              icon: Icons.access_time_rounded,
              subjectColor: subjectColor,
            ),
          ),
          //
          horizontalSpace(12),
          //
          Expanded(
            child: SubjectDetailsInfoCard(
              title: "الدرجة",
              value: valueTotalMarks,
              icon: Icons.score_rounded,
              subjectColor: subjectColor,
            ),
          ),
          //
          horizontalSpace(12),
          //
          Expanded(
            child: SubjectDetailsInfoCard(
              title: "الهدف",
              value: valueTargetGrade,
              icon: Icons.flag_rounded,
              subjectColor: subjectColor,
            ),
          ),
          //
        ],
      ),
    );
  }
}
