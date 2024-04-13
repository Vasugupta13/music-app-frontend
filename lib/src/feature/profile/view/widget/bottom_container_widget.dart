import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/commons/controller/theme_controller.dart';
import 'package:music_player/src/feature/auth/controller/auth_controller.dart';
import 'package:music_player/src/res/color.dart';

class BottomContainerWidget extends StatelessWidget {
  const BottomContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return FadeInUpBig(
      duration: const Duration(milliseconds: 400),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: height * 0.56,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 5),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Align items on both ends
                    children: [
                      Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: AppColors.kLightGrey,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Center(
                                    child: Icon(Icons.dark_mode_outlined)),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Dark Mode',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Transform.scale(
                        scale: 0.8,
                        child: Consumer(
                          builder: (context, ref, child) {
                            final theme =
                                ref.watch(themeControllerProvider.notifier);
                            return CupertinoSwitch(
                              activeColor: Colors.grey.shade800,
                              value: theme.isDark,
                              onChanged: (bool value) {
                                ref
                                    .read(themeControllerProvider.notifier)
                                    .toggleTheme();
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Align items on both ends
                    children: [
                      Consumer(builder: (context, ref, child) {
                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(authControllerProvider.notifier)
                                .signOut(context: context);
                          },
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.kLightGrey,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: Center(
                                        child: Icon(
                                      Icons.logout_rounded,
                                    )),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Logout',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.redAccent),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
