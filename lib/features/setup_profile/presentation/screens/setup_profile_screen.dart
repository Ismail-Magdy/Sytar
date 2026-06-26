import 'package:flutter/material.dart';
import 'package:sytar/features/setup_profile/presentation/widgets/setup_profile_body.dart';

class SetupProfileScreen extends StatelessWidget {
  const SetupProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SetupProfileBody(),
    );
  }
}
