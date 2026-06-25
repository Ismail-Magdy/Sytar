import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:sytar/core/helpers/extensions.dart";
import "package:sytar/core/helpers/spacing.dart";
import "package:sytar/core/themes/app_colors.dart";
import "package:sytar/core/widgets/custom_button.dart";
import "package:sytar/core/widgets/custom_text_field.dart";

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
              // الجزء العلوي (أصغر شوية من الـ Login عشان الفورم أطول)
              Container(
                height: 180.h,
                width: double.infinity,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/svgs/logo.svg",
                      height: 60.h,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    verticalSpace(12),
                    Text(
                      "انضم لـ سيطر",
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // الجزء السفلي (الكونتينر الأبيض اللي فيه الفورم)
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 32.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(40.r),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "إنشاء حساب جديد",
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        verticalSpace(8),
                        Text(
                          "خطوة واحدة تفصلك عن تنظيم دراستك بذكاء.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        verticalSpace(32),

                        // حقل اسم المستخدم
                        CustomTextFormField(
                          controller: _userNameController,
                          hintText: "اسم المستخدم",
                          fieldType: FieldType.userName,
                          prefixIcon: Icons.person_outline_rounded,
                        ),
                        verticalSpace(16),

                        // حقل الإيميل
                        CustomTextFormField(
                          controller: _emailController,
                          hintText: "البريد الإلكتروني",
                          fieldType: FieldType.email,
                          prefixIcon: Icons.alternate_email_rounded,
                        ),
                        verticalSpace(16),

                        // حقل رقم الهاتف
                        CustomTextFormField(
                          controller: _phoneController,
                          hintText: "رقم الهاتف",
                          fieldType: FieldType.phoneNumber,
                          prefixIcon: Icons.phone_outlined,
                        ),
                        verticalSpace(16),

                        // حقل الباسورد
                        CustomTextFormField(
                          controller: _passwordController,
                          hintText: "كلمة المرور",
                          fieldType: FieldType.password,
                          prefixIcon: Icons.lock_outline_rounded,
                        ),
                        verticalSpace(32),

                        // زرار إنشاء حساب
                        CustomButton(
                          text: "إنشاء حساب",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // هنهندل اللوجيك هنا في مرحلة الـ Bloc/Cubit
                            }
                          },
                        ),
                        verticalSpace(24),

                        const Spacer(), // بيزق الرو اللي تحت لآخر الشاشة
                        // زرار العودة لتسجيل الدخول
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "لديك حساب بالفعل؟",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // بنعمل Pop عشان نرجع لـ Login بدل ما نفتح شاشة جديدة فوق القديمة
                                context.pop();
                              },
                              child: Text(
                                "تسجيل الدخول",
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
}
