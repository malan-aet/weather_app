import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/utils/app_size.dart';
import '../providers/weather_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import '../widgets/weather_card.dart';
import '../widgets/add_city_dialog.dart';
import 'forecast_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeatherProvider>().fetchSavedCities();
    });
  }

  Future<void> _showAddCityDialog() async {
    final cityName = await showDialog<String>(
      context: context,
      builder: (ctx) => const AddCityDialog(),
    );

    if (cityName != null && cityName.isNotEmpty && mounted) {
      final provider = context.read<WeatherProvider>();
      await provider.addCity(cityName);

      if (provider.errorMessage != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.errorMessage!),
            action: SnackBarAction(
              label: AppStrings.ok,
              onPressed: () => provider.clearError(),
            ),
          ),
        );
        provider.clearError();
      }
    }
  }

  void _deleteCity(String cityName) {
    final provider = context.read<WeatherProvider>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(AppStrings.removeCityTitle),
        content: Text(AppStrings.removeCityMessage(cityName)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(AppStrings.cancel),
          ),
          FilledButton(
            onPressed: () {
              provider.removeCity(cityName);
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppStrings.cityRemoved(cityName)),
                  duration: const Duration(seconds: 10),
                ),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: AppColors.redAccent),
            child: const Text(AppStrings.remove),
          ),
        ],
      ),
    );
  }

  void _openForecast(String cityName) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(builder: (_) => ForecastScreen(cityName: cityName)),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.homeTitle),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: AppStrings.refreshAll,
            onPressed: () {
              context.read<WeatherProvider>().refreshAllCities();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddCityDialog,
        icon: const Icon(Icons.add),
        label: const Text(AppStrings.addCity),
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.weatherData.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.weatherData.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cloud_outlined,
                      size: 24.0,
                      color: AppColors.grey,
                    ),
                    SizedBox(height: AppSize.s16),
                    Text(
                      AppStrings.noCitiesTitle,
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: AppColors.grey),
                    ),
                    const SizedBox(height: AppSize.s16),
                    Text(
                      AppStrings.noCitiesSubtitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                    ),
                  ],
                ),
              ),
            );
          }

          final weatherEntries = provider.weatherData.values.toList();

          return RefreshIndicator(
            onRefresh: () => provider.refreshAllCities(),
            child: ListView.builder(
              padding: const EdgeInsets.only(
                top: AppSize.s8,
                bottom: AppSize.s8,
              ),
              itemCount: weatherEntries.length,
              itemBuilder: (context, index) {
                final weather = weatherEntries[index];
                return WeatherCard(
                  weather: weather,
                  onDelete: () => _deleteCity(weather.location.name),
                  onTap: () => _openForecast(weather.location.name),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
