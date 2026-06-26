import 'package:flutter/material.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          children: [Text("SubjectsScreen", style: TextStyle(fontSize: 50))],
        ),
      ),
    );
  }
}
