import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utils/app_size.dart';
import 'package:weather_app/utils/app_styles.dart';
import 'package:weather_app/utils/helper_utils.dart';
import '../models/forecast_model.dart';
import '../models/weather_location_model.dart';
import '../providers/weather_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';

class ForecastScreen extends StatefulWidget {
  final String cityName;

  const ForecastScreen({super.key, required this.cityName});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  late Future<List<ForecastModel>> _forecastFuture;

  @override
  void initState() {
    super.initState();
    final provider = context.read<WeatherProvider>();
    _forecastFuture = provider.loadForecast(widget.cityName);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();
    final currentWeather = provider.weatherData[widget.cityName];

    return Scaffold(
      appBar: AppBar(title: Text(widget.cityName), centerTitle: true),
      body: FutureBuilder<List<ForecastModel>>(
        future: _forecastFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(AppStrings.failedToLoadForecast));
          }

          final forecasts = snapshot.data!;

          return Column(
            children: [
              if (currentWeather != null)
                _weatherLocationHeaderWidget(currentWeather),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSize.s16,
                  AppSize.s16,
                  AppSize.s16,
                  AppSize.s8,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: AppSize.s32),
                    const SizedBox(width: AppSize.s8),
                    Text(
                      AppStrings.forecastTitle,
                      style: AppStyles.getBoldStyle(),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: forecasts.length,
                  itemBuilder: (context, index) {
                    return _forecastListWidget(forecasts[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _weatherLocationHeaderWidget(WeatherLocationModel weather) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSize.s16),
      color: AppColors.grey,
      child: Column(
        children: [
          Image.network(
            "https:${weather.currentCondition.condition.icon}",
            width: AppSize.s32,
            height: AppSize.s32,
            errorBuilder: (_, _, _) => const Icon(
              Icons.cloud,
              size: AppSize.s32,
              color: AppColors.grey,
            ),
          ),
          const SizedBox(height: AppSize.s8),
          Text(
            AppStrings.tempCelsius(weather.currentCondition.tempc),
            style: AppStyles.getLightStyle(),
          ),
          Text(
            weather.currentCondition.condition.text,
            style: AppStyles.getRegularStyle(),
          ),
          const SizedBox(height: AppSize.s8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _forecastInfoCard(
                Icons.water_drop_outlined,
                AppStrings.valuePercent(weather.currentCondition.windDegree),
              ),
              const SizedBox(width: AppSize.s16),
              _forecastInfoCard(
                Icons.air,
                AppStrings.windSpeed(weather.currentCondition.windKph),
              ),
              const SizedBox(width: AppSize.s16),
              _forecastInfoCard(
                Icons.thermostat_outlined,
                AppStrings.tempCelsius(weather.currentCondition.feelslikec),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _forecastInfoCard(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: AppSize.s32, color: AppColors.secondayColor),
        const SizedBox(width: AppSize.s8),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _forecastListWidget(ForecastModel forecast) {
    final dateStr = HelperUtils.formatDate(forecast.date!);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSize.s8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSize.s8),
              child: Row(
                children: [
                  Image.network(
                    "https:${forecast.day!.condition!.icon!}",
                    width: AppSize.s32,
                    height: AppSize.s32,
                    errorBuilder: (_, _, _) =>
                        const Icon(Icons.cloud, size: AppSize.s32),
                  ),
                  const SizedBox(width: AppSize.s16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(dateStr, style: AppStyles.getBoldStyle()),
                        Text(forecast.day!.condition!.text!),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        AppStrings.tempCelsius(forecast.day!.maxtempC!),
                        style: AppStyles.getBoldStyle(),
                      ),
                      Text(
                        AppStrings.tempCelsius(
                          forecast.day!.mintempC!.toDouble(),
                        ),
                        style: AppStyles.getLightStyle(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSize.s8),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppSize.s8,
                horizontal: AppSize.s8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _detailForecastWidget(
                    Icons.water_drop,
                    AppStrings.valuePercent(forecast.day!.avghumidity!),
                    AppStrings.humidity,
                  ),
                  _detailForecastWidget(
                    Icons.air,
                    AppStrings.windSpeed(forecast.day!.maxwindKph!),
                    AppStrings.wind,
                  ),
                  _detailForecastWidget(
                    Icons.umbrella,
                    AppStrings.valuePercent(forecast.day!.dailyChanceOfRain!),
                    AppStrings.rain,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSize.s8),
          Text(AppStrings.hourlyTitle, style: AppStyles.getBoldStyle()),
          const SizedBox(height: AppSize.s8),
          SizedBox(
            height: AppSize.s128,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: forecast.hour!.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSize.s8),
              itemBuilder: (context, index) {
                final hour = forecast.hour![index];
                return _forecastHourCard(hour);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailForecastWidget(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(
          icon,
          size: AppSize.s32,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: AppSize.s8),
        Text(value, style: AppStyles.getBoldStyle()),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _forecastHourCard(HourForecast hour) {
    final timeParts = hour.time!.split(' ');
    final displayTime = timeParts.length > 1 ? timeParts[1] : hour.time;

    return Card(
      elevation: AppSize.s8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.s8,
          vertical: AppSize.s8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(displayTime!, style: Theme.of(context).textTheme.bodySmall),
            Image.network(
              "https:${hour.condition!.icon!}",
              width: AppSize.s32,
              height: AppSize.s32,
              errorBuilder: (_, _, _) =>
                  const Icon(Icons.cloud, size: AppSize.s32),
            ),
            Text(
              AppStrings.tempCelsius(hour.tempC!),
              style: AppStyles.getBoldStyle(),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.water_drop,
                  size: AppSize.s16,
                  color: AppColors.seedColor,
                ),
                Text(
                  AppStrings.valuePercent(hour.chanceOfRain!),
                  style: AppStyles.getLightStyle(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
