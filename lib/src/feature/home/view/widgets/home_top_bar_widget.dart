import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/src/feature/profile/view/profile_view.dart';
import 'package:music_player/src/feature/search/view/search_view.dart';
import 'package:music_player/src/res/assets.dart';

class TopBarWidget extends ConsumerWidget {
  const TopBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  context.push(ProfileView.routePath);
                },
                child: const Hero(
                  tag: 'profilePic', // Unique tag for Hero animation
                  child: ClipOval(
                    child: CircleAvatar(
                      foregroundImage: AssetImage(ImageAssets.pfp),
                      radius: 30,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              GestureDetector(
                  onTap: () {
                    context.push(SearchView.routePath);
                  },
                  child: const Icon(CupertinoIcons.search)),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
