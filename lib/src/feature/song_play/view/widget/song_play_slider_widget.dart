import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/feature/song_play/controller/song_play_controller.dart';
import 'package:music_player/src/feature/song_play/res/helper.dart';

class SongPlaySliderWidget extends StatelessWidget {
  const SongPlaySliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final duration =
            ref.watch(songPlayerController.select((value) => value.duration));
        final position =
            ref.watch(songPlayerController.select((value) => value.position));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 4,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 4),
              ),
              child: Slider(
                activeColor: Theme.of(context).primaryColor,
                inactiveColor: Colors.grey.shade500,
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value) async {
                  final position = Duration(seconds: value.toInt());
                  ref.read(songPlayerController.notifier).seek(position);
                  ref.read(songPlayerController.notifier).resume();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    SongPlayHelper.formatSongTime(position),
                    style: const TextStyle(fontSize: 13),
                  ),
                  Text(
                    SongPlayHelper.formatSongTime(duration - position),
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
