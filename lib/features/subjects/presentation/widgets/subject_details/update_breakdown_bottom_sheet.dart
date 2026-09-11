import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/core/widgets/custom_text_field.dart';
import 'package:sytar/features/subjects/data/models/subject_model.dart';
import 'package:sytar/features/subjects/manager/subject_details/subject_details_cubit.dart';

class UpdateBreakdownBottomSheet extends StatefulWidget {
  final SubjectModel subject;
  final Color subjectColor;

  const UpdateBreakdownBottomSheet({
    super.key,
    required this.subject,
    required this.subjectColor,
  });

  @override
  State<UpdateBreakdownBottomSheet> createState() =>
      _UpdateBreakdownBottomSheetState();
}

class _UpdateBreakdownBottomSheetState
    extends State<UpdateBreakdownBottomSheet> {
  final _midterm1Controller = TextEditingController();
  final _midterm2Controller = TextEditingController(); // أو العملي
  final _courseworkController = TextEditingController();

  late int missingMarks; // الدرجات اللي لسه متوزعتش
  int currentSum = 0;

  @override
  void initState() {
    super.initState();
    // بنحسب الدرجات الغامضة (المجموع - الفاينل)
    missingMarks = widget.subject.totalMarks - widget.subject.finalExamTotal;

    // بنراقب الحقول عشان نحسب المجموع لايف
    _midterm1Controller.addListener(_calculateSum);
    _midterm2Controller.addListener(_calculateSum);
    _courseworkController.addListener(_calculateSum);
  }

  void _calculateSum() {
    final m1 = int.tryParse(_midterm1Controller.text) ?? 0;
    final m2 = int.tryParse(_midterm2Controller.text) ?? 0;
    final cw = int.tryParse(_courseworkController.text) ?? 0;

    setState(() {
      currentSum = m1 + m2 + cw;
    });
  }

  @override
  void dispose() {
    _midterm1Controller.dispose();
    _midterm2Controller.dispose();
    _courseworkController.dispose();
    super.dispose();
  }

  void _submit() {
    if (currentSum == missingMarks) {
      final updatedSubject = widget.subject.copyWith(
        isBreakdownKnown: true, // خلاص مبقاش في غموض
        midterm1Total: int.tryParse(_midterm1Controller.text),
        midterm2Total: int.tryParse(_midterm2Controller.text),
        courseworkTotal: int.tryParse(_courseworkController.text),
      );

      // بنبعت المادة للكيوبت عشان يحفظها
      context.read<SubjectDetailsCubit>().updateSubject(updatedSubject);
      Navigator.pop(context); // نقفل الـ Bottom Sheet
    }
  }

  @override
  Widget build(BuildContext context) {
    final remaining = missingMarks - currentSum;
    final isSumValid =
        remaining == 0; // الزرار مش هيشتغل غير لو وزع الدرجات كلها صح

    return Padding(
      // Padding عشان الكيبورد لما تفتح متغطيش على المحتوى
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24.w,
        right: 24.w,
        top: 24.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "تقسيمة أعمال السنة",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: widget.subjectColor,
                ),
              ),
              // كارت صغير بيعرض الدرجات المتبقية
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isSumValid
                      ? AppColors.success.withOpacity(0.1)
                      : AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  isSumValid ? "مضبوط 🎯" : "متبقي: $remaining",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: isSumValid ? AppColors.success : AppColors.error,
                  ),
                ),
              ),
            ],
          ),
          verticalSpace(8),
          Text(
            "عندك $missingMarks درجة محتاجين نوزعهم، لو في حاجة ملغية سيبها فاضية.",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
          ),
          verticalSpace(24),

          // الحقول
          CustomTextFormField(
            controller: _midterm1Controller,
            hintText: "ميدتيرم 1 (مثال: 30)",
            keyboardType: TextInputType.number,
          ),
          verticalSpace(16),
          CustomTextFormField(
            controller: _midterm2Controller,
            hintText: "ميدتيرم 2 / عملي (مثال: 20)",
            keyboardType: TextInputType.number,
          ),
          verticalSpace(16),
          CustomTextFormField(
            controller: _courseworkController,
            hintText: "كويزات وحضور (مثال: 10)",
            keyboardType: TextInputType.number,
          ),
          verticalSpace(32),

          // زرار الحفظ
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: isSumValid ? _submit : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.subjectColor,
                disabledBackgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                "حفظ التقسيمة",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          verticalSpace(24),
        ],
      ),
    );
  }
}
