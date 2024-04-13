import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/commons/controller/db_controller.dart';
import 'package:music_player/src/feature/home/controller/home_controller.dart';
import 'package:music_player/src/models/songs_model.dart';

final homeViewControllerProvider =
    StateNotifierProvider<HomeViewController, SongListState>((ref) {
  final controller = ref.watch(homeControllerProvider);
  return HomeViewController(homeController: controller, ref: ref);
});

class HomeViewController extends StateNotifier<SongListState> {
  final HomeController _homeController;
  final Ref _ref;
  HomeViewController({required HomeController homeController, required Ref ref})
      : _homeController = homeController,
        _ref = ref,
        super(SongListState(songList: []));

  Future<void> updateFavourite(
      {required String songId, required int isFavourite}) async {
    _ref.read(dbControllerProvider).updateFavorite(songId, isFavourite);
    final songs = await _homeController.updateFavourite(
        songId: songId, isFavourite: isFavourite);
    if (songs != null) {
      state = state.copyWith(
        songList: songs,
      );
    } else {
      final songs = await _ref.read(dbControllerProvider).getSongs();
      state = state.copyWith(songList: songs);
    }
  }

  Future<void> updateSongsFromDb() async {
    if (state.loading) {
      return;
    }
    final songs = await _ref.read(dbControllerProvider).getSongs();
    state = state.copyWith(loading: true);
    final songData = await _homeController.updatedSongsFromDb(songList: songs);
    if (songData != null) {
      state = state.copyWith(
        songList: songData,
      );
      await Future.delayed(const Duration(milliseconds: 1400));
      state = state.copyWith(loading: false);
    } else {
      final songs = await _ref.read(dbControllerProvider).getSongs();
      state = state.copyWith(loading: false, songList: songs);
    }
  }
}

class SongListState {
  final bool loading;
  final List<SongModel>? songList;

  SongListState({this.loading = false, required this.songList});

  SongListState copyWith({
    bool? loading,
    List<SongModel>? songList,
  }) {
    return SongListState(
      loading: loading ?? this.loading,
      songList: songList ?? this.songList,
    );
  }
}
