import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/core/utils/app_size.dart';
import '../providers/weather_provider.dart';
import '../core/utils/app_colors.dart';
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
    final l10n = AppLocalizations.of(context)!;
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
              label: l10n.ok,
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
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.removeCityTitle),
        content: Text(l10n.removeCityMessage(cityName)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              provider.removeCity(cityName);
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.cityRemoved(cityName)),
                  duration: const Duration(seconds: 10),
                ),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: AppColors.redAccent),
            child: Text(l10n.remove),
          ),
        ],
      ),
    );
  }

  void _openForecast(String cityName) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ForecastScreen(cityName: cityName)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeTitle),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: l10n.refreshAll,
            onPressed: () {
              context.read<WeatherProvider>().refreshAllCities();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddCityDialog,
        icon: const Icon(Icons.add),
        label: Text(l10n.addCity),
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, _) {
          if (weatherProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (weatherProvider.weatherData.isEmpty) {
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
                      l10n.noCitiesTitle,
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: AppColors.grey),
                    ),
                    const SizedBox(height: AppSize.s16),
                    Text(
                      l10n.noCitiesSubtitle,
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

          final weatherList = weatherProvider.weatherData.values.toList();

          return RefreshIndicator(
            onRefresh: () => weatherProvider.refreshAllCities(),
            child: ListView.builder(
              padding: const EdgeInsets.only(
                top: AppSize.s8,
                bottom: AppSize.s8,
              ),
              itemCount: weatherList.length,
              itemBuilder: (context, index) {
                final weather = weatherList[index];
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
