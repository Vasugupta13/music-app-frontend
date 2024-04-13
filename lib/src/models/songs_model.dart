import 'dart:convert';

SongModel temperaturesFromMap(String str) => SongModel.fromMap(json.decode(str));

String temperaturesToMap(SongModel data) => json.encode(data.toMap());

class SongModel {
  final String songId;
  final String title;
  final String artistName;
  final String musicImage;
  final int isFavourite;
  final String musicUrl;

  SongModel( {
    required this.songId,
    required this.title,
    required this.artistName,
    required this.musicImage,
    required this.isFavourite,
    required this.musicUrl,
  });

  factory SongModel.fromMap(Map<String, dynamic> json) => SongModel(
    songId: json["_id"],
    title: json["title"],
    artistName: json["artistName"],
    musicImage: json["musicImage"],
    isFavourite: json["isFavourite"],
    musicUrl: json["musicUrl"],
  );

  Map<String, dynamic> toMap() => {
    "_id":songId,
    "title": title,
    "artistName": artistName,
    "musicImage": musicImage,
    "isFavourite": isFavourite,
    "musicUrl":musicUrl
  };
}