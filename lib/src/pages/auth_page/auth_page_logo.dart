import 'package:flutter/material.dart';

class AuthPageLogo extends StatelessWidget {
  const AuthPageLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Image(
      gaplessPlayback: true,
      image: AssetImage("assets/images/logo.png"),
      height: 280,
    ));
  }
}
