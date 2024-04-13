import 'package:flutter_test/flutter_test.dart';
import 'package:music_player/src/feature/song_play/res/helper.dart';

void main() {
  group('SongPlayHelper', () {
    test('formatSongTime', () {
      expect(SongPlayHelper.formatSongTime(const Duration(hours: 1, minutes: 30, seconds: 15)), '01:30:15');
      expect(SongPlayHelper.formatSongTime(const Duration(minutes: 30, seconds: 15)), '30:15');
      expect(SongPlayHelper.formatSongTime(const Duration(seconds: 15)), '00:15');
    });
  });
}