import 'package:flutter/material.dart';
import 'package:sytar/core/themes/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          children: [Text("HomeScreen", style: TextStyle(fontSize: 50))],
        ),
      ),
    );
  }
}
