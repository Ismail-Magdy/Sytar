import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/core/widgets/custom_text_field.dart';
import 'package:sytar/features/subjects/data/models/subject_model.dart';
import 'package:sytar/features/subjects/manager/subject_details/subject_details_cubit.dart';

class AddGradesBottomSheet extends StatefulWidget {
  final SubjectModel subject;
  final Color subjectColor;

  const AddGradesBottomSheet({
    super.key,
    required this.subject,
    required this.subjectColor,
  });

  @override
  State<AddGradesBottomSheet> createState() => _AddGradesBottomSheetState();
}

class _AddGradesBottomSheetState extends State<AddGradesBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _midterm1Controller;
  late TextEditingController _midterm2Controller;
  late TextEditingController _courseworkController;
  late TextEditingController _finalController;

  @override
  void initState() {
    super.initState();
    // بنجيب الدرجات القديمة لو كان مسجلها قبل كده
    _midterm1Controller = TextEditingController(
      text: widget.subject.obtainedMidterm1?.toString() ?? '',
    );
    _midterm2Controller = TextEditingController(
      text: widget.subject.obtainedMidterm2?.toString() ?? '',
    );
    _courseworkController = TextEditingController(
      text: widget.subject.obtainedCoursework?.toString() ?? '',
    );
    _finalController = TextEditingController(
      text: widget.subject.obtainedFinal?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _midterm1Controller.dispose();
    _midterm2Controller.dispose();
    _courseworkController.dispose();
    _finalController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final updatedSubject = widget.subject.copyWith(
        obtainedMidterm1: _midterm1Controller.text.isNotEmpty
            ? int.tryParse(_midterm1Controller.text)
            : widget.subject.obtainedMidterm1,
        obtainedMidterm2: _midterm2Controller.text.isNotEmpty
            ? int.tryParse(_midterm2Controller.text)
            : widget.subject.obtainedMidterm2,
        obtainedCoursework: _courseworkController.text.isNotEmpty
            ? int.tryParse(_courseworkController.text)
            : widget.subject.obtainedCoursework,
        obtainedFinal: _finalController.text.isNotEmpty
            ? int.tryParse(_finalController.text)
            : widget.subject.obtainedFinal,
      );

      context.read<SubjectDetailsCubit>().updateSubject(updatedSubject);
      Navigator.pop(context);
    }
  }

  // دالة ذكية بتعمل Validation إن الدرجة مش أكبر من النهاية العظمى
  String? _gradeValidator(String? value, int maxMark) {
    if (value != null && value.isNotEmpty) {
      final grade = int.tryParse(value);
      if (grade == null) return "رقم غير صحيح";
      if (grade > maxMark) return "الدرجة لا يمكن أن تتخطى $maxMark";
      if (grade < 0) return "مفيش درجات بالسالب يا هندسة!";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        left: 24.w,
        right: 24.w,
        top: 24.h,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "تسجيل الدرجات 🎯",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: widget.subjectColor,
              ),
            ),
            verticalSpace(8),
            Text(
              "سجل درجاتك اللي جبتها أول بأول عشان نتابع مستواك.",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
            ),
            verticalSpace(24),

            // بنعرض الحقل بس لو المكون ده عليه درجات أصلاً في التقسيمة
            if (widget.subject.midterm1Total != null &&
                widget.subject.midterm1Total! > 0) ...[
              CustomTextFormField(
                controller: _midterm1Controller,
                hintText: "ميدتيرم 1 (من ${widget.subject.midterm1Total})",
                keyboardType: TextInputType.number,
                validator: (val) =>
                    _gradeValidator(val, widget.subject.midterm1Total!),
              ),
              verticalSpace(12),
            ],

            if (widget.subject.midterm2Total != null &&
                widget.subject.midterm2Total! > 0) ...[
              CustomTextFormField(
                controller: _midterm2Controller,
                hintText:
                    "ميدتيرم 2 / عملي (من ${widget.subject.midterm2Total})",
                keyboardType: TextInputType.number,
                validator: (val) =>
                    _gradeValidator(val, widget.subject.midterm2Total!),
              ),
              verticalSpace(12),
            ],

            if (widget.subject.courseworkTotal != null &&
                widget.subject.courseworkTotal! > 0) ...[
              CustomTextFormField(
                controller: _courseworkController,
                hintText: "كويزات وحضور (من ${widget.subject.courseworkTotal})",
                keyboardType: TextInputType.number,
                validator: (val) =>
                    _gradeValidator(val, widget.subject.courseworkTotal!),
              ),
              verticalSpace(12),
            ],

            if (widget.subject.finalExamTotal > 0) ...[
              CustomTextFormField(
                controller: _finalController,
                hintText: "الفاينل (من ${widget.subject.finalExamTotal})",
                keyboardType: TextInputType.number,
                validator: (val) =>
                    _gradeValidator(val, widget.subject.finalExamTotal),
              ),
              verticalSpace(24),
            ],

            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.subjectColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  "حفظ الدرجات",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
