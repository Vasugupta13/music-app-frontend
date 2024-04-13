import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/models/songs_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final dbRepoProvider =
Provider<DatabaseHelperRepo>((ref) => DatabaseHelperRepo.instance);

class DatabaseHelperRepo {
  static const _databaseName = "MusicApp.db";
  static const _databaseVersion = 1;
  static const table = 'songs';
  static const columnId = '_id';
  static const titleName = 'title';
  static const artistName = 'artistName';
  static const musicImage = 'musicImage';
  static const isFavourite = 'isFavourite';
  static const musicUrl = 'musicUrl';

  DatabaseHelperRepo._privateConstructor();
  static final DatabaseHelperRepo instance = DatabaseHelperRepo._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId TEXT PRIMARY KEY,
            $titleName TEXT NOT NULL,
            $artistName TEXT NOT NULL,
            $musicImage TEXT NOT NULL,
            $isFavourite INTEGER NOT NULL,
            $musicUrl TEXT NOT NULL
          )
          ''');
  }

  Future<int> insertSongsToDb(SongModel song) async {
    Database db = await instance.database;
    return await db.insert(table, song.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<SongModel>> getSongsFromDb() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return SongModel.fromMap(maps[i]);
    });
  }
  Future<void> updateFavourite(String id, int isFavourite) async {
    final db = await instance.database;
    await db.update(
      table,
      {DatabaseHelperRepo.isFavourite: isFavourite},  // Use the column name directly
      where: "${DatabaseHelperRepo.columnId} = ?",
      whereArgs: [id],
    );
  }
}