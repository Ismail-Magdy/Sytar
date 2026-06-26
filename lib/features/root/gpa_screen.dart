import 'package:flutter/material.dart';

class GpaScreen extends StatelessWidget {
  const GpaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          children: [Text("GpaScreen", style: TextStyle(fontSize: 50))],
        ),
      ),
    );
  }
}
