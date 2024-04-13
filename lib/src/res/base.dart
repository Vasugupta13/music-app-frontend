import 'package:music_player/src/utils/config.dart';

class BasePaths{
  static const baseImagePath = "assets/images";
  static const baseAnimationPath = "assets/animations";
  static const basePlaceholderPath = "assets/placeholders";
  static const baseProdUrl = "https://music-app-server-d2nk.onrender.com";
  static const baseTestUrl = "http://192.168.1.16:3000";
  static const baseUrl = AppConfig.devMode ? baseTestUrl : baseProdUrl;
}