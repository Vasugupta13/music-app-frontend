import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/feature/search/repository/search_repo.dart';
import 'package:music_player/src/feature/search/res/labels.dart';
import 'package:music_player/src/feature/search/res/messages.dart';
import 'package:music_player/src/models/songs_model.dart';

final searchControllerProvider =
    StateNotifierProvider<SearchController, SearchSongState>((ref) {
  final searchProvider = ref.watch(searchRepoProvider);
  return SearchController(
    searchRepo: searchProvider,
  );
});

class SearchController extends StateNotifier<SearchSongState> {
  SearchController({required SearchRepo searchRepo})
      : _searchRepo = searchRepo,
        super(SearchSongState(searchSongList: []));
  final SearchRepo _searchRepo;

  Future<void> searchSong({required String songQuery}) async {
    try {
      final res = await _searchRepo.searchSongs(songQuery: songQuery);
      if (res != null) {
        final data = jsonDecode(res.body);
        final songData = data['data'];
        final List<SongModel> searchSongList = [];
        for (var songs in songData) {
          var song = songs['song'];
          searchSongList.add(SongModel.fromMap(song));
        }
        state = state.copyWith(
          searchSongList: searchSongList,
        );
        log(
          SearchSuccessMessage.loadSuccess,
          name: SearchLabels.controller,
        );
      } else {
        state = state.copyWith(
          searchSongList: [],
        );
      }
    } catch (e) {
      log(
        SearchFailureMessage.parseJSON,
        name: SearchLabels.controller,
      );
    }
  }
}

class SearchSongState {
  final List<SongModel> searchSongList;
  SearchSongState({required this.searchSongList});

  SearchSongState copyWith({
    List<SongModel>? searchSongList,
  }) {
    return SearchSongState(
      searchSongList: searchSongList ?? this.searchSongList,
    );
  }
}
