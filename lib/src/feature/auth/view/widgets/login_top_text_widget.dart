import 'package:flutter/material.dart';
import 'package:music_player/src/feature/auth/res/strings.dart';

class LoginTopTextWidget extends StatelessWidget {
  const LoginTopTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 110,
        ),
        Text(
          LoginStrings.welcome,
          style:
              TextStyle(fontSize: 46, fontWeight: FontWeight.w700, height: 1),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          LoginStrings.enterCredential,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "Login",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
