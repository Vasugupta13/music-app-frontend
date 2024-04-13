import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/core/core.dart';
import 'package:music_player/src/feature/search/res/labels.dart';
import 'package:music_player/src/res/endpoints.dart';

final searchRepoProvider = Provider((ref) {
  final networkRepo = ref.watch(networkRepoProvider);
  return SearchRepo(networkRepo: networkRepo);
});

class SearchRepo {
  final NetworkRepo _networkRepo;
  SearchRepo({required NetworkRepo networkRepo}) : _networkRepo = networkRepo;

  Future<Response?> searchSongs({
    required String songQuery,
  }) async {
    final result = await _networkRepo.getRequest(
        url: "${Endpoints.searchSong}$songQuery", requireAuth: true);
    return result.fold(
      (Failure failure) {
        log(
          failure.message,
          name: SearchLabels.repo,
        );
        return null;
      },
      (Response response) => response,
    );
  }
}
