import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/core/core.dart';
import 'package:music_player/src/core/type_def.dart';
import 'package:music_player/src/models/songs_model.dart';
import 'package:music_player/src/res/endpoints.dart';

final homeRepoProvider = Provider((ref) {
  final networkRepo = ref.watch(networkRepoProvider);
  return HomeRepo(networkRepo: networkRepo);
});

class HomeRepo {
  final NetworkRepo _networkRepo;

  HomeRepo({required NetworkRepo networkRepo}) : _networkRepo = networkRepo;

  FutureEither<Response> updateFav(
      {required String songId, required int isFavourite}) async {
    final body = {"songId": songId, "isFavourite": isFavourite};
    final result = await _networkRepo.putRequest(
        url: Endpoints.updateFavourite, body: body, requireAuth: true);
    return result;
  }

  FutureEither<Response> initUpdateSongsFromDb({
    required List<SongModel> songList,
  }) async {
    List<Map<String, dynamic>> mappedSongList = [];
    for (var song in songList) {
      mappedSongList.add({"song": song.toMap()});
    }
    final body = {"songList": mappedSongList};
    final result = await _networkRepo.putRequest(
        url: Endpoints.updateSongList, body: body, requireAuth: true);
    return result;
  }
}
