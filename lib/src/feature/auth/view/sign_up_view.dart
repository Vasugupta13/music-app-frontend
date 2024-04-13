import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/commons/views/widgets/reusable_button_widget.dart';
import 'package:music_player/src/feature/auth/controller/auth_controller.dart';
import 'package:music_player/src/feature/auth/view/widgets/signup_fields_widget.dart';
import 'package:music_player/src/feature/auth/view/widgets/signup_bottom_text_widget.dart';
import 'package:music_player/src/feature/auth/view/widgets/signup_top_text_widget.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});
  static const routePath = "/signup";

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool loading = ref.watch(authControllerProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SignUpTopTextWidget(),
              SignUpFieldsWidget(
                  emailController: emailController,
                  passwordController: passwordController,
                  nameController: nameController),
              !loading
                  ? ReusableButton(
                      text: "Sign-Up",
                      onPressed: () {
                        ref.read(authControllerProvider.notifier).signUp(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text,
                            context: context);
                      },
                      borderRadius: 40,
                      vertical: 10,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ],
                    ),
              const SignUpBottomTextWidget()
            ],
          ),
        ),
      ),
    );
  }
}
