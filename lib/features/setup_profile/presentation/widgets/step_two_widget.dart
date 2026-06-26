import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/core/widgets/custom_text_field.dart';

class StepTwoWidget extends StatelessWidget {
  final TextEditingController totalHoursController;
  final TextEditingController completedHoursController;
  final TextEditingController gpaController;
  final double selectedScale;
  final ValueChanged<double> onScaleChanged;

  const StepTwoWidget({
    super.key,
    required this.totalHoursController,
    required this.completedHoursController,
    required this.gpaController,
    required this.selectedScale,
    required this.onScaleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          //
          Text(
            "نظام الساعات والمعدل",
            style: TextStyle(fontSize: 22.sp, fontWeight: .bold),
          ),
          //
          verticalSpace(8),
          //
          Text(
            "أرقامك هي سلاحك للسيطرة على معدلك التراكمي",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700),
          ),
          //
          verticalSpace(32),
          //
          Row(
            crossAxisAlignment: .start,
            children: [
              //
              Expanded(
                child: CustomTextFormField(
                  controller: totalHoursController,
                  hintText: "الساعات الكلية",
                  fieldType: .number,
                  prefixIcon: CupertinoIcons.time_solid,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) return "مطلوب";
                    if (double.tryParse(val) == null ||
                        double.parse(val) <= 0) {
                      return "رقم غير صالح";
                    }
                    return null;
                  },
                ),
              ),
              //
              horizontalSpace(16),
              //
              Expanded(
                child: CustomTextFormField(
                  controller: completedHoursController,
                  hintText: "الساعات المنجزة",
                  fieldType: .number,
                  prefixIcon: CupertinoIcons.check_mark_circled_solid,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) return "مطلوب";
                    double? completed = double.tryParse(val);
                    double? total = double.tryParse(totalHoursController.text);
                    if (completed == null || completed < 0) {
                      return "رقم غير صالح";
                    }
                    if (total != null && completed > total) {
                      return "أكبر من الكلية!";
                    }
                    return null;
                  },
                ),
              ),
              //
            ],
          ),
          //
          verticalSpace(16),
          //
          CustomTextFormField(
            controller: gpaController,
            hintText: "المعدل التراكمي الحالي (GPA)",
            fieldType: FieldType.number,
            prefixIcon: CupertinoIcons.graph_square_fill,
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return "برجاء إدخال المعدل";
              }
              double? gpa = double.tryParse(val);
              if (gpa == null || gpa < 0) return "معدل غير صالح";
              if (gpa > selectedScale) {
                return "المعدل يجب ألا يتخطى $selectedScale";
              }
              return null;
            },
          ),
          //
          verticalSpace(24),
          //
          Text(
            "نظام تقييم الجامعة (GPA Scale)",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          //
          verticalSpace(12),
          //
          Row(
            children: [
              _buildScaleOption(4.0, "نظام 4.0"),
              //
              horizontalSpace(16),
              //
              _buildScaleOption(5.0, "نظام 5.0"),
            ],
          ),
          //
        ],
      ),
    );
  }

  ///
  Widget _buildScaleOption(double scaleValue, String title) {
    final isSelected = selectedScale == scaleValue;
    return Expanded(
      child: GestureDetector(
        onTap: () => onScaleChanged(scaleValue),
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
              fontSize: 14.sp,
              fontWeight: isSelected ? .bold : .normal,
              color: isSelected ? AppColors.primaryColor : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }
}
