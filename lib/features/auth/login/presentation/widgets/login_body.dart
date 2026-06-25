import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:sytar/core/helpers/extensions.dart";
import "package:sytar/core/helpers/spacing.dart";
import "package:sytar/core/routes/routes.dart";
import "package:sytar/core/themes/app_colors.dart";
import "package:sytar/core/widgets/custom_button.dart";
import "package:sytar/core/widgets/custom_text_field.dart";
import "package:sytar/features/auth/welcome/widgets/custom_divider.dart";
import "package:sytar/features/auth/welcome/widgets/social_login_button.dart";

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              // Top Part
              Container(
                height: 150.h,
                width: .infinity,
                alignment: .center,
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    //
                    Align(
                      alignment: .centerLeft,
                      child: Padding(
                        padding: .only(left: 16.w),
                        child: GestureDetector(
                          onTap: () => context.pop(),
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    //
                    SvgPicture.asset(
                      "assets/svgs/logo.svg",
                      height: 80.h,
                      colorFilter: const .mode(Colors.white, .srcIn),
                    ),
                    //
                    verticalSpace(16),
                    //
                    Text(
                      "مستقبلك بيبدأ من هنا",
                      style: TextStyle(fontSize: 14.sp, color: Colors.white70),
                    ),
                    //
                  ],
                ),
              ),
              //
              // Bottom Part
              Expanded(
                child: Container(
                  width: .infinity,
                  padding: .symmetric(horizontal: 24.w, vertical: 32.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: .only(
                      topLeft: .circular(20.r),
                      topRight: .circular(20.r),
                      bottomLeft: .circular(5.r),
                      bottomRight: .circular(5.r),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: .center,
                      children: [
                        //
                        Text(
                          "تسجيل الدخول",
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: .bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        //
                        verticalSpace(8),
                        //
                        Text(
                          "مرحباً بك مجدداً! جاهز للسيطرة؟",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        //
                        verticalSpace(32),
                        //
                        // Email
                        CustomTextFormField(
                          controller: _emailController,
                          hintText: "البريد الإلكتروني",
                          fieldType: .email,
                          prefixIcon: Icons.alternate_email_rounded,
                        ),
                        //
                        verticalSpace(16),
                        //
                        // Password
                        CustomTextFormField(
                          controller: _passwordController,
                          hintText: "كلمة المرور",
                          fieldType: .password,
                          prefixIcon: Icons.lock_outline_rounded,
                        ),
                        //
                        // Forgot Password
                        Align(
                          alignment: .centerLeft,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "نسيت كلمة المرور؟",
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.primaryColor,
                                fontWeight: .w600,
                              ),
                            ),
                          ),
                        ),
                        //
                        verticalSpace(16),
                        //
                        // Login Button
                        CustomButton(
                          text: "تسجيل الدخول",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // TODO: هنهندل اللوجيك هنا بعدين
                            }
                          },
                        ),
                        //
                        verticalSpace(32),
                        // Or
                        CustomDivider(),
                        //
                        verticalSpace(32),
                        //
                        // Social Buttons
                        SocialLoginButton(
                          text: "تسجيل الدخول بإستخدام جوجل",
                          iconPath: "assets/svgs/google.svg",
                          onPressed: () {},
                        ),
                        //
                        verticalSpace(20),
                        //
                        SocialLoginButton(
                          text: "تسجيل الدخول بإستخدام فيسبوك",
                          iconPath: "assets/svgs/facebook.svg",
                          onPressed: () {},
                        ),
                        //
                        verticalSpace(30),
                        //
                        const Spacer(),
                        // زرار إنشاء حساب جديد
                        GestureDetector(
                          onTap: () => context.pushNamed(Routes.signupScreen),
                          child: Row(
                            mainAxisAlignment: .center,
                            children: [
                              //
                              Text(
                                "مستخدم جديد؟",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              //
                              Text(
                                " إنشاء حساب",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //
                      ],
                    ),
                  ),
                ),
              ),
              //
            ],
          ),
        ),
      ],
    );
  }
}
