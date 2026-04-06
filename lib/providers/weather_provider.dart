import 'package:flutter/material.dart';
import 'package:weather_app/models/forecast_model.dart';
import 'package:weather_app/models/weather_location_model.dart';
import 'package:weather_app/services/api_service.dart';
import '../services/storage_service.dart';

class WeatherProvider extends ChangeNotifier {
  final ApiService _apiService;
  final StorageService _storageService;

  final Map<String, WeatherLocationModel> _weatherData = {};
  final Map<String, List<ForecastModel>> _forecastData = {};
  bool _isLoading = false;
  String? _errorMessage;

  WeatherProvider({ApiService? apiService, StorageService? storageService})
    : _apiService = apiService ?? ApiService(),
      _storageService = storageService ?? StorageService();

  Map<String, WeatherLocationModel> get weatherData =>
      Map.unmodifiable(_weatherData);
  Map<String, List<ForecastModel>> get forecastData =>
      Map.unmodifiable(_forecastData);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<String> get cities => _weatherData.keys.toList();

  Future<void> fetchSavedCities() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final savedCities = await _storageService.loadCities();
      for (final city in savedCities) {
        try {
          final weather = await _apiService.fetchCurrentWeather(city);
          _weatherData[weather.location.name] = weather;
        } on Exception catch (e) {
          debugPrint(
            'Could not load weather for $city: '
            '$e',
          );
        }
      }
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  //store city and update the current weather
  Future<void> addCity(String cityName) async {
    if (cityName.isEmpty) {
      _errorMessage = 'Enter city name';
      notifyListeners();
      return;
    }

    for (final existingCity in _weatherData.keys) {
      if (existingCity.toLowerCase() == cityName.toLowerCase()) {
        _errorMessage = '$cityName is already in your list.';
        notifyListeners();
        return;
      }
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final weather = await _apiService.fetchCurrentWeather(cityName.trim());

      if (_weatherData.containsKey(weather.location.name)) {
        _errorMessage = '${weather.location.name} is already in your list.';
        _isLoading = false;
        notifyListeners();
        return;
      }

      _weatherData[weather.location.name] = weather;
      await _storageService.addCity(weather.location.name);
    } on Exception catch (e) {
      _errorMessage = e.toString();
    } catch (e) {
      _errorMessage = 'Something went wrong. Please try again.';
    }

    _isLoading = false;
    notifyListeners();
  }

  //renove city by city name
  Future<void> removeCity(String cityName) async {
    _weatherData.remove(cityName);
    await _storageService.removeCity(cityName);
    notifyListeners();
  }

  //refresh all cities and update weather data
  Future<void> refreshAllCities() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final cityList = List<String>.from(_weatherData.keys);
    for (final city in cityList) {
      try {
        final weather = await _apiService.fetchCurrentWeather(city);
        _weatherData[city] = weather;
      } on Exception catch (e) {
        debugPrint('Refresh failed for $city: $e');
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  // get Forecast list
  Future<List<ForecastModel>> loadForecast(String cityName) async {
    if (_forecastData.containsKey(cityName)) {
      return _forecastData[cityName]!;
    }

    try {
      final forecasts = await _apiService.fetchForecast(cityName);
      _forecastData[cityName] = forecasts;
      notifyListeners();
      return forecasts;
    } on Exception catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return [];
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
