import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/di/dependency_injection.dart';
import 'package:sytar/core/helpers/extensions.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/routes/routes.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/core/widgets/custom_button.dart';
import 'package:sytar/features/home/manager/home_cubit.dart';
import 'package:sytar/features/subjects/manager/subjects/subjects_cubit.dart';

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
            fit: BoxFit.contain,
          ),
          //
          verticalSpace(30),
          //
          // Subtitle
          Text(
            "الترم بيبدأ من هنا، جاهز تسيطر؟\nضيف أول مادة ليك دلوقتي عشان نبدأ نظبطلك الـ GPA والمهام بتاعتك",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.grey[700],
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
          //
          verticalSpace(50),
          //
          //  Main action button
          CustomButton(
            text: "إضافة أول مادة",
            onPressed: () async {
              final result = await context.pushNamed(Routes.addSubjectScreen);

              if (result == true) {
                if (context.mounted) {
                  context.read<HomeCubit>().getDashboardData();
                  getIt<SubjectsCubit>().fetchCurrentSemesterSubjects();
                }
              }
            },
          ),
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
