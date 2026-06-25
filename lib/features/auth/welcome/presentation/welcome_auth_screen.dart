import "package:flutter/material.dart";
import "package:sytar/features/auth/welcome/widgets/welcome_auth_body.dart";

class WelcomeAuthScreen extends StatelessWidget {
  const WelcomeAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: WelcomeAuthBody()),
    );
  }
}
