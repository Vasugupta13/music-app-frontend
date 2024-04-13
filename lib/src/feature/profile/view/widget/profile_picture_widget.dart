import 'package:flutter/material.dart';
import 'package:music_player/src/res/assets.dart';

class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return ClipRect(
      child: Hero(
          tag: 'profilePic',
          child: Image.asset(
            ImageAssets.pfp,
            height: height * 0.47,
            width: double.maxFinite,
            fit: BoxFit.fill,
          )),
    );
  }
}
