import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:music_player/src/feature/home/repository/home_repo.dart';

/// A testing utility which creates a [ProviderContainer] and automatically
/// disposes it at the end of the test.
ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  ///disposing when test ends
  addTearDown(container.dispose);

  return container;
}

void main() {

  group('Home Provider Tests', () {
    group('update favourite tests', () {
      test('homeProvider update favourites auth failed', () async {
        final container = createContainer();
        final response = await container.read(homeRepoProvider).updateFav(songId: '6615572c7d33a7bea73af1a4', isFavourite: 0);
        expect(
            response.fold((failure) => null,
         (response) {
         final data = jsonDecode(response.body);
         final status = data["success"];
         return status;
        }), null);
      });
      test('homeProvider insert to db auth failed', () async {
        final container = createContainer();
        final response = await container.read(homeRepoProvider).initUpdateSongsFromDb(songList: []);
        expect(
            response.fold((failure) => null,
                    (response) {
                  final data = jsonDecode(response.body);
                  final status = data["success"];
                  return status;
          }), null);
      });
    });
  });
}