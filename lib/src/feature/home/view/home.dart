import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/feature/home/controller/home_view_controller.dart';
import 'package:music_player/src/feature/home/view/widgets/carousel_image_widget.dart';
import 'package:music_player/src/feature/home/view/widgets/home_top_bar_widget.dart';
import 'package:music_player/src/feature/home/view/widgets/song_list_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  static const routePath = "/home";
  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late final controller = ref.watch(homeViewControllerProvider.notifier);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.updateSongsFromDb();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loading =
        ref.watch(homeViewControllerProvider.select((value) => value.loading));
    return Scaffold(
      body: Column(
        children: [
          const TopBarWidget(),
          Expanded(
            child: !loading
                ? ListView(
                    padding: EdgeInsets.zero,
                    children: const [
                      Column(
                        children: [CarouselImageSlider(), SongListWidget()],
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
