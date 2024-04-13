import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/src/commons/controller/network_controller.dart';
import 'package:music_player/src/feature/home/controller/home_view_controller.dart';
import 'package:music_player/src/feature/song_play/view/song_play_view.dart';
import 'package:music_player/src/res/color.dart';
import 'package:music_player/src/utils/snackbar_service.dart';

class CarouselImageSlider extends ConsumerWidget {
  const CarouselImageSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songList =
        ref.watch(homeViewControllerProvider.select((value) => value.songList));
    final connected = ref.watch(connectivityStatusProviders);
    return Column(
      children: [
        const Text(
          "Discover",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40),
        ),
        SizedBox(
          height: 320,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
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
                  child: CachedNetworkImage(
                    imageUrl: songList[index].musicImage,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 6,
                              color: AppColors.kDarkGrey,
                              offset: Offset(0, 0)),
                        ],
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.fill),
                      ),
                    ),
                    height: 60,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => SizedBox(
                            height: 320,
                            child: Center(
                                child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: Theme.of(context).primaryColor,
                            ))),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              );
            },
            autoplay: true,
            itemCount: songList!.length,
            viewportFraction: 0.8,
            scale: 0.9,
          ),
        ),
      ],
    );
  }
}
