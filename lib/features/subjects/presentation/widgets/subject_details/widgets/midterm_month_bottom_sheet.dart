import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/extensions.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/features/subjects/data/models/subject_model.dart';
import 'package:sytar/features/subjects/manager/subject_details/subject_details_cubit.dart';

class MidtermMonthBottomSheet extends StatefulWidget {
  final SubjectModel subject;

  const MidtermMonthBottomSheet({super.key, required this.subject});

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
      context.pop();
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
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          //
          Text(
            "تحديد شهر الميدتيرم",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: .bold,
              color: AppColors.secondaryColor,
            ),
          ),
          //
          verticalSpace(8),
          //
          Text(
            "إختار الشهر التقريبي للميدتيرم عشان الأبلكيشن يقدر يبعتلك تنبيه تفوق بيه للمادة",
            style: TextStyle(fontSize: 14.sp, color: AppColors.darkGrey),
          ),
          //
          verticalSpace(24),
          //
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
                selectedColor: AppColors.primaryColor,
                checkmarkColor: AppColors.white,
                labelStyle: TextStyle(
                  color: isSelected ? AppColors.white : AppColors.black,
                  fontWeight: isSelected ? .bold : .normal,
                ),
                backgroundColor: AppColors.grey.withValues(alpha: 0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: .circular(12.r),
                  side: BorderSide(
                    color: isSelected
                        ? AppColors.primaryColor
                        : Colors.transparent,
                  ),
                ),
              );
            }),
          ),
          //
          verticalSpace(32),
          //
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: selectedMonth != null ? _submit : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
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
