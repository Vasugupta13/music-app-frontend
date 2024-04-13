import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/commons/controller/shared_prefs_controller.dart';
import 'package:music_player/src/commons/providers/common_providers.dart';
import 'package:music_player/src/core/type_def.dart';


final initControllerProvider = Provider((ref) => InitController(ref: ref));

class InitController {
  final Ref _ref;

  InitController({required Ref ref}) : _ref = ref;

  FutureVoid initUserAndToken() async {
    await _ref.read(sharedPrefsControllerProvider).getUser().then((value) {
      _ref.read(currentUserProvider.notifier).update((state) => value);
    });

    await _ref.read(sharedPrefsControllerProvider).getCookie().then((value) {
      _ref.read(authTokenProvider.notifier).update((state) => value);
    });
  }
}
