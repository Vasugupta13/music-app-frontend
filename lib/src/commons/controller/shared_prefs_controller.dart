import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/commons/repository/shared_prefs_repo.dart';
import 'package:music_player/src/core/type_def.dart';
import 'package:music_player/src/models/user_model.dart';


final sharedPrefsControllerProvider = Provider((ref) {
  final repo = ref.watch(sharedPrefsRepoProvider);
  return SharedPrefsController(repo: repo);
});

class SharedPrefsController {
  final SharedPrefsRepo _repo;

  SharedPrefsController({required SharedPrefsRepo repo}) : _repo = repo;

  Future<String?> getCookie() async {
    return _repo.getCookie();
  }

  FutureVoid setCookie({required String cookie}) async {
    await _repo.setCookie(cookie);
  }

  Future<String?> getData(key) async {
    return _repo.getData(key);
  }

  FutureVoid setData({required String key,required String cookie}) async {
    await _repo.setData(key,cookie);
  }

  Future<User?> getUser() async {
    return _repo.getCurrentUser();
  }

  FutureVoid setUser({required User user}) async {
    _repo.setCurrentUser(user);
  }

  FutureVoid clear() async {
    return _repo.clear();
  }
  Future<void> setUserTheme({required String key,required bool isDarkMode}) async {
    await _repo.setData(key, isDarkMode ? 'true' : 'false');
  }

  Future<bool> getUserTheme() async {
    final storedValue = await _repo.getData('isDarkMode');
    return storedValue == 'true';
  }
}
