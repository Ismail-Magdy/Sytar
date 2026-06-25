import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:sytar/core/helpers/extensions.dart";
import "package:sytar/core/helpers/spacing.dart";
import "package:sytar/core/routes/routes.dart";
import "package:sytar/core/themes/app_colors.dart";
import "package:sytar/core/widgets/custom_button.dart";

class WelcomeAuthBody extends StatelessWidget {
  const WelcomeAuthBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(flex: 2),

          // اللوجو في النص
          Center(
            child: SvgPicture.asset(
              "assets/svgs/logo.svg",
              height: 120.h,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),

          verticalSpace(16),

          Center(
            child: Text(
              "سيطر",
              style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),

          const Spacer(flex: 3),

          // زرار تسجيل الدخول (Solid)
          CustomButton(
            text: "تسجيل الدخول",
            onPressed: () {
              context.pushNamed(Routes.loginScreen);
            },
            borderRadius: 14,
          ),

          verticalSpace(16),

          // زرار الاشتراك (Outlined)
          OutlinedButton(
            onPressed: () {
              context.pushNamed(Routes.signupScreen);
            },
            style: OutlinedButton.styleFrom(
              minimumSize: Size(double.infinity, 50.h),
              side: const BorderSide(color: AppColors.primaryColor, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            child: Text(
              "اشتراك",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),

          verticalSpace(32),

          // فاصل "أو"
          Row(
            children: [
              Expanded(
                child: Divider(color: Colors.grey.shade300, thickness: 1),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "أو",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Divider(color: Colors.grey.shade300, thickness: 1),
              ),
            ],
          ),

          verticalSpace(32),

          // زرار جوجل
          _buildSocialLoginButton(
            text: "تسجيل الدخول باستخدام جوجل",
            iconPath: "assets/svgs/google.svg", // محتاج تنزل أيقونة جوجل svg
            onPressed: () {},
          ),

          verticalSpace(16),

          // زرار فيسبوك
          _buildSocialLoginButton(
            text: "تسجيل الدخول باستخدام فيسبوك",
            iconPath:
                "assets/svgs/facebook.svg", // محتاج تنزل أيقونة فيسبوك svg
            onPressed: () {},
          ),

          const Spacer(flex: 1),
        ],
      ),
    );
  }

  // ويدجت زرار السوشيال ميديا
  Widget _buildSocialLoginButton({
    required String text,
    required String iconPath,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 50.h),
        side: BorderSide(color: Colors.grey.shade300, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // لو معندكش الأيقونات SVG دلوقتي، ممكن تبدلها بـ Icon(Icons.facebook) مؤقتاً
          // Icon(Icons.facebook, color: Colors.blue),
          SvgPicture.asset(iconPath, height: 24.h, width: 24.w),
          horizontalSpace(12),
          Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
