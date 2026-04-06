import 'package:flutter_test/flutter_test.dart';

import 'fake_storage_service.dart';

void main() {
  late FakeStorageService storage;

  setUp(() {
    storage = FakeStorageService();
  });

  group('Weather storage city — Create', () {
    test('addCity inserts a new city', () async {
      final result = await storage.addCity('London');
      expect(result, isTrue);

      final cities = await storage.loadCities();
      expect(cities.length, 1);
      expect(cities.first, 'London');
    });

    test('addCity rejects duplicate', () async {
      await storage.addCity('London');
      final result = await storage.addCity('London');
      expect(result, isFalse);

      final cities = await storage.loadCities();
      expect(cities.length, 1);
    });

    test('addCity allows different cities', () async {
      await storage.addCity('London');
      await storage.addCity('Tokyo');
      await storage.addCity('Colombo');

      final cities = await storage.loadCities();
      expect(cities.length, 3);
    });
  });

  group('Weather storage city - read', () {
    test('loadCities returns empty list initially', () async {
      final cities = await storage.loadCities();
      expect(cities, isEmpty);
    });

    test('loadCities returns all added cities', () async {
      await storage.addCity('London');
      await storage.addCity('Tokyo');

      final cities = await storage.loadCities();
      expect(cities.length, 2);
      expect(cities, contains('London'));
      expect(cities, contains('Tokyo'));
    });
  });

  group('Weather storage city — Delete', () {
    test('removeCity deletes and returns true', () async {
      await storage.addCity('London');
      await storage.addCity('Tokyo');

      final result = await storage.removeCity('London');
      expect(result, isTrue);

      final cities = await storage.loadCities();
      expect(cities.length, 1);
      expect(cities.first, 'Tokyo');
    });

    test('removeCity returns false for non exist city', () async {
      await storage.addCity('London');
      final result = await storage.removeCity('Paris');
      expect(result, isFalse);
    });
  });
}
