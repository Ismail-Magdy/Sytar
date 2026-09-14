import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';

class ExpandableMarkChip extends StatefulWidget {
  final String title;
  final int total;
  final int? obtained;
  final VoidCallback onAddGradeTap;

  const ExpandableMarkChip({
    super.key,
    required this.title,
    required this.total,
    this.obtained,
    required this.onAddGradeTap,
  });

  @override
  State<ExpandableMarkChip> createState() => _ExpandableMarkChipState();
}

class _ExpandableMarkChipState extends State<ExpandableMarkChip> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final bool hasGrade = widget.obtained != null;

    String message = "";
    Color messageColor = AppColors.primaryColor;
    IconData? messageIcon;

    // بنحسب النسبة وبنغير الرسالة واللون بناءً عليها
    if (hasGrade) {
      final percentage = (widget.obtained! / widget.total) * 100;
      if (percentage >= 85) {
        message = "عاش يا بطل\nكمل تقفيل";
        messageColor = AppColors.success;
        messageIcon = Icons.celebration_rounded;
      } else if (percentage >= 65) {
        message = "حلو جداً\nتقدر تجيب أعلى";
        messageColor = AppColors.warning;
        messageIcon = Icons.trending_up_rounded;
      } else {
        message = "عادي جداً\nهنعوض في الباقي";
        messageColor = AppColors.error;
        messageIcon = Icons.sentiment_dissatisfied_rounded;
      }
    }

    return GestureDetector(
      onTap: () {
        if (hasGrade) {
          // لو في درجة، بنفتح ونقفل الرسالة المدلدلة
          setState(() => isExpanded = !isExpanded);
        } else {
          // لو لسه مفيش درجة، بنريحه ونفتحله البوتوم شيت يسجلها
          widget.onAddGradeTap();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        // بنثبت العرض وقت الفتح عشان النص ينزل سطرين بشياكة
        width: isExpanded && hasGrade ? 110.w : null,
        padding: .symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isExpanded
              ? messageColor.withValues(alpha: 0.05)
              : AppColors.secondaryColor.withValues(alpha: 0.05),
          borderRadius: .circular(12.r),
          border: .all(
            color: isExpanded
                ? messageColor.withValues(alpha: 0.3)
                : AppColors.secondaryColor.withValues(alpha: 0.1),
          ),
        ),
        child: Column(
          mainAxisSize: .min,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 12.sp,
                color: isExpanded ? messageColor : AppColors.darkGrey,
                fontWeight: isExpanded ? .bold : .normal,
              ),
            ),
            verticalSpace(4),
            Text(
              hasGrade
                  ? "${widget.obtained} / ${widget.total}"
                  : "${widget.total}",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: .bold,
                color: hasGrade ? AppColors.primaryColor : AppColors.black,
              ),
            ),
            // الجزء "المدلدل" المخفي اللي بيظهر بالأنيميشن
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isExpanded && hasGrade
                  ? Column(
                      children: [
                        verticalSpace(8),
                        Divider(
                          color: messageColor.withValues(alpha: 0.2),
                          height: 1,
                        ),
                        verticalSpace(8),
                        Icon(messageIcon, color: messageColor, size: 22.sp),
                        verticalSpace(4),
                        Text(
                          message,
                          textAlign: .center,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: .bold,
                            color: messageColor,
                            height: 1.4,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
