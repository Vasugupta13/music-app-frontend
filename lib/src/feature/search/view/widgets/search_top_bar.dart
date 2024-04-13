import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/src/commons/views/widgets/text_field_widget.dart';
import 'package:music_player/src/feature/search/controller/search_controller.dart';

class SearchTopBarWidget extends ConsumerWidget {
  final TextEditingController searchController;
  const SearchTopBarWidget({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(
                  CupertinoIcons.back,
                  size: 25,
                )),
            Expanded(
                flex: 10,
                child: TextFieldWidget(
                  controller: searchController,
                  isProtected: false,
                  hintText: "Search songs and artists",
                  onChanged: (songQuery) {
                    ref
                        .read(searchControllerProvider.notifier)
                        .searchSong(songQuery: songQuery);
                  },
                )),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ],
    );
  }
}
