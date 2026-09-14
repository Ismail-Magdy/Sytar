import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/core/widgets/custom_text_field.dart';
import 'package:sytar/features/subjects/data/models/subject_model.dart';
import 'package:sytar/features/subject_details/manager/subject_details_cubit.dart';

/// For توزيع الدرجات
class UpdateBreakdownBottomSheet extends StatefulWidget {
  final SubjectModel subject;

  const UpdateBreakdownBottomSheet({super.key, required this.subject});

  @override
  State<UpdateBreakdownBottomSheet> createState() =>
      _UpdateBreakdownBottomSheetState();
}

class _UpdateBreakdownBottomSheetState
    extends State<UpdateBreakdownBottomSheet> {
  late TextEditingController _finalController;
  late TextEditingController _midterm1Controller;
  late TextEditingController _midterm2Controller;
  late TextEditingController _courseworkController;

  late int totalRequiredMarks;
  int currentSum = 0;

  @override
  void initState() {
    super.initState();
    // إحنا محتاجين نوزع الدرجة الكلية كلها
    totalRequiredMarks = widget.subject.totalMarks;

    // بنجيب القيم القديمة لو موجودة عشان اليوزر ميضطرش يكتبها من الأول
    _finalController = TextEditingController(
      text: widget.subject.finalExamTotal > 0
          ? widget.subject.finalExamTotal.toString()
          : '',
    );
    _midterm1Controller = TextEditingController(
      text:
          widget.subject.midterm1Total != null &&
              widget.subject.midterm1Total! > 0
          ? widget.subject.midterm1Total.toString()
          : '',
    );
    _midterm2Controller = TextEditingController(
      text:
          widget.subject.midterm2Total != null &&
              widget.subject.midterm2Total! > 0
          ? widget.subject.midterm2Total.toString()
          : '',
    );
    _courseworkController = TextEditingController(
      text:
          widget.subject.courseworkTotal != null &&
              widget.subject.courseworkTotal! > 0
          ? widget.subject.courseworkTotal.toString()
          : '',
    );

    // بنراقب الحقول عشان نحسب المجموع لايف
    _finalController.addListener(_calculateSum);
    _midterm1Controller.addListener(_calculateSum);
    _midterm2Controller.addListener(_calculateSum);
    _courseworkController.addListener(_calculateSum);

    _calculateSum(); // نحسب المجموع المبدئي
  }

  void _calculateSum() {
    final f = int.tryParse(_finalController.text) ?? 0;
    final m1 = int.tryParse(_midterm1Controller.text) ?? 0;
    final m2 = int.tryParse(_midterm2Controller.text) ?? 0;
    final cw = int.tryParse(_courseworkController.text) ?? 0;

    setState(() {
      currentSum = f + m1 + m2 + cw;
    });
  }

  @override
  void dispose() {
    _finalController.dispose();
    _midterm1Controller.dispose();
    _midterm2Controller.dispose();
    _courseworkController.dispose();
    super.dispose();
  }

  void _submit() {
    // الزرار مش هيشتغل غير لو المجموع = الدرجة الكلية
    if (currentSum == totalRequiredMarks) {
      final updatedSubject = widget.subject.copyWith(
        isBreakdownKnown: true,
        finalExamTotal: int.tryParse(_finalController.text) ?? 0,
        midterm1Total: int.tryParse(_midterm1Controller.text) ?? 0,
        midterm2Total: int.tryParse(_midterm2Controller.text) ?? 0,
        courseworkTotal: int.tryParse(_courseworkController.text) ?? 0,
      );

      context.read<SubjectDetailsCubit>().updateSubject(updatedSubject);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final remaining = totalRequiredMarks - currentSum;
    final isSumValid = remaining == 0;

    return Padding(
      padding: .only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        left: 24.w,
        right: 24.w,
        top: 24.h,
      ),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              //
              Text(
                "توزيع الدرجات",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: .bold,
                  color: AppColors.primaryColor,
                ),
              ),
              //
              Container(
                padding: .symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isSumValid
                      ? AppColors.success.withValues(alpha: 0.1)
                      : AppColors.error.withValues(alpha: 0.1),
                  borderRadius: .circular(15.r),
                ),
                child: Text(
                  isSumValid ? "مضبوط" : "متبقي: $remaining",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: .bold,
                    color: isSumValid ? AppColors.success : AppColors.error,
                  ),
                ),
              ),
              //
            ],
          ),
          //
          verticalSpace(8),
          //
          Text(
            "عندك $totalRequiredMarks درجة محتاجين نوزعهم، لو في حاجة ملغية سيبها فاضية",
            style: TextStyle(fontSize: 14.sp, color: AppColors.darkGrey),
          ),
          //
          verticalSpace(24),
          //
          CustomTextFormField(
            controller: _finalController,
            hintText: "الفاينل (مثال: 40)",
            keyboardType: .number,
          ),
          verticalSpace(16),
          CustomTextFormField(
            controller: _midterm1Controller,
            hintText: "ميدتيرم أول (مثال: 30)",
            keyboardType: .number,
          ),
          verticalSpace(16),
          CustomTextFormField(
            controller: _midterm2Controller,
            hintText: "ميدتيرم تاني أو عملي (مثال: 20)",
            keyboardType: .number,
          ),
          verticalSpace(16),
          CustomTextFormField(
            controller: _courseworkController,
            hintText: "كويزات وحضور (مثال: 10)",
            keyboardType: .number,
          ),
          verticalSpace(32),
          //
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: isSumValid ? _submit : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                disabledBackgroundColor: AppColors.grey.withValues(alpha: 0.4),
                shape: RoundedRectangleBorder(borderRadius: .circular(12.r)),
              ),
              child: Text(
                "حفظ التقسيمة",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: .bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
