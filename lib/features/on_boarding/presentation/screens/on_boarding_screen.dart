import "package:flutter/material.dart";
import "package:sytar/features/on_boarding/presentation/widgets/on_boarding_body.dart";

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: OnBoardingBody(),
    );
  }
}
