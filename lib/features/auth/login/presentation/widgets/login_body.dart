import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:sytar/core/helpers/extensions.dart";
import "package:sytar/core/helpers/spacing.dart";
import "package:sytar/core/routes/routes.dart";
import "package:sytar/core/themes/app_colors.dart";
import "package:sytar/core/widgets/custom_button.dart";
import "package:sytar/core/widgets/custom_text_field.dart";

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
              // Logo
              Container(
                height: 220.h,
                width: .infinity,
                alignment: .center,
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    //
                    SvgPicture.asset(
                      "assets/svgs/logo.svg",
                      height: 100.h,
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
                      topLeft: .circular(40.r),
                      topRight: .circular(40.r),
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
                        // حقل الإيميل
                        CustomTextFormField(
                          controller: _emailController,
                          hintText: "البريد الإلكتروني",
                          fieldType: FieldType.email,
                          prefixIcon: Icons.alternate_email_rounded,
                        ),
                        verticalSpace(16),

                        // حقل الباسورد
                        CustomTextFormField(
                          controller: _passwordController,
                          hintText: "كلمة المرور",
                          fieldType: FieldType.password,
                          prefixIcon: Icons.lock_outline_rounded,
                        ),

                        // زرار نسيت كلمة المرور
                        Align(
                          alignment:
                              Alignment.centerLeft, // على الشمال زي الصورة
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "نسيت كلمة المرور؟",
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        verticalSpace(16),

                        // زرار تسجيل الدخول
                        CustomButton(
                          text: "تسجيل الدخول",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // هنهندل اللوجيك هنا بعدين
                            }
                          },
                        ),
                        verticalSpace(24),

                        // أزرار السوشيال ميديا
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildSocialButton(
                              Icons.g_mobiledata_rounded,
                              Colors.red,
                            ),
                            horizontalSpace(16),
                            _buildSocialButton(
                              Icons.apple_rounded,
                              Colors.black,
                            ),
                            horizontalSpace(16),
                            _buildSocialButton(
                              Icons.facebook_rounded,
                              Colors.blue,
                            ),
                          ],
                        ),

                        const Spacer(), // بيزق الرو اللي تحت لآخر الشاشة
                        // زرار إنشاء حساب جديد
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "مستخدم جديد؟",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pushNamed(Routes.signupScreen);
                              },
                              child: Text(
                                "إنشاء حساب",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ويدجت صغيرة لأزرار السوشيال ميديا زي الصورة
  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      height: 50.h,
      width: 50.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: IconButton(
        icon: Icon(icon, color: color, size: 28.sp),
        onPressed: () {},
      ),
    );
  }
}
