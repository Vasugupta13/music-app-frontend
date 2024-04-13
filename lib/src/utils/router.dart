import 'package:flutter/material.dart';
import 'package:music_player/src/commons/views/splash.dart';
import 'package:music_player/src/feature/auth/view/login_view.dart';
import 'package:music_player/src/feature/auth/view/sign_up_view.dart';
import 'package:music_player/src/feature/home/view/home.dart';
import 'package:go_router/go_router.dart';
import 'package:music_player/src/feature/profile/view/profile_view.dart';
import 'package:music_player/src/feature/search/view/search_view.dart';
import 'package:music_player/src/feature/song_play/view/song_play_view.dart';

final GoRouter router = GoRouter(
  initialLocation: SplashView.routePath,
  routes: [
    GoRoute(
      path: SplashView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashView();
      },
    ),
    GoRoute(
      path: HomeView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeView();
      },
    ),
    GoRoute(
      path: LoginView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginView();
      },
    ),
    GoRoute(
      path: SignUpView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpView();
      },
    ),
    GoRoute(
      path: SearchView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const SearchView();
      },
    ),
    GoRoute(
      path: ProfileView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileView();
      },
    ),
    GoRoute(
      path: SongPlayView.routePath,
      builder: (BuildContext context, GoRouterState state) {
        final Map<String, String> extras = state.extra as Map<String, String>;
        return SongPlayView(
          musicImage: extras['musicImage']!,
          title: extras['title']!,
          artistName: extras['artistName']!,
          musicUrl: extras['musicUrl']!,
        );
      },
    )
  ],
);
