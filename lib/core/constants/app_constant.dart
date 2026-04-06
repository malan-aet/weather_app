class AppConstants {
  //Config -------------------------------------------------
  static const String envFileName = '.env';
  static const String envApiKeyName = 'API_KEY';
  static const String dateFormatInput = 'yyyy-MM-dd';
  static const String dateFormatDisplay = 'EEEE, MMM d';
  //API ----------------------------------------------------
  static const String baseUrl = 'https://api.weatherapi.com/v1';
  static const String paramKey = 'key';
  static const String paramQuery = 'q';
  static const String paramDays = 'days';
  static const int forecastDays = 3;
  //API URL ENdpoints --------------------------------------
  static const String currentWeatherEndPointURL = '/current.json';
  static const String forecastEndPointURL = '/forecast.json';

  //Database -----------------------------------------------
  static const String databaseName = 'weather_app.db';
  static const int databaseVersion = 1;
  static const String tableCities = 'cities';

  static const String columnId = 'id';
  static const String columnName = 'city_name';
  static const String columnCreatedAt = 'created_at';
}
