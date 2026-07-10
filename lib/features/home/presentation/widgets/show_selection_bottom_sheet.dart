import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/extensions.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';

class ShowSelectionBottomSheet extends StatelessWidget {
  const ShowSelectionBottomSheet({
    super.key,
    required this.title,
    required this.options,
    required this.currentSelection,
    required this.onSelect,
  });
  final String title;
  final List<String> options;
  final String currentSelection;
  final Function(String) onSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(vertical: 20.h, horizontal: 20.w),
      child: Column(
        mainAxisSize: .min,
        children: [
          // Drag Handle
          Container(
            width: 40.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: .circular(10.r),
            ),
          ),
          //
          verticalSpace(20),
          //
          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: .bold,
              color: Colors.black87,
            ),
          ),
          //
          verticalSpace(16),
          // Show Options
          ...options.map((option) {
            bool isSelected = option == currentSelection;
            return Container(
              margin: .only(bottom: 8.h),
              child: ListTile(
                onTap: () {
                  onSelect(option);
                  context.pop();
                },
                shape: RoundedRectangleBorder(borderRadius: .circular(12.r)),
                tileColor: isSelected
                    ? AppColors.primaryColor.withValues(alpha: 0.08)
                    : Colors.transparent,
                title: Text(
                  option,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: isSelected ? .bold : .w500,
                    color: isSelected ? AppColors.primaryColor : Colors.black87,
                  ),
                ),
                trailing: isSelected
                    ? Icon(
                        Icons.check_circle_rounded,
                        color: AppColors.primaryColor,
                        size: 22.sp,
                      )
                    : null,
              ),
            );
          }),
        ],
      ),
    );
  }
}
