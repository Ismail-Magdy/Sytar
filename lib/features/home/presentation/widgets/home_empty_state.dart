import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:sytar/core/helpers/spacing.dart"; // Adjust path if needed

class HomeEmptyState extends StatelessWidget {
  final String userName;

  const HomeEmptyState({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .stretch,
        children: [
          // Greeting
          Text(
            "عامل إيه يا $userName؟",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          verticalSpace(16),
          // Call to Action text
          Text(
            "الترم بيبدأ من هنا، جاهز تسيطر؟\nضيف موادك دلوقتي عشان نحسبلك الـ GPA",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          verticalSpace(40),
          // Main action button
          ElevatedButton(
            onPressed: () {
              // TODO: Navigate to Add Subject Screen
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              backgroundColor: Colors.blueAccent,
            ),
            child: Text(
              "إضافة مادة",
              style: TextStyle(fontSize: 18.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
