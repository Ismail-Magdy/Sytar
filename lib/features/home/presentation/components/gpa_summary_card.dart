import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/themes/app_colors.dart';

class GpaSummaryCard extends StatelessWidget {
  final double currentGpa;

  const GpaSummaryCard({super.key, required this.currentGpa});

  // دوال تحديد اللون والنص بناءً على الـ GPA
  Color _getGpaColor(double gpa) {
    if (gpa >= 3.5) return AppColors.success; // امتياز
    if (gpa >= 3.0) return AppColors.secondaryColor; // جيد جداً
    if (gpa >= 2.5) return Colors.orange; // جيد/مقبول
    return AppColors.error; // خطر (أحمر)
  }

  String _getGpaMessage(double gpa) {
    if (gpa >= 3.5) return "أداء ممتاز، استمر على القمة!";
    if (gpa >= 3.0) return "مستوى جيد جداً، تقدر تقفلها";
    if (gpa >= 2.5) return "أداء جيد، شد حيلك الفترة الجاية";
    return "محتاج تركز وتشد حيلك أكتر";
  }

  @override
  Widget build(BuildContext context) {
    final double percentage = currentGpa / 4.0;

    // سحب اللون والنص الديناميكي
    final Color gpaColor = _getGpaColor(currentGpa);
    final String gpaMessage = _getGpaMessage(currentGpa);

    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        //
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              //
              Row(
                children: [
                  //
                  Icon(
                    Icons.bar_chart_rounded,
                    color: AppColors.primaryColor,
                    size: 22.sp,
                  ),
                  //
                  horizontalSpace(6),
                  //
                  Text(
                    "المعدل التراكمي",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: .w800,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  //
                ],
              ),
              //
              verticalSpace(12),
              //
              // أنيميشن عداد الأرقام
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: currentGpa),
                duration: const Duration(milliseconds: 1500),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Text(
                    value.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: .w800,
                      color: gpaColor,
                      letterSpacing: 1,
                    ),
                  );
                },
              ),
              //
              verticalSpace(4),
              //
              Text(
                gpaMessage,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: .w600,
                  color: AppColors.darkGrey,
                ),
              ),
              //
            ],
          ),
        ),
        //
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: percentage),
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // الدايرة اللي بتنور (Glow Effect) بنفس لون الـ GPA
                Container(
                  width: 75.w,
                  height: 75.w,
                  decoration: BoxDecoration(
                    shape: .circle,
                    boxShadow: [
                      BoxShadow(
                        color: gpaColor.withValues(alpha: 0.2),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: CircularProgressIndicator(
                    value: value,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(gpaColor),
                    strokeCap: .round,
                  ),
                ),
                //
                // النسبة المئوية جوه الدايرة
                Text(
                  "${(value * 100).toInt()}%",
                  style: TextStyle(
                    fontWeight: .w800,
                    fontSize: 17.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
                //
              ],
            );
          },
        ),
        //
      ],
    );
  }
}
// 151