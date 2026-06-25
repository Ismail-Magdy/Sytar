import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:sytar/core/helpers/extensions.dart";
import "package:sytar/core/helpers/spacing.dart";
import "package:sytar/core/themes/app_colors.dart";
import "package:sytar/core/widgets/custom_button.dart";
import "package:sytar/core/widgets/custom_text_field.dart";

class ForgotPasswordBody extends StatefulWidget {
  const ForgotPasswordBody({super.key});

  @override
  State<ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: .center,
        children: [
          // Custom App Bar
          Padding(
            padding: .symmetric(horizontal: 16.w, vertical: 15.h),
            child: Row(
              children: [
                //
                Align(
                  alignment: .centerRight,
                  child: GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                //
                Expanded(
                  child: Text(
                    "نسيت كلمة المرور",
                    textAlign: .center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: .bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                //
              ],
            ),
          ),
          //
          verticalSpace(40),
          //
          // الوصف
          Padding(
            padding: .symmetric(horizontal: 24.w),
            child: Text(
              "أدخل البريد الإلكتروني المرتبط بحسابك وسنرسل لك رابطاً لإعادة تعيين كلمة المرور الخاصة بك",
              textAlign: .center,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
          ),
          //
          verticalSpace(40),
          //
          // حقل البريد الإلكتروني
          Padding(
            padding: .symmetric(horizontal: 24.w),
            child: CustomTextFormField(
              controller: _emailController,
              hintText: "البريد الإلكتروني",
              fieldType: .email,
              prefixIcon: Icons.alternate_email_rounded,
            ),
          ),
          //
          verticalSpace(32),
          //
          // زرار التأكيد
          Padding(
            padding: .symmetric(horizontal: 24.w),
            child: CustomButton(
              text: "تأكيد",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO هنا هيتم استدعاء الـ Bloc/Cubit لعمل الـ Password Reset عبر فايربيز
                }
              },
              borderRadius: 14,
            ),
          ),
          //
        ],
      ),
    );
  }
}
