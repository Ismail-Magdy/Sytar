import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:sytar/core/helpers/extensions.dart";
import "package:sytar/core/helpers/spacing.dart";
import "package:sytar/core/themes/app_colors.dart";
import "package:sytar/core/widgets/custom_button.dart";
import "package:sytar/core/widgets/custom_text_field.dart";
import "package:sytar/features/auth/welcome/widgets/custom_divider.dart";
import "package:sytar/features/auth/welcome/widgets/social_login_button.dart";

class SignupBody extends StatefulWidget {
  const SignupBody({super.key});

  @override
  State<SignupBody> createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
                    verticalSpace(12),
                    //
                    Text(
                      "انضم لـ سيطر",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: .bold,
                        color: Colors.white,
                      ),
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
                          "إنشاء حساب جديد",
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
                          "خطوة واحدة تفصلك عن تنظيم دراستك بذكاء",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        //
                        verticalSpace(32),
                        //
                        // حقل اسم المستخدم
                        CustomTextFormField(
                          controller: _userNameController,
                          hintText: "اسم المستخدم",
                          fieldType: .userName,
                          prefixIcon: Icons.person_outline_rounded,
                        ),
                        //
                        verticalSpace(16),
                        //
                        // حقل الإيميل
                        CustomTextFormField(
                          controller: _emailController,
                          hintText: "البريد الإلكتروني",
                          fieldType: .email,
                          prefixIcon: Icons.alternate_email_rounded,
                        ),
                        //
                        verticalSpace(16),
                        //
                        // حقل الباسورد
                        CustomTextFormField(
                          controller: _passwordController,
                          hintText: "كلمة المرور",
                          fieldType: .password,
                          prefixIcon: Icons.lock_outline_rounded,
                        ),
                        //
                        verticalSpace(32),
                        //
                        // زرار إنشاء حساب
                        CustomButton(
                          text: "إنشاء حساب",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              //TODO:  هنهندل اللوجيك هنا في مرحلة الـ Bloc/Cubit
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
                        //
                        // زرار العودة لتسجيل الدخول
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Row(
                            mainAxisAlignment: .center,
                            children: [
                              Text(
                                "لديك حساب بالفعل؟",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                " تسجيل الدخول",
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
