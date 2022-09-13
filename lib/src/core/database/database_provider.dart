import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/src/core/constants/database_consts.dart';
import 'package:todo_app/src/core/constants/database_notification_table_consts.dart';
import 'package:todo_app/src/core/errors/exceptions.dart';

class DatabaseProvider {
  static final _instance = DatabaseProvider._internal();
  static DatabaseProvider get = _instance;
  bool isInitialized = false;
  late Database _db;

  DatabaseProvider._internal();

  Future<Database> db() async {
    if (!isInitialized) await init();
    return _db;
  }

  Future init() async {
    var path = await _initDatabasePath();
    _db = await _initDatabase(path);
    isInitialized = true;
  }

  Future<String> _initDatabasePath() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, '$taskTableName.db');
      if (path.isEmpty) {
        throw DatabaseFetchingPathException();
      }
      return path;
    } catch (e) {
      throw DatabaseFetchingPathException();
    }
  }

  Future<Database> _initDatabase(String path) async {
    try {
      var db = await openDatabase(
        path,
        version: version,
        onCreate: _initDatabaseOnCreate,
      );
      return db;
    } catch (e) {
      throw DatabaseInitializationException();
    }
  }

  Future<void> _initDatabaseOnCreate(Database db, int version) async {
    try {
      await _createDatabaseTaskTable(db);
      await _createDatabaseNotificationTable(db);
    } on DatabaseCreatingTaskTableException {
      throw DatabaseCreatingTaskTableException();
    } on DatabaseCreatingNotificationTableException {
      throw DatabaseCreatingNotificationTableException();
    }
  }

  Future<void> _createDatabaseTaskTable(Database db) async {
    try {
      await db.execute(createTaskTableQuery);
    } catch (e) {
      throw DatabaseCreatingTaskTableException;
    }
  }

  Future<void> _createDatabaseNotificationTable(Database db) async {
    try {
      await db.execute(createNotificationTableQuery);
    } catch (e) {
      throw DatabaseCreatingNotificationTableException;
    }
  }
}
