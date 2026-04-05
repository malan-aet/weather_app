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

  //Screens
  static const String homeTitle = 'Weather';
  static const String addCity = 'Add City';
  static const String removeCity = 'Remove city';
  static const String noCitiesTitle = 'No cities added yet';
  static const String noCitiesSubtitle =
      'Tap the button below to add your first city and see its current weather.';
  static const String refreshAll = 'Refresh all';
  static String cancel = "Cancel";
  static String add = "Add";
  static String ok = "Ok";
  static const String addCityDialogTitle = 'Add City';
  static const String enterCityHint = 'Enter city name';
  static const String cityNameEmpty = 'City name cannot be empty';
  static const String removeCityTitle = 'Remove City';
  static const String remove = 'Remove';
  static String removeCityMessage(String city) =>
      'Do you want to remove $city?';
  static String cityRemoved(String city) => '$city removed';
  static String tempCelsius(double temp) => '${temp.round()}°C';
  static String humidityPercent(int value) => '$value%';
}
