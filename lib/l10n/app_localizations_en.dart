// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Weather App';

  @override
  String get enterCityName => 'Please enter a city name.';

  @override
  String get failedToLoadWeather => 'Failed to load weather data.';

  @override
  String get somethingWentWrong => 'Something went wrong. Please try again.';

  @override
  String cityAlreadyExists(String city) {
    return '$city is already in your list.';
  }

  @override
  String get failedToLoadForecast => 'Failed to load forecast data.';

  @override
  String get homeTitle => 'Weather';

  @override
  String get addCity => 'Add City';

  @override
  String get removeCity => 'Remove city';

  @override
  String get noCitiesTitle => 'No cities added yet';

  @override
  String get noCitiesSubtitle =>
      'Tap the button below to add your first city and see its current weather.';

  @override
  String get refreshAll => 'Refresh all';

  @override
  String get cancel => 'Cancel';

  @override
  String get add => 'Add';

  @override
  String get ok => 'Ok';

  @override
  String get addCityDialogTitle => 'Add City';

  @override
  String get enterCityHint => 'Enter city name';

  @override
  String get cityNameEmpty => 'City name cannot be empty';

  @override
  String get removeCityTitle => 'Remove City';

  @override
  String get remove => 'Remove';

  @override
  String removeCityMessage(String city) {
    return 'Do you want to remove $city?';
  }

  @override
  String cityRemoved(String city) {
    return '$city removed';
  }

  @override
  String tempCelsius(int temp) {
    return '$temp°C';
  }

  @override
  String valuePercent(int value) {
    return '$value%';
  }

  @override
  String windSpeed(double kph) {
    final intl.NumberFormat kphNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String kphString = kphNumberFormat.format(kph);

    return '$kphString km/h';
  }

  @override
  String get humidity => 'Humidity';

  @override
  String get wind => 'Wind';

  @override
  String get rain => 'Rain';

  @override
  String get forecastTitle => '3-Day Forecast';

  @override
  String get hourlyTitle => 'Hourly';
}
