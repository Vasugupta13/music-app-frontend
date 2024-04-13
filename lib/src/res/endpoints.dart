import 'package:music_player/src/res/base.dart';


/// Contains all the API endpoints used in the application.
/// Example :
/// 
/// An endpoint can be used the following way
/// ```dart
/// final response = await http.get(Endpoints.getUser)
/// ```

class Endpoints{
  static const _base = BasePaths.baseUrl;
  static const getSongs = "$_base/api/user/get-song";
  static const updateFavourite = "$_base/api/user/update-favourite";
  static const updateSongList = "$_base/api/user/update-songs";
  static const searchSong = "$_base/api/user-songs/search/";
}