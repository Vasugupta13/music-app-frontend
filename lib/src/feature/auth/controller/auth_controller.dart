import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/src/commons/controller/db_controller.dart';
import 'package:music_player/src/commons/controller/shared_prefs_controller.dart';
import 'package:music_player/src/commons/providers/common_providers.dart';
import 'package:music_player/src/feature/auth/repository/auth_repository.dart';
import 'package:music_player/src/feature/auth/res/labels.dart';
import 'package:music_player/src/feature/auth/view/login_view.dart';
import 'package:music_player/src/feature/home/view/home.dart';
import 'package:music_player/src/models/songs_model.dart';
import 'package:music_player/src/models/user_model.dart';
import 'package:music_player/src/utils/snackbar_service.dart';
import '../res/messages.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return AuthController(authRepo: authRepo, ref: ref);
});

class AuthController extends StateNotifier<bool> {
  AuthController({required AuthRepo authRepo, required Ref ref})
      : _authRepo = authRepo,
        _ref = ref,
        super(false);

  final AuthRepo _authRepo;
  final Ref _ref;

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;
    _authRepo.login(email: email, password: password).then((response) {
      if (response != null) {
        try {
          final data = jsonDecode(response.body);
          final loginSuccess = data['success'];
          final message = data['message'];
          if (loginSuccess) {
            SnackBarService.showSnackBar(
              context: context,
              message: loginSuccess
                  ? AuthSuccessMessage.loginSuccess
                  : AuthFailureMessage.otpVerification,
            );
            final token = data['token'];
            if (token != null) {
              _ref.read(sharedPrefsControllerProvider).setCookie(cookie: token);
              _ref.read(authTokenProvider.notifier).update((state) => token);
            }
            final user = User.fromMap(data['user']);
            _ref.read(sharedPrefsControllerProvider).setUser(user: user);
            _ref.read(currentUserProvider.notifier).update((state) => user);
            state = false;
            context.go(HomeView.routePath);
            final songData = data['data']['songList'];
            for (var songs in songData) {
              var song = songs['song'];
              _ref
                  .read(dbControllerProvider)
                  .addSongToDb(SongModel.fromMap(song));
            }
          } else {
            SnackBarService.showSnackBar(context: context, message: message);
            state = false;
          }
        } catch (e, stacktrace) {
          SnackBarService.showSnackBar(
              context: context, message: AuthFailureMessage.loginFailed);
          log(AuthFailureMessage.parseJSON, name: AuthLabels.controller);
          debugPrint("$stacktrace");
        }
      } else {
        SnackBarService.showSnackBar(
            context: context, message: AuthFailureMessage.loginFailed);
        state = false;
      }
    });
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) async {
    state = true;
    _authRepo
        .signUp(email: email, password: password, name: name)
        .then((response) {
      if (response != null) {
        try {
          final data = jsonDecode(response.body);
          String message = data['message'];
          if (message.contains('Invalid Email!')) {
            message = "Enter a valid email!";
          }
          SnackBarService.showSnackBar(context: context, message: message);
          state = false;
        } catch (e, stacktrace) {
          log(AuthFailureMessage.parseJSON, name: AuthLabels.controller);
          debugPrint("$stacktrace");
          state = false;
        }
      }
    });
  }

  Future<void> signOut({BuildContext? context}) async {
    if (context != null) {
      context.replace(LoginView.routePath);
    }
    _ref.read(authTokenProvider.notifier).update((state) => null);
    _ref.read(currentUserProvider.notifier).update((state) => null);
    _ref.read(sharedPrefsControllerProvider).clear();
  }
}
