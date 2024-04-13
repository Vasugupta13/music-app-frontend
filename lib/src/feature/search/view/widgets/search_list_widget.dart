import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/src/commons/controller/network_controller.dart';
import 'package:music_player/src/feature/search/controller/search_controller.dart';
import 'package:music_player/src/feature/song_play/view/song_play_view.dart';
import 'package:music_player/src/utils/snackbar_service.dart';

class SearchListWidget extends ConsumerWidget {
  const SearchListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songList = ref.watch(
        searchControllerProvider.select((value) => value.searchSongList));
    final connected = ref.watch(connectivityStatusProviders);
    return Expanded(
      child: songList.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: songList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
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
                            CachedNetworkImage(
                              imageUrl: songList[index].musicImage,
                              height: 40,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  songList[index].title,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(songList[index].artistName,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "No Search Results",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
    );
  }
}
