import 'package:weather_app/data/database/dao/weather_dao.dart';

class FakeWeatherDao extends WeatherDao {
  final List<String> _cities = [];

  FakeWeatherDao() : super();

  @override
  Future<List<String>> getAllCities() async => List.from(_cities);

  @override
  Future<bool> insertCity(String city) async {
    if (_cities.map((c) => c.toLowerCase()).contains(city.toLowerCase())) {
      return false;
    }
    _cities.add(city);
    return true;
  }

  @override
  Future<bool> deleteCity(String city) async {
    final before = _cities.length;
    _cities.removeWhere((c) => c.toLowerCase() == city.toLowerCase());
    return _cities.length < before;
  }

  @override
  Future<bool> cityExists(String city) async {
    return _cities.map((c) => c.toLowerCase()).contains(city.toLowerCase());
  }
}
