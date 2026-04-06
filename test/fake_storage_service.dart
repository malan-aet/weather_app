import 'package:weather_app/services/storage_service.dart';

class FakeStorageService extends StorageService {
  final List<String> _cities = [];

  FakeStorageService() : super(dbHelper: null);

  @override
  Future<List<String>> loadCities() async => List.from(_cities);

  @override
  Future<bool> addCity(String city) async {
    if (_cities.map((c) => c.toLowerCase()).contains(city.toLowerCase())) {
      return false;
    }
    _cities.add(city);
    return true;
  }

  @override
  Future<bool> removeCity(String city) async {
    final before = _cities.length;
    _cities.removeWhere((c) => c.toLowerCase() == city.toLowerCase());
    return _cities.length < before;
  }

  Future<bool> cityExists(String city) async {
    return _cities.map((c) => c.toLowerCase()).contains(city.toLowerCase());
  }
}
