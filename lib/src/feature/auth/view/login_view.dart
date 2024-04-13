import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/commons/views/widgets/reusable_button_widget.dart';
import 'package:music_player/src/feature/auth/controller/auth_controller.dart';
import 'package:music_player/src/feature/auth/view/widgets/login_bottom_widget.dart';
import 'package:music_player/src/feature/auth/view/widgets/login_fields_widget.dart';
import 'package:music_player/src/feature/auth/view/widgets/login_top_text_widget.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});
  static const routePath = "/login";

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(authControllerProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LoginTopTextWidget(),
              LoginFieldsWidget(
                  emailController: emailController,
                  passwordController: passwordController),
              !loading
                  ? ReusableButton(
                      onPressed: () {
                        ref.read(authControllerProvider.notifier).login(
                            email: emailController.text,
                            password: passwordController.text,
                            context: context);
                      },
                      borderRadius: 40,
                      vertical: 10,
                      text: "Login",
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ],
                    ),
              const LoginBottomTextWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
