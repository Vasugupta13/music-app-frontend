import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/models/user_model.dart';

/// Watch the [authTokenProvider] to check if the user is logged in.
final authTokenProvider = StateProvider<String?>((ref) => null);

final currentUserProvider = StateProvider<User?>((ref) => null);