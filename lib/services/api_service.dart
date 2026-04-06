import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/forecast_model.dart';
import 'package:weather_app/models/weather_location_model.dart';
import 'package:weather_app/utils/app_constant.dart';
import 'package:weather_app/utils/app_strings.dart';

class ApiService {
  final http.Client client;
  final String _apiKey;

  ApiService({http.Client? client, String? apiKey})
    : client = client ?? http.Client(),
      _apiKey = apiKey ?? dotenv.env[AppStrings.envApiKeyName] ?? '';

  Future<WeatherLocationModel> fetchCurrentWeather(String city) async {
    final uri = Uri.parse(
      '${AppConstants.baseUrl}${AppConstants.currentWeatherEndPointURL}?${AppConstants.paramKey}=$_apiKey&${AppConstants.paramQuery}=$city',
    );

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body) as Map<String, dynamic>;
      return WeatherLocationModel.fromJson(jsonBody);
    } else if (response.statusCode == 400) {
      final errorBody = json.decode(response.body);
      final message = errorBody['error']?['message'];
      throw Exception(message);
    } else {
      throw Exception(AppStrings.failedToLoadWeather);
    }
  }

  Future<List<ForecastModel>> fetchForecast(
    String city, {
    int days = AppConstants.forecastDays,
  }) async {
    final uri = Uri.parse(
      '${AppConstants.baseUrl}${AppConstants.forecastEndPointURL}?${AppConstants.paramKey}=$_apiKey&${AppConstants.paramQuery}=$city&${AppConstants.paramDays}=${AppConstants.forecastDays}',
    );

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body) as Map<String, dynamic>;
      final forecastData = jsonBody['forecast']['forecastday'] as List<dynamic>;
      return forecastData
          .map((day) => ForecastModel.fromJson(day as Map<String, dynamic>))
          .toList();
    } else if (response.statusCode == 400) {
      final errorBody = json.decode(response.body);
      final message = errorBody['error']?['message'];
      throw Exception(message);
    } else {
      throw Exception(AppStrings.failedToLoadForecast);
    }
  }
}
