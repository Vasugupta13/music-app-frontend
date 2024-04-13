import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/commons/repository/db_repo.dart';
import 'package:music_player/src/core/type_def.dart';
import 'package:music_player/src/models/songs_model.dart';

final dbControllerProvider = Provider((ref) {
  final repo = ref.watch(dbRepoProvider);
  return DbController(helperRepo: repo);
});
class DbController {
  final DatabaseHelperRepo _helperRepo;
  DbController({required DatabaseHelperRepo helperRepo}) : _helperRepo = helperRepo;

  Future<List<SongModel>> getSongs() async{
    final res = await _helperRepo.getSongsFromDb();
    return res;
  }
  FutureVoid addSongToDb(SongModel song) async{
    await _helperRepo.insertSongsToDb(song);
  }
  FutureVoid updateFavorite(String songId, int isFavourite) async{
    await _helperRepo.updateFavourite(songId, isFavourite);
  }
}