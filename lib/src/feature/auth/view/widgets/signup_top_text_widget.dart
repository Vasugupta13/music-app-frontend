import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/src/feature/auth/res/strings.dart';

class SignUpTopTextWidget extends StatelessWidget {
  const SignUpTopTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.12,
        ),
        GestureDetector(
            onTap: () {
              context.pop();
            },
            child: const Icon(
              CupertinoIcons.back,
              size: 30,
            )),
        SizedBox(
          height: height * 0.02,
        ),
        const Text(
          "Sign Up",
          style:
              TextStyle(fontSize: 46, fontWeight: FontWeight.w700, height: 1),
        ),
        SizedBox(
          height: height * 0.03,
        ),
        const Text(
          SignUpStrings.register,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: height * 0.03,
        ),
      ],
    );
  }
}
