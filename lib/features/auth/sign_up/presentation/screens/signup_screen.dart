import "package:flutter/material.dart";
import "package:sytar/core/themes/app_colors.dart";
import "package:sytar/features/auth/sign_up/presentation/widgets/signup_body.dart";

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(bottom: false, child: SignupBody()),
    );
  }
}
