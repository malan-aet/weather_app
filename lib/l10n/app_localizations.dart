import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Weather App'**
  String get appTitle;

  /// No description provided for @enterCityName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a city name.'**
  String get enterCityName;

  /// No description provided for @failedToLoadWeather.
  ///
  /// In en, this message translates to:
  /// **'Failed to load weather data.'**
  String get failedToLoadWeather;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get somethingWentWrong;

  /// No description provided for @cityAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'{city} is already in your list.'**
  String cityAlreadyExists(String city);

  /// No description provided for @failedToLoadForecast.
  ///
  /// In en, this message translates to:
  /// **'Failed to load forecast data.'**
  String get failedToLoadForecast;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get homeTitle;

  /// No description provided for @addCity.
  ///
  /// In en, this message translates to:
  /// **'Add City'**
  String get addCity;

  /// No description provided for @removeCity.
  ///
  /// In en, this message translates to:
  /// **'Remove city'**
  String get removeCity;

  /// No description provided for @noCitiesTitle.
  ///
  /// In en, this message translates to:
  /// **'No cities added yet'**
  String get noCitiesTitle;

  /// No description provided for @noCitiesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap the button below to add your first city and see its current weather.'**
  String get noCitiesSubtitle;

  /// No description provided for @refreshAll.
  ///
  /// In en, this message translates to:
  /// **'Refresh all'**
  String get refreshAll;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @addCityDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Add City'**
  String get addCityDialogTitle;

  /// No description provided for @enterCityHint.
  ///
  /// In en, this message translates to:
  /// **'Enter city name'**
  String get enterCityHint;

  /// No description provided for @cityNameEmpty.
  ///
  /// In en, this message translates to:
  /// **'City name cannot be empty'**
  String get cityNameEmpty;

  /// No description provided for @removeCityTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove City'**
  String get removeCityTitle;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @removeCityMessage.
  ///
  /// In en, this message translates to:
  /// **'Do you want to remove {city}?'**
  String removeCityMessage(String city);

  /// No description provided for @cityRemoved.
  ///
  /// In en, this message translates to:
  /// **'{city} removed'**
  String cityRemoved(String city);

  /// No description provided for @tempCelsius.
  ///
  /// In en, this message translates to:
  /// **'{temp}°C'**
  String tempCelsius(int temp);

  /// No description provided for @valuePercent.
  ///
  /// In en, this message translates to:
  /// **'{value}%'**
  String valuePercent(int value);

  /// No description provided for @windSpeed.
  ///
  /// In en, this message translates to:
  /// **'{kph} km/h'**
  String windSpeed(double kph);

  /// No description provided for @humidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidity;

  /// No description provided for @wind.
  ///
  /// In en, this message translates to:
  /// **'Wind'**
  String get wind;

  /// No description provided for @rain.
  ///
  /// In en, this message translates to:
  /// **'Rain'**
  String get rain;

  /// No description provided for @forecastTitle.
  ///
  /// In en, this message translates to:
  /// **'3-Day Forecast'**
  String get forecastTitle;

  /// No description provided for @hourlyTitle.
  ///
  /// In en, this message translates to:
  /// **'Hourly'**
  String get hourlyTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
