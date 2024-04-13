import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/src/feature/auth/res/strings.dart';

class SignUpBottomTextWidget extends StatelessWidget {
  const SignUpBottomTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Column(
      children: [
        SizedBox(
          height: height * 0.012,
        ),
        const Divider(
          thickness: 1.4,
        ),
        SizedBox(
          height: height * 0.012,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              SignUpStrings.haveAccount,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(
          height: height * 0.008,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Text(
                "Login",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
