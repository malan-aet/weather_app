class AppStrings {
  static const String appTitle = 'Weather App';
  static const String envFileName = '.env';
  static const String envApiKeyName = 'API_KEY';

  //Exceptions
  static const String enterCityName = 'Please enter a city name.';
  static String failedToLoadWeather = 'Failed to load weather data.';
  static const String somethingWentWrong =
      'Something went wrong. Please try again.';
  static String cityAlreadyExists(String city) =>
      '$city is already in your list.';
}
