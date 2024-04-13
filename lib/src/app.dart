import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/commons/controller/theme_controller.dart';
import 'package:music_player/src/utils/router.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final theme = ref.watch(themeControllerProvider);
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: theme,
      );
    });
  }
}
