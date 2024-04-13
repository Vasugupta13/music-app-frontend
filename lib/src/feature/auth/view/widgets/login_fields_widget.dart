import 'package:flutter/material.dart';
import 'package:music_player/src/commons/views/widgets/text_field_widget.dart';

class LoginFieldsWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginFieldsWidget(
      {super.key,
      required this.emailController,
      required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        TextFieldWidget(
            controller: emailController, text: "Email", isProtected: false),
        const SizedBox(
          height: 20,
        ),
        TextFieldWidget(
            controller: passwordController,
            text: "Password",
            isProtected: true),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
