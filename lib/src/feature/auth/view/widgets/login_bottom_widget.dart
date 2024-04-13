import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/src/feature/auth/res/strings.dart';
import 'package:music_player/src/feature/auth/view/sign_up_view.dart';
import 'package:music_player/src/res/color.dart';

class LoginBottomTextWidget extends StatelessWidget {
  const LoginBottomTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: AppColors.kBlack,
          thickness: 1.4,
        ),
        const SizedBox(
          height: 10,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LoginStrings.dontHaveAccount,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                context.push(
                  SignUpView.routePath,
                );
              },
              child: Text(
                "Sign Up",
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
