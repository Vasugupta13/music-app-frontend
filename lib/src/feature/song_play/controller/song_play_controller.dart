import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final songPlayerController =
    StateNotifierProvider<AudioPlayerNotifier, AudioPlayerState>(
        (ref) => AudioPlayerNotifier());

class AudioPlayerNotifier extends StateNotifier<AudioPlayerState> {
  late final AudioPlayer _audioPlayer;
  AudioPlayerNotifier() : super(AudioPlayerState()) {
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.playing) {
        state = state.copyWith(isPlaying: true);
      } else {
        state = state.copyWith(isPlaying: false);
      }
    });
    _audioPlayer.onDurationChanged.listen((newDuration) {
      state = state.copyWith(duration: newDuration);
    });
    _audioPlayer.onPositionChanged.listen((newPosition) {
      state = state.copyWith(position: newPosition);
    });
  }

  Future<void> initPlayer(String url) async {
    await _audioPlayer.play(UrlSource(url));
  }

  Future<void> play(String url) async {
    await _audioPlayer.play(UrlSource(url));
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> resume() async {
    await _audioPlayer.resume();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  void dispose() {
    state = state.copyWith(isPlaying: false);
    state = state.copyWith(duration: Duration.zero);
    state = state.copyWith(position: Duration.zero);
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }
}

class AudioPlayerState {
  final bool isPlaying;
  final Duration duration;
  final Duration position;

  AudioPlayerState(
      {this.isPlaying = true,
      this.duration = Duration.zero,
      this.position = Duration.zero});

  AudioPlayerState copyWith({
    bool? isPlaying,
    Duration? duration,
    Duration? position,
  }) {
    return AudioPlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      duration: duration ?? this.duration,
      position: position ?? this.position,
    );
  }
}
