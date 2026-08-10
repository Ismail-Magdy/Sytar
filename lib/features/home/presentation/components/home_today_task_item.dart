import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';

class HomeTodayTaskItem extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final VoidCallback onTap;

  const HomeTodayTaskItem({
    super.key,
    required this.title,
    this.isCompleted = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: const [
            BoxShadow(
              color: Colors.black87,
              offset: Offset(0, 3), // الظل نازل لتحت شوية
              blurRadius: 0, // مفيش بلور عشان يدي الشكل الحاد
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // الدائرة الفاضية (Checkbox)
            Icon(
              isCompleted ? Icons.check_circle_rounded : Icons.circle_outlined,
              color: isCompleted ? Colors.green : Colors.white,
              size: 24.sp,
            ),
            horizontalSpace(12),
            // اسم التاسك
            Expanded(
              child: Text(
                title,
                textAlign:
                    TextAlign.right, // عشان النص يبقى على اليمين زي الصورة
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: isCompleted ? Colors.grey[500] : Colors.white,
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
