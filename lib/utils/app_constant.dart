class AppConstants {
  //API ----------------------------------------------------
  static const String baseUrl = 'https://api.weatherapi.com/v1';

  //Database -----------------------------------------------
  static const String databaseName = 'weather_app.db';
  static const int databaseVersion = 1;
  static const String tableCities = 'cities';

  static const String columnId = 'id';
  static const String columnName = 'city_name';
  static const String columnCreatedAt = 'created_at';
}
