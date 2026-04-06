import 'package:flutter/material.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/data/models/weather_location_model.dart';
import 'package:weather_app/core/utils/app_styles.dart';
import 'package:weather_app/core/utils/app_size.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/app_fonts.dart';

class WeatherCard extends StatelessWidget {
  final WeatherLocationModel weather;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const WeatherCard({
    super.key,
    required this.weather,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSize.s8,
        vertical: AppSize.s8,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSize.s16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSize.s8),
          child: Row(
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
              const SizedBox(width: AppSize.s32),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weather.location.name,
                      style: AppStyles.getLightStyle(),
                    ),
                    const SizedBox(height: AppSize.s8),
                    Text(
                      weather.location.country,
                      style: AppStyles.getLightStyle(fontSize: AppFonts.s10),
                    ),
                    const SizedBox(height: AppSize.s8),
                    Text(
                      weather.currentCondition.condition.text,
                      style: AppStyles.getRegularStyle(),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    l10n.tempCelsius(weather.currentCondition.tempc.toInt()),
                    style: AppStyles.getLightStyle(),
                  ),
                  const SizedBox(height: AppSize.s8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.water_drop_outlined,
                        size: AppSize.s32,
                        color: AppColors.grey,
                      ),
                      const SizedBox(width: AppSize.s8),
                      Text(
                        l10n.valuePercent(weather.currentCondition.humidity),
                        style: AppStyles.getRegularStyle(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: AppSize.s8),
              IconButton(
                icon: Icon(
                  Icons.close,
                  size: AppSize.s32,
                  color: AppColors.seedColor,
                ),
                onPressed: onDelete,
                tooltip: l10n.removeCity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
