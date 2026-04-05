import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_app/utils/app_constant.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppConstants.databaseName);

    return await openDatabase(
      path,
      version: AppConstants.databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $AppConstants.tableCities (
        ${AppConstants.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${AppConstants.columnName} TEXT NOT NULL UNIQUE,
        ${AppConstants.columnCreatedAt} TEXT NOT NULL
      )
    ''');
  }

  //Insert city
  Future<int> insertCity(String cityName) async {
    final db = await database;
    final row = {
      AppConstants.columnName: cityName,
      AppConstants.columnCreatedAt: DateTime.now().toIso8601String(),
    };
    return await db.insert(
      AppConstants.tableCities,
      row,
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  // get all cities
  Future<List<Map<String, dynamic>>> getAllCities() async {
    final db = await database;
    return await db.query(AppConstants.tableCities);
  }

  // delete city by cityName
  Future<int> deleteCity(String cityName) async {
    final db = await database;
    return await db.delete(
      AppConstants.tableCities,
      where: 'LOWER(${AppConstants.columnName}) = ?',
      whereArgs: [cityName],
    );
  }

  //check city exists
  Future<bool> cityExists(String cityName) async {
    final city = await getCityByName(cityName);
    return city != null;
  }

  //get city by name
  Future<Map<String, dynamic>?> getCityByName(String cityName) async {
    final db = await database;
    final results = await db.query(
      AppConstants.tableCities,
      where: '${AppConstants.columnName} = ?',
      whereArgs: [cityName],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
