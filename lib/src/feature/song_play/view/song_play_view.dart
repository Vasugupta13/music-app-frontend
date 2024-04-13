import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/src/feature/song_play/controller/song_play_controller.dart';
import 'package:music_player/src/feature/song_play/view/widget/song_play_button.dart';
import 'package:music_player/src/feature/song_play/view/widget/song_play_image_title_widget.dart';
import 'package:music_player/src/feature/song_play/view/widget/song_play_slider_widget.dart';
import 'package:music_player/src/feature/song_play/view/widget/song_play_top_widget.dart';

class SongPlayView extends ConsumerStatefulWidget {
  final String musicImage;
  final String title;
  final String artistName;
  final String musicUrl;
  const SongPlayView(
      {super.key,
      required this.musicImage,
      required this.title,
      required this.artistName,
      required this.musicUrl});
  static const routePath = "/songPlay";

  @override
  ConsumerState<SongPlayView> createState() => _SongPlayViewState();
}

class _SongPlayViewState extends ConsumerState<SongPlayView> {
  bool canPop = true;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(songPlayerController.notifier).initPlayer(widget.musicUrl);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (canPopScope) async {
        if (canPopScope) {
          return;
        } else {
          ref.read(songPlayerController.notifier).stop();
          context.pop();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            const SongPlayTopWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SongPlayImageTitleWidget(
                    title: widget.title,
                    musicImage: widget.musicImage,
                    artistName: widget.artistName,
                  ),
                  const SongPlaySliderWidget(),
                  const SongPlayButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
