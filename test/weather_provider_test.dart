import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/api_service.dart';

import 'fake_weather_dao.dart';

void main() {
  final validResponseJson = {
    "location": {
      "name": "London",
      "region": "City of London, Greater London",
      "country": "United Kingdom",
      "lat": 51.5171,
      "lon": -0.1062,
      "tz_id": "Europe/London",
      "localtime_epoch": 1775380513,
      "localtime": "2026-04-05 10:15",
    },
    "current": {
      "last_updated_epoch": 1775380500,
      "last_updated": "2026-04-05 10:15",
      "temp_c": 10.1,
      "temp_f": 50.2,
      "is_day": 1,
      "condition": {
        "text": "Moderate rain",
        "icon": "//cdn.weatherapi.com/weather/64x64/day/302.png",
        "code": 1189,
      },
      "wind_mph": 12.3,
      "wind_kph": 19.8,
      "wind_degree": 259,
      "wind_dir": "W",
      "pressure_mb": 1014.0,
      "pressure_in": 29.94,
      "precip_mm": 0.07,
      "precip_in": 0.0,
      "humidity": 71,
      "cloud": 100,
      "feelslike_c": 7.5,
      "feelslike_f": 45.5,
      "windchill_c": 6.7,
      "windchill_f": 44.1,
      "heatindex_c": 9.4,
      "heatindex_f": 49.0,
      "dewpoint_c": 2.4,
      "dewpoint_f": 36.3,
      "vis_km": 10.0,
      "vis_miles": 6.0,
      "uv": 1.4,
      "gust_mph": 14.2,
      "gust_kph": 22.8,
      "short_rad": 227.94,
      "diff_rad": 83.18,
      "dni": 375.29,
      "gti": 74.11,
    },
  };

  group('WeatherProvider', () {
    test('addCity adds weather data on success', () async {
      final mockClient = MockClient((request) async {
        return http.Response(json.encode(validResponseJson), 200);
      });

      final provider = WeatherProvider(
        apiService: ApiService(client: mockClient, apiKey: 'key'),
        weatherDao: FakeWeatherDao(),
      );

      await provider.addCity('London');

      expect(provider.weatherData.containsKey('London'), isTrue);
      expect(provider.weatherData['London']!.currentCondition.tempc, 10.1);
      expect(provider.errorMessage, isNull);
    });

    test('remove City removes the city from data', () async {
      final mockClient = MockClient((request) async {
        return http.Response(json.encode(validResponseJson), 200);
      });

      final provider = WeatherProvider(
        apiService: ApiService(client: mockClient, apiKey: 'key'),
        weatherDao: FakeWeatherDao(),
      );

      await provider.addCity('London');
      expect(provider.weatherData.containsKey('London'), isTrue);

      await provider.removeCity('London');
      expect(provider.weatherData.containsKey('London'), isFalse);
    });

    test('clear Error resets error message', () async {
      final provider = WeatherProvider(
        apiService: ApiService(apiKey: 'key'),
        weatherDao: FakeWeatherDao(),
      );

      await provider.addCity('');
      expect(provider.errorMessage, isNotNull);

      provider.clearError();
      expect(provider.errorMessage, isNull);
    });
  });
}
