import 'package:music_player/src/res/base.dart';


/// Contains all the paths of image used across the project.
/// Every image path variable name must contain a name and its extension.
/// example :
///
/// for an image with name avatar.png,
/// a suitable variable can be [avatarImagePng].
/// ```dart
/// static const sampleImagePng = "$_base/image.png";
/// ```
/// can be used by doing
/// ```dart
/// ImageAssets.sampleImagePng
/// ```
class ImageAssets{
  static const _base = BasePaths.baseImagePath;

  static const logo = "$_base/logo.png";
  static const pfp = "$_base/pfp.png";

  ///music images-
  static const escapism = "$_base/escapism.png";
  static const highestInTheRoom = "$_base/highest_travis_scott.png";
  static const iKnow = "$_base/iknow_travis_scott.png";
  static const industryBaby = "$_base/industry_baby.png";
  static const joji = "$_base/joji.jpg";
  static const maskOff = "$_base/mask_off.png";
  static const pickUpThePhone = "$_base/pick_up_the_phone.png";
  static const popular = "$_base/popular.png";
  static const ricFlair = "$_base/ric_flair.png";
  static const sikoMode = "$_base/siko_mode.png";


}

class AnimationAssets{
  /// Contains all the paths of animations used across the project.
}

class PlaceholderAssets {
  static const _base = BasePaths.basePlaceholderPath;

  static const carouselCardJpeg = "$_base/carousel_placehoder.jpeg";
}