import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:sytar/core/helpers/extensions.dart";
import "package:sytar/core/helpers/spacing.dart";
import "package:sytar/core/routes/routes.dart";
import "package:sytar/core/themes/app_colors.dart";
import "package:sytar/core/widgets/custom_button.dart";
import "package:sytar/features/auth/social_auth/manager/ocial_auth_bloc.dart";
import "package:sytar/features/auth/social_auth/manager/social_auth_event.dart";
import "package:sytar/features/auth/welcome/widgets/custom_divider.dart";
import "package:sytar/features/auth/welcome/widgets/social_login_button.dart";

class WelcomeAuthBody extends StatelessWidget {
  const WelcomeAuthBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          //
          const Spacer(flex: 2),
          //
          // Logo
          Stack(
            children: [
              Center(
                child: SvgPicture.asset(
                  "assets/svgs/lines.svg",
                  height: 120.h,
                  colorFilter: const .mode(AppColors.primaryColor, .srcIn),
                ),
              ),
              Center(
                child: SvgPicture.asset(
                  "assets/svgs/logo.svg",
                  height: 120.h,
                  colorFilter: const .mode(AppColors.primaryColor, .srcIn),
                ),
              ),
            ],
          ),
          //
          const Spacer(flex: 3),
          //
          //
          CustomButton(
            text: "تسجيل الدخول",
            onPressed: () {
              context.pushNamed(Routes.loginScreen);
            },
            borderRadius: 14,
          ),
          //
          verticalSpace(16),
          //
          //
          OutlinedButton(
            onPressed: () => context.pushNamed(Routes.signupScreen),
            style: OutlinedButton.styleFrom(
              minimumSize: Size(.infinity, 50.h),
              side: const BorderSide(color: AppColors.primaryColor, width: 1.5),
              shape: RoundedRectangleBorder(borderRadius: .circular(14.r)),
            ),
            child: Text(
              "إشتراك",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          //
          verticalSpace(32),
          //
          // Or
          CustomDivider(),
          //
          verticalSpace(32),
          //
          // Google
          SocialLoginButton(
            text: "تسجيل الدخول باستخدام جوجل",
            iconPath: "assets/svgs/google.svg",
            onPressed: () =>
                context.read<SocialAuthBloc>().add(GoogleSignInRequested()),
          ),
          //
          verticalSpace(16),
          //
          // Facebook
          SocialLoginButton(
            text: "تسجيل الدخول باستخدام فيسبوك",
            iconPath: "assets/svgs/facebook.svg",
            onPressed: () =>
                context.read<SocialAuthBloc>().add(FacebookSignInRequested()),
          ),
          //
          const Spacer(flex: 1),
          //
        ],
      ),
    );
  }
}
// 167