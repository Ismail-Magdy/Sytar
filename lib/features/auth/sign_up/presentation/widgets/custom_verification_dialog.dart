import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sytar/core/helpers/extensions.dart';
import 'package:sytar/core/helpers/spacing.dart';
import 'package:sytar/core/routes/routes.dart';
import 'package:sytar/core/themes/app_colors.dart';
import 'package:sytar/core/widgets/custom_button.dart';

class CustomVerificationDialog extends StatelessWidget {
  const CustomVerificationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: .symmetric(horizontal: 24.w),
        padding: .all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: .circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: .min,
            children: [
              Container(
                padding: .all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  shape: .circle,
                ),
                child: Icon(
                  Icons.mark_email_unread_rounded,
                  color: AppColors.primaryColor,
                  size: 50.sp,
                ),
              ),
              verticalSpace(20),
              Text(
                "تحقق من بريدك الإلكتروني",
                textAlign: .center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: .bold,
                  color: AppColors.primaryColor,
                ),
              ),
              verticalSpace(12),
              Text(
                "تم إرسال رابط التفعيل بنجاح.\nيرجى التحقق من صندوق الوارد (أو الـ Spam) لتفعيل حسابك قبل تسجيل الدخول.",
                textAlign: .center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),
              verticalSpace(30),
              CustomButton(
                text: "الذهاب لتسجيل الدخول",
                onPressed: () {
                  Navigator.of(context).pop();
                  context.pushReplacementNamed(Routes.loginScreen);
                },
                borderRadius: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
