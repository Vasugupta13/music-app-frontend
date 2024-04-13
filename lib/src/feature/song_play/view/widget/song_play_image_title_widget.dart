import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/res/color.dart';

class SongPlayImageTitleWidget extends ConsumerWidget {
  final String title;
  final String musicImage;
  final String artistName;
  const SongPlayImageTitleWidget(
      {super.key,
      required this.title,
      required this.musicImage,
      required this.artistName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Hero(
          tag: 'song$title',
          child: CachedNetworkImage(
            imageUrl: musicImage,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
              ),
            ),
            height: 320,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                SizedBox(
                    height: 320,
                    child: Center(
                        child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: AppColors.kBlack,
                    ))),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        Text(artistName,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600)),
      ],
    );
  }
}
