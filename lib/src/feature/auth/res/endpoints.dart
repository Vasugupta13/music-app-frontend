
import 'package:music_player/src/res/base.dart';

class AuthEndpoints {
   static const _base = BasePaths.baseUrl;
  static const login = "$_base/api/auth/login";
  static const signup = "$_base/api/auth/signup";
}