import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/features/subjects/data/models/subject_model.dart';
import 'package:sytar/features/subject_details/manager/subject_details_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubjectDetailsHeader extends StatelessWidget {
  const SubjectDetailsHeader({super.key, required this.subject});

  final SubjectModel subject;

  @override
  Widget build(BuildContext context) {
    final bool isLocked =
        subject.finalCalculatedGrade != null &&
        subject.finalCalculatedGrade!.isNotEmpty;
    final totalObtained =
        (subject.obtainedFinal ?? 0) +
        (subject.obtainedMidterm1 ?? 0) +
        (subject.obtainedMidterm2 ?? 0) +
        (subject.obtainedCoursework ?? 0);

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
              color: AppColors.black,
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
              style: TextStyle(fontSize: 15.sp, color: AppColors.darkGrey),
            ),
            //
            //
            if (isLocked) ...[
              verticalSpace(12),
              Row(
                mainAxisAlignment: .center,
                children: [
                  Container(
                    padding: .symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.1),
                      borderRadius: .circular(16.r),
                      border: Border.all(
                        color: AppColors.success.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "التقدير: ${subject.finalCalculatedGrade}",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: .bold,
                            color: AppColors.success,
                          ),
                        ),
                        horizontalSpace(8),
                        Text(
                          "($totalObtained/${subject.totalMarks})",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.success,
                          ),
                        ),
                        if (!subject.isGradeOverridden) ...[
                          horizontalSpace(8),
                          InkWell(
                            onTap: () => _showOverrideDialog(context),
                            child: Icon(
                              Icons.edit_rounded,
                              size: 18.sp,
                              color: AppColors.success,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ],
      ),
    );
  }

  void _showOverrideDialog(BuildContext context) {
    final TextEditingController gradeController = TextEditingController(
      text: subject.finalCalculatedGrade,
    );

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          "تعديل التقدير النهائي",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "تقدر تعدل التقدير مرة واحدة بس في حالة وجود منحنى درجات (Curve) أو خطأ في حسابات الكلية.",
              style: TextStyle(fontSize: 14.sp, color: AppColors.darkGrey),
              textAlign: TextAlign.center,
            ),
            verticalSpace(16),
            TextField(
              controller: gradeController,
              decoration: InputDecoration(
                labelText: "التقدير الجديد (مثلاً: A+)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text("إلغاء", style: TextStyle(color: AppColors.darkGrey)),
          ),
          ElevatedButton(
            onPressed: () {
              if (gradeController.text.trim().isNotEmpty) {
                context.read<SubjectDetailsCubit>().overrideFinalGrade(
                  subject,
                  gradeController.text.trim(),
                );
                Navigator.pop(dialogContext);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            child: Text(
              "حفظ التعديل",
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
