import 'package:flutter/material.dart';
import 'package:music_player/src/feature/profile/view/widget/bottom_container_widget.dart';
import 'package:music_player/src/feature/profile/view/widget/profile_picture_widget.dart';
import 'package:music_player/src/feature/profile/view/widget/profile_top_bar_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  static const routePath = "/profile";

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: Stack(
        children: [
          ProfilePicWidget(),
          BottomContainerWidget(),
          ProfileTopBarWidget()
        ],
      ),
    );
  }
}
