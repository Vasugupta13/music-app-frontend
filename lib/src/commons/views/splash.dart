import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/commons/controller/init_controller.dart';
import 'package:music_player/src/commons/providers/common_providers.dart';
import 'package:music_player/src/feature/auth/view/login_view.dart';
import 'package:music_player/src/feature/home/view/home.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/src/res/assets.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  static const routePath = "/splash";

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  final int duration = 500;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: duration * 2)).then((value) {
      ref.read(initControllerProvider).initUserAndToken().then((value) {
        final token = ref.read(authTokenProvider);
        final user = ref.read(currentUserProvider);

        if (token == null || user == null) {
          context.pushReplacement(LoginView.routePath);
        } else {
          context.pushReplacement(HomeView.routePath);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeInUpBig(
          duration: Duration(milliseconds: duration),
          child: Hero(
            tag: "APP_ICON",
            child: Image.asset(
              ImageAssets.logo,height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
