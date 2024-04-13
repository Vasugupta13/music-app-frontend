import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/src/feature/song_play/controller/song_play_controller.dart';

class SongPlayTopWidget extends ConsumerWidget {
  const SongPlayTopWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () async {
                  ref.read(songPlayerController.notifier).stop();
                  context.pop();
                },
                icon: const Icon(
                  CupertinoIcons.back,
                  size: 25,
                )),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
