import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/features/subjects/data/models/subject_model.dart';
import 'package:sytar/features/subjects/manager/subject_details/subject_details_cubit.dart';

class MidtermMonthBottomSheet extends StatefulWidget {
  final SubjectModel subject;
  final Color subjectColor;

  const MidtermMonthBottomSheet({
    super.key,
    required this.subject,
    required this.subjectColor,
  });

  @override
  State<MidtermMonthBottomSheet> createState() =>
      _MidtermMonthBottomSheetState();
}

class _MidtermMonthBottomSheetState extends State<MidtermMonthBottomSheet> {
  int? selectedMonth;

  final List<String> months = [
    "يناير",
    "فبراير",
    "مارس",
    "أبريل",
    "مايو",
    "يونيو",
    "يوليو",
    "أغسطس",
    "سبتمبر",
    "أكتوبر",
    "نوفمبر",
    "ديسمبر",
  ];

  void _submit() {
    if (selectedMonth != null) {
      final updatedSubject = widget.subject.copyWith(
        midtermMonth: selectedMonth,
      );

      context.read<SubjectDetailsCubit>().updateSubject(updatedSubject);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 24.h,
      ).copyWith(bottom: MediaQuery.of(context).viewInsets.bottom + 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "تحديد شهر الميدتيرم 🗓️",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: widget.subjectColor,
            ),
          ),
          verticalSpace(8),
          Text(
            "اختار الشهر التقريبي للميدتيرم عشان الأبلكيشن يقدر يبعتلك تنبيه ذكي تفوق بيه للمادة.",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
          ),
          verticalSpace(24),
          Wrap(
            spacing: 10.w,
            runSpacing: 12.h,
            children: List.generate(12, (index) {
              final monthNumber = index + 1;
              final isSelected = selectedMonth == monthNumber;

              return ChoiceChip(
                label: Text(months[index]),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() => selectedMonth = monthNumber);
                },
                selectedColor: widget.subjectColor,
                labelStyle: TextStyle(
                  color: isSelected ? AppColors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                backgroundColor: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(
                    color: isSelected
                        ? widget.subjectColor
                        : Colors.transparent,
                  ),
                ),
              );
            }),
          ),
          verticalSpace(32),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: selectedMonth != null ? _submit : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.subjectColor,
                disabledBackgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                "حفظ وتفعيل التنبيه",
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
    );
  }
}
