import 'package:sqflite/sqflite.dart';
import 'package:weather_app/data/database/database_helper.dart';
import 'package:weather_app/core/constants/app_constant.dart';

class WeatherDao {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  //Insert city
  Future<bool> insertCity(String cityName) async {
    final db = await _databaseHelper.database;
    final row = {
      AppConstants.columnName: cityName,
      AppConstants.columnCreatedAt: DateTime.now().toIso8601String(),
    };
    var id = await db.insert(
      AppConstants.tableCities,
      row,
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    return id > 0;
  }

  // get all cities
  Future<List<String>> getAllCities() async {
    final db = await _databaseHelper.database;
    var data = await db.query(AppConstants.tableCities);
    return data.map((row) => row[AppConstants.columnName] as String).toList();
  }

  // delete city by cityName
  Future<bool> deleteCity(String cityName) async {
    final db = await _databaseHelper.database;
    var count = await db.delete(
      AppConstants.tableCities,
      where: '${AppConstants.columnName} = ?',
      whereArgs: [cityName],
    );
    return count > 0;
  }

  //check city exists
  Future<bool> cityExists(String cityName) async {
    final city = await getCityByName(cityName);
    return city != null;
  }

  //get city by name
  Future<Map<String, dynamic>?> getCityByName(String cityName) async {
    final db = await _databaseHelper.database;
    final results = await db.query(
      AppConstants.tableCities,
      where: '${AppConstants.columnName} = ?',
      whereArgs: [cityName],
      limit: 1,
    );
    return results.isNotEmpty ? results.first : null;
  }
}
