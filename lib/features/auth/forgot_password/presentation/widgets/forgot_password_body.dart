import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:sytar/core/helpers/extensions.dart";
import "package:sytar/core/helpers/spacing.dart";
import "package:sytar/core/themes/app_colors.dart";
import "package:sytar/core/widgets/custom_button.dart";
import "package:sytar/core/widgets/custom_feedback_dialog.dart";
import "package:sytar/core/widgets/custom_text_field.dart";
import "package:sytar/features/auth/forgot_password/manager/forgot_password_bloc.dart";
import "package:sytar/features/auth/forgot_password/manager/forgot_password_event.dart";
import "package:sytar/features/auth/forgot_password/manager/forgot_password_state.dart";

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
    return Padding(
      padding: .symmetric(horizontal: 15.w, vertical: 15.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: .center,
          children: [
            // Custom App Bar
            Row(
              children: [
                //
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.primaryColor,
                    size: 22.sp,
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
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                //
                horizontalSpace(24),
                //
              ],
            ),
            //
            verticalSpace(40),
            //
            Padding(
              padding: .symmetric(horizontal: 9.w),
              child: Text(
                "أدخل البريد الإلكتروني المرتبط بحسابك وسنرسل لك رابطاً لإعادة تعيين كلمة المرور الخاصة بك",
                textAlign: .center,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
            ),
            //
            verticalSpace(40),
            //
            Padding(
              padding: .symmetric(horizontal: 9.w),
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
            //
            BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
              listener: (context, state) {
                if (state is ForgotPasswordSuccess) {
                  // Sucsses
                  showFeedbackDialog(
                    context,
                    icon: Icons.mark_email_read_rounded,
                    color: Colors.green,
                    title: "تم الإرسال",
                    message:
                        "تم إرسال رابط إعادة تعيين كلمة المرور بنجاح. يرجى مراجعة بريدك الإلكتروني",
                    onFinish: () => context.pop(),
                  );
                  //
                } else if (state is ForgotPasswordFailure) {
                  // Fail
                  showFeedbackDialog(
                    context,
                    icon: Icons.error_outline_rounded,
                    color: Colors.red,
                    title: "عفواً",
                    message: state.errMessage,
                  );
                  //
                }
              },
              builder: (context, state) {
                if (state is ForgotPasswordLoading) {
                  //
                  return Container(
                    height: 50.h,
                    width: .infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.7),
                      borderRadius: .circular(14.r),
                    ),
                    child: const Center(
                      child: CupertinoActivityIndicator(
                        color: Colors.white,
                        radius: 14,
                      ),
                    ),
                  );
                  //
                }
                return Padding(
                  padding: .symmetric(horizontal: 9.w),
                  // Ok Button
                  child: CustomButton(
                    text: "تأكيد",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ForgotPasswordBloc>().add(
                          ResetPasswordRequested(email: _emailController.text),
                        );
                      }
                    },
                    borderRadius: 14,
                  ),
                  //
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
