import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'db_countdown_tap_entity.dart';

class CountdownTapDatabase extends GetxService {
  static const String _databaseName = 'countdown_tap.db';
  static const int _databaseVersion = 1;

  static const String _tableMatchHistory = 'match_history';

  Database? _database;

  Future<CountdownTapDatabase> init() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );

    return this;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableMatchHistory (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        timestamp TEXT NOT NULL,
        duration INTEGER NOT NULL,
        player1_name TEXT NOT NULL,
        player1_score INTEGER NOT NULL,
        player2_name TEXT NOT NULL,
        player2_score INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_match_history_timestamp 
      ON $_tableMatchHistory(timestamp DESC)
    ''');
  }

  Database get database {
    if (_database == null) {
      throw Exception('Database not initialized. Call init() first.');
    }
    return _database!;
  }

  Future<int> insertMatchHistory(MatchHistoryEntity match) async {
    try {
      return await database.insert(
        _tableMatchHistory,
        match.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw Exception('Failed to insert match history: $e');
    }
  }

  Future<List<MatchHistoryEntity>> getMatchHistory() async {
    try {
      final List<Map<String, dynamic>> maps = await database.query(
        _tableMatchHistory,
        orderBy: 'timestamp DESC, id DESC',
      );

      return maps.map((map) => MatchHistoryEntity.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Failed to get match history: $e');
    }
  }

  Future<int> clearAllMatchHistory() async {
    try {
      return await database.delete(_tableMatchHistory);
    } catch (e) {
      throw Exception('Failed to clear all match history: $e');
    }
  }
}

