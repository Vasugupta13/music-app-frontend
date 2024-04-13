import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/feature/song_play/controller/song_play_controller.dart';

class SongPlayButton extends ConsumerWidget {
  const SongPlayButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final isPlaying =
            ref.watch(songPlayerController.select((value) => value.isPlaying));
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: 40,
              child: Center(
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 40,
                  ),
                  onPressed: () async {
                    if (isPlaying) {
                      ref.read(songPlayerController.notifier).pause();
                    } else {
                      ref.read(songPlayerController.notifier).resume();
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
