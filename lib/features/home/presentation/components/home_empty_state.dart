import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:sytar/core/helpers/spacing.dart";
import "package:sytar/core/themes/app_colors.dart";
import "package:sytar/core/widgets/custom_button.dart";

class HomeEmptyState extends StatelessWidget {
  final String userName;

  const HomeEmptyState({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: .center,
        children: [
          //
          verticalSpace(70),
          //
          // Image wrapped
          Image.asset(
            "assets/images/empty_home.png",
            height: 240.h,
            fit: .contain,
          ),
          //
          verticalSpace(30),
          //
          // Subtitle
          Text(
            "الترم بيبدأ من هنا، جاهز تسيطر؟\nضيف أول مادة ليك دلوقتي عشان نبدأ نظبطلك الـ GPA والمهام بتاعتك",
            textAlign: .center,
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.grey[700],
              height: 1.6,
              fontWeight: .w500,
            ),
          ),
          //
          verticalSpace(50),
          //
          //  Main action button
          CustomButton(text: "إضافة أول مادة", onPressed: () {}),
          //
          verticalSpace(50),
          //
          Row(
            mainAxisAlignment: .center,
            children: [
              //
              Icon(
                Icons.lightbulb_outline_rounded,
                color: AppColors.secondaryColor,
                size: 15.sp,
              ),
              //
              horizontalSpace(4),
              //
              Text(
                "نصيحة: السيطرة بتبدأ بتنظيم وقتك",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.secondaryColor,
                  fontWeight: .w500,
                ),
              ),
              //
            ],
          ),
          //
        ],
      ),
    );
  }
}
