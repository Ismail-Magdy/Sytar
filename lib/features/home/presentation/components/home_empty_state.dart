import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:sytar/core/helpers/spacing.dart";
import "package:sytar/core/themes/app_colors.dart";
import "package:sytar/core/widgets/custom_button.dart";
import 'package:intl/intl.dart';

class HomeEmptyState extends StatelessWidget {
  final String userName;

  const HomeEmptyState({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    // Date Format
    String todayDate = DateFormat("EEEE، d MMMM", "ar").format(DateTime.now());

    return Padding(
      padding: .symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: .center,
        children: [
          //
          verticalSpace(15),
          //
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              // Greeting + Date
              Column(
                crossAxisAlignment: .start,
                children: [
                  //
                  Text(
                    "أهلا يا ${userName.split(" ").first}",
                    textAlign: .center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: .w800,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  //
                  Text(
                    todayDate,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: .w500,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  //
                ],
              ),
              //
            ],
          ),
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
          verticalSpace(25),
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
          verticalSpace(40),
          //
          //  Main action button
          CustomButton(text: "إضافة أول مادة", onPressed: () {}),
          //
          const Spacer(),
          //
          Row(
            mainAxisAlignment: .center,
            children: [
              //
              Icon(
                Icons.lightbulb_outline_rounded,
                color: AppColors.secondaryColor,
                size: 16.sp,
              ),
              //
              horizontalSpace(5),
              //
              Text(
                "نصيحة: السيطرة بتبدأ بتنظيم وقتك",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[700],
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
