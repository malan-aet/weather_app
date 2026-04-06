import 'package:flutter_test/flutter_test.dart';

import 'fake_weather_dao.dart';

void main() {
  late FakeWeatherDao weatherDao;

  setUp(() {
    weatherDao = FakeWeatherDao();
  });

  group('city — Create', () {
    test('insertCity inserts a new city', () async {
      final result = await weatherDao.insertCity('London');
      expect(result, isTrue);

      final cities = await weatherDao.getAllCities();
      expect(cities.length, 1);
      expect(cities.first, 'London');
    });

    test('insert City rejects duplicate', () async {
      await weatherDao.insertCity('London');
      final result = await weatherDao.insertCity('London');
      expect(result, isFalse);

      final cities = await weatherDao.getAllCities();
      expect(cities.length, 1);
    });

    test('insert City allows different cities', () async {
      await weatherDao.insertCity('London');
      await weatherDao.insertCity('Tokyo');
      await weatherDao.insertCity('Colombo');

      final cities = await weatherDao.getAllCities();
      expect(cities.length, 3);
    });
  });

  group('city - read', () {
    test('getAllCities returns empty list initially', () async {
      final cities = await weatherDao.getAllCities();
      expect(cities, isEmpty);
    });

    test('get All Cities returns all added cities', () async {
      await weatherDao.insertCity('London');
      await weatherDao.insertCity('Tokyo');

      final cities = await weatherDao.getAllCities();
      expect(cities.length, 2);
      expect(cities, contains('London'));
      expect(cities, contains('Tokyo'));
    });
  });

  group('remove city', () {
    test('removeCity deletes and returns true', () async {
      await weatherDao.insertCity('London');
      await weatherDao.insertCity('Tokyo');

      final result = await weatherDao.deleteCity('London');
      expect(result, isTrue);

      final cities = await weatherDao.getAllCities();
      expect(cities.length, 1);
      expect(cities.first, 'Tokyo');
    });

    test('remove City returns false for non exist city', () async {
      await weatherDao.insertCity('London');
      final result = await weatherDao.deleteCity('Paris');
      expect(result, isFalse);
    });
  });
}
