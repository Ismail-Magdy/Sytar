import "package:flutter/material.dart";
import "package:sytar/features/auth/forgot_password/presentation/widgets/forgot_password_body.dart";

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: ForgotPasswordBody()),
    );
  }
}
