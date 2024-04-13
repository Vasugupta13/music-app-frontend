import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/commons/controller/db_controller.dart';
import 'package:music_player/src/feature/home/repository/home_repo.dart';
import 'package:music_player/src/feature/home/res/labels.dart';
import 'package:music_player/src/feature/home/res/messages.dart';
import 'package:music_player/src/models/songs_model.dart';

final homeControllerProvider = Provider((ref) {
  final homeRepo = ref.watch(homeRepoProvider);
  return HomeController(ref: ref, homeRepo: homeRepo);
});

class HomeController {
  HomeController({required HomeRepo homeRepo, required Ref ref})
      : _homeRepo = homeRepo,
        _ref = ref;
  final HomeRepo _homeRepo;
  final Ref _ref;

  Future<List<SongModel>?> updateFavourite(
      {required String songId, required int isFavourite}) async {
    final res =
        await _homeRepo.updateFav(songId: songId, isFavourite: isFavourite);
    return res.fold((failure) {
      log(HomeFailureMessage.loadFailed, name: HomeLabels.controller);
      return null;
    }, (response) {
      final jsonData = jsonDecode(response.body);
      final songData = jsonData['data']['songList'];
      final List<SongModel> songList = [];
      for (var songs in songData) {
        var song = songs['song'];
        songList.add(SongModel.fromMap(song));
        _ref.read(dbControllerProvider).addSongToDb(SongModel.fromMap(song));
      }
      log(HomeSuccessMessage.loadSuccess, name: HomeLabels.controller);
      return songList;
    });
  }

  Future<List<SongModel>?> updatedSongsFromDb({
    required List<SongModel> songList,
  }) async {
    final res = await _homeRepo.initUpdateSongsFromDb(songList: songList);
    return res.fold((failure) {
      log(HomeFailureMessage.loadFailed, name: HomeLabels.controller);
      return null;
    }, (response) {
      final jsonData = jsonDecode(response.body);
      final songData = jsonData['data']['songList'];
      final List<SongModel> songList = [];
      for (var songs in songData) {
        var song = songs['song'];
        songList.add(SongModel.fromMap(song));
        _ref.read(dbControllerProvider).addSongToDb(SongModel.fromMap(song));
      }
      log(HomeSuccessMessage.loadSuccess, name: HomeLabels.controller);
      return songList;
    });
  }
}
