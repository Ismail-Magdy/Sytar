import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
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
