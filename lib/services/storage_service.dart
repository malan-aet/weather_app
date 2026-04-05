import 'package:weather_app/utils/app_constant.dart';

import 'database_helper.dart';

class StorageService {
  final DatabaseHelper _dbHelper;

  StorageService({DatabaseHelper? dbHelper})
    : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  Future<List<String>> loadCities() async {
    final rows = await _dbHelper.getAllCities();
    return rows.map((row) => row[AppConstants.columnName] as String).toList();
  }

  // add city
  Future<bool> addCity(String city) async {
    if (city.isEmpty) return false;

    final exists = await _dbHelper.cityExists(city);
    if (exists) return false;

    final id = await _dbHelper.insertCity(city);
    return id > 0;
  }

  // remove city
  Future<bool> removeCity(String city) async {
    final count = await _dbHelper.deleteCity(city);
    return count > 0;
  }
}
