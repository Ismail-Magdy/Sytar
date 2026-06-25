import "package:flutter/material.dart";
import "package:sytar/features/splash/presentation/widgets/splash_body.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.white, body: SplashBody());
  }
}
