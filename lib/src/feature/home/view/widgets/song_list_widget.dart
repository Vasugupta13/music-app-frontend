import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/src/commons/controller/network_controller.dart';
import 'package:music_player/src/feature/home/controller/home_view_controller.dart';
import 'package:music_player/src/feature/song_play/view/song_play_view.dart';
import 'package:music_player/src/utils/snackbar_service.dart';

class SongListWidget extends ConsumerWidget {
  const SongListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songList =
        ref.watch(homeViewControllerProvider.select((value) => value.songList));
    final connected = ref.watch(connectivityStatusProviders);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "  Songs",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
              ),
            ],
          ),
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: songList!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      if (connected) {
                        context.push(
                          SongPlayView.routePath,
                          extra: {
                            'musicImage': songList[index].musicImage,
                            'title': songList[index].title,
                            'artistName': songList[index].artistName,
                            'musicUrl': songList[index].musicUrl,
                          },
                        );
                      } else {
                        SnackBarService.showSnackBar(
                            context: context,
                            message: "No Internet",
                            duration: const Duration(milliseconds: 600));
                      }
                    },
                    child: Row(
                      children: [
                        Hero(
                          tag: "song${songList[index].title}",
                          child: CachedNetworkImage(
                            imageUrl: songList[index].musicImage,
                            height: 60,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => SizedBox(
                                    height: 60,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                      color: Theme.of(context).primaryColor,
                                    ))),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        //   Image.network(songList[index].musicImage,height: 60,),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              songList[index].title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(songList[index].artistName,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        GestureDetector(
                            onTap: () {
                              ref
                                  .read(homeViewControllerProvider.notifier)
                                  .updateFavourite(
                                      songId: songList[index].songId,
                                      isFavourite:
                                          songList[index].isFavourite == 0
                                              ? 1
                                              : 0);
                            },
                            child: Icon(songList[index].isFavourite == 0
                                ? Icons.favorite_outline_rounded
                                : Icons.favorite))
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
