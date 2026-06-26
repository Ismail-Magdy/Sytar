import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/core/widgets/custom_text_field.dart';

class StepOneWidget extends StatelessWidget {
  final TextEditingController uniController;
  final TextEditingController facultyController;
  final TextEditingController deptController;
  final TextEditingController levelController;
  final TextEditingController semesterController;
  final int studyYears;
  final ValueChanged<int> onStudyYearsChanged;

  const StepOneWidget({
    super.key,
    required this.uniController,
    required this.facultyController,
    required this.deptController,
    required this.levelController,
    required this.studyYears,
    required this.onStudyYearsChanged,
    required this.semesterController,
  });

  @override
  Widget build(BuildContext context) {
    // Levels
    final List<String> levels = studyYears == 5
        ? [
            "إعدادي",
            "المستوى الأول",
            "المستوى الثاني",
            "المستوى الثالث",
            "المستوى الرابع",
          ]
        : [
            "المستوى الأول",
            "المستوى الثاني",
            "المستوى الثالث",
            "المستوى الرابع",
          ];

    if (studyYears == 4 && levelController.text == "إعدادي") {
      levelController.clear();
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          //
          Text(
            "هويتك الأكاديمية",
            style: TextStyle(fontSize: 22.sp, fontWeight: .bold),
          ),
          //
          verticalSpace(8),
          //
          Text(
            "خلينا نتعرف على كليتك عشان نضبط الأبلكيشن على مقاسك",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700),
          ),
          //
          verticalSpace(32),
          //
          CustomTextFormField(
            controller: uniController,
            hintText: "الجامعة (مثال: القاهرة)",
            fieldType: .normal,
            prefixIcon: Icons.account_balance,
            validator: (val) => val == null || val.trim().isEmpty
                ? "برجاء إدخال اسم الجامعة"
                : null,
          ),
          //
          verticalSpace(16),
          //
          CustomTextFormField(
            controller: facultyController,
            hintText: "الكلية (مثال: هندسة)",
            fieldType: .normal,
            prefixIcon: Icons.corporate_fare,
            validator: (val) => val == null || val.trim().isEmpty
                ? "برجاء إدخال اسم الكلية"
                : null,
          ),
          //
          verticalSpace(16),
          //
          CustomTextFormField(
            controller: deptController,
            hintText: "القسم (مثال: ميكاترونكس)",
            fieldType: .normal,
            prefixIcon: Icons.account_tree,
            validator: (val) => val == null || val.trim().isEmpty
                ? "برجاء إدخال اسم القسم"
                : null,
          ),
          //
          verticalSpace(24),
          //
          Text(
            "عدد سنوات الدراسة",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: .bold,
              color: Colors.black87,
            ),
          ),
          //
          verticalSpace(12),
          //
          Row(
            children: [
              _buildYearOption(4, "4 سنوات"),
              //
              horizontalSpace(16),
              //
              _buildYearOption(5, "5 سنوات (إعدادي)"),
            ],
          ),
          //
          verticalSpace(24),
          //
          Text(
            "المستوى الحالي",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: .bold,
              color: Colors.black87,
            ),
          ),
          //
          verticalSpace(12),
          //
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: levels.map((level) {
              final isSelected = levelController.text == level;
              return GestureDetector(
                onTap: () {
                  levelController.text = isSelected ? "" : level;
                  onStudyYearsChanged(studyYears);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: .symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryColor : Colors.white,
                    borderRadius: .circular(20.r),
                    border: .all(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    level,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: isSelected ? .bold : .w500,
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          //
          verticalSpace(24),
          //
          Text(
            "الترم الحالي",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: .bold,
              color: Colors.black87,
            ),
          ),
          //
          verticalSpace(12),
          //
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: ["الترم الأول", "الترم الثاني", "الترم الصيفي"].map((
              term,
            ) {
              final isSelected = semesterController.text == term;
              return GestureDetector(
                onTap: () {
                  semesterController.text = isSelected ? "" : term;
                  onStudyYearsChanged(studyYears);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: .symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryColor : Colors.white,
                    borderRadius: .circular(20.r),
                    border: .all(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    term,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: isSelected ? .bold : .w500,
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          //
          verticalSpace(16),

          //
        ],
      ),
    );
  }

  ///
  Widget _buildYearOption(int years, String title) {
    final isSelected = studyYears == years;
    return Expanded(
      child: GestureDetector(
        onTap: () => onStudyYearsChanged(years),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: .symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryColor.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: .circular(12.r),
            border: .all(
              color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
          ),
          alignment: .center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: isSelected ? .bold : .normal,
              color: isSelected ? AppColors.primaryColor : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }
}
