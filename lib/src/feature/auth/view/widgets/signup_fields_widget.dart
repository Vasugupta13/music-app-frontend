import 'package:flutter/material.dart';
import 'package:music_player/src/commons/views/widgets/text_field_widget.dart';

class SignUpFieldsWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  const SignUpFieldsWidget(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.nameController});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Column(
      children: [
        TextFieldWidget(
            controller: nameController, text: "Name", isProtected: false),
        SizedBox(
          height: height * 0.02,
        ),
        TextFieldWidget(
            controller: emailController, text: "Email", isProtected: false),
        SizedBox(
          height: height * 0.02,
        ),
        TextFieldWidget(
            controller: passwordController,
            text: "Password",
            isProtected: true),
        SizedBox(
          height: height * 0.03,
        ),
      ],
    );
  }
}
