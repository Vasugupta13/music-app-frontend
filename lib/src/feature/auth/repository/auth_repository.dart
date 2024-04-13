import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/core/core.dart';
import 'package:music_player/src/feature/auth/res/endpoints.dart';
import 'package:music_player/src/feature/auth/res/labels.dart';

final authRepoProvider = Provider((ref) {
  final networkRepo = ref.watch(networkRepoProvider);
  return AuthRepo(networkRepo: networkRepo);
});

class AuthRepo {
  final NetworkRepo _networkRepo;

  AuthRepo({required NetworkRepo networkRepo}) : _networkRepo = networkRepo;

  Future<Response?> login(
      {required String email, required String password}) async {
    final body = {"email": email, "password": password};
    final result = await _networkRepo.postRequest(
        url: AuthEndpoints.login, body: body, requireAuth: false);
    return result.fold(
      (Failure failure) {
        log(
          failure.message,
          name: AuthLabels.repo,
        );
        return null;
      },
      (Response response) => response,
    );
  }

  Future<Response?> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final body = {"email": email, "password": password, "name": name};

    final result = await _networkRepo.postRequest(
        url: AuthEndpoints.signup, body: body, requireAuth: false);
    return result.fold(
      (Failure failure) {
        log(
          failure.message,
          name: AuthLabels.repo,
        );
        return null;
      },
      (Response response) => response,
    );
  }

  Future<void> signOut() async {}
}
