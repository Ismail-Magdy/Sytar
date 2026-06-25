import "package:flutter/material.dart";
import "package:sytar/core/themes/app_colors.dart";
import "package:sytar/features/auth/login/presentation/widgets/login_body.dart";

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(bottom: false, child: LoginBody()),
    );
  }
}
