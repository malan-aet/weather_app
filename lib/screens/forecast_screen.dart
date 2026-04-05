// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../models/forecast.dart';
// import '../models/weather_location_model.dart';
// import '../providers/weather_provider.dart';
// import '../utils/app_colors.dart';
// import '../utils/app_fonts.dart';
// import '../utils/app_strings.dart';
// import '../utils/app_theme.dart';

// class ForecastScreen extends StatefulWidget {
//   final String cityName;

//   const ForecastScreen({super.key, required this.cityName});

//   @override
//   State<ForecastScreen> createState() => _ForecastScreenState();
// }

// class _ForecastScreenState extends State<ForecastScreen> {
//   late Future<List<Forecast>> _forecastFuture;

//   @override
//   void initState() {
//     super.initState();
//     final provider = context.read<WeatherProvider>();
//     _forecastFuture = provider.loadForecast(widget.cityName);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<WeatherProvider>();
//     final currentWeather = provider.weatherData[widget.cityName];

//     return Scaffold(
//       appBar: AppBar(title: Text(widget.cityName), centerTitle: true),
//       body: FutureBuilder<List<Forecast>>(
//         future: _forecastFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError ||
//               !snapshot.hasData ||
//               snapshot.data!.isEmpty) {
//             return const Center(child: Text(AppStrings.forecastLoadError));
//           }

//           final forecasts = snapshot.data!;

//           return Column(
//             children: [
//               if (currentWeather != null) _buildCurrentHeader(currentWeather),
//               const Divider(height: 1),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(
//                   AppDimens.paddingDefault,
//                   AppDimens.spacingDefault,
//                   AppDimens.paddingDefault,
//                   AppDimens.spacingSmall,
//                 ),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.calendar_today, size: AppDimens.iconInfo),
//                     const SizedBox(width: AppDimens.spacingMedium),
//                     Text(
//                       AppStrings.forecastTitle,
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                         fontWeight: AppFonts.bold,
//                       ),
//                     ),
//                     const Spacer(),
//                     Text(
//                       AppStrings.swipeToBrowse,
//                       style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                         color: AppColors.swipeHintColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: PageView.builder(
//                   itemCount: forecasts.length,
//                   itemBuilder: (context, index) {
//                     return _buildForecastPage(forecasts[index]);
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildCurrentHeader(Weather weather) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(AppDimens.paddingLarge),
//       color: Theme.of(context).colorScheme.primaryContainer.withOpacity(
//         AppColors.headerContainerOpacity,
//       ),
//       child: Column(
//         children: [
//           Image.network(
//             weather.conditionIconUrl,
//             width: AppDimens.iconHeader,
//             height: AppDimens.iconHeader,
//             errorBuilder: (_, _, _) => const Icon(
//               Icons.cloud,
//               size: AppDimens.iconHeader,
//               color: AppColors.fallbackIconColor,
//             ),
//           ),
//           const SizedBox(height: AppDimens.spacingMedium),
//           Text(
//             AppStrings.tempCelsius(weather.tempCelsius),
//             style: Theme.of(
//               context,
//             ).textTheme.displaySmall?.copyWith(fontWeight: AppFonts.light),
//           ),
//           Text(
//             weather.conditionText,
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//           const SizedBox(height: AppDimens.spacingMedium),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _infoChip(
//                 Icons.water_drop_outlined,
//                 AppStrings.humidityPercent(weather.humidity),
//               ),
//               const SizedBox(width: AppDimens.spacingLarge),
//               _infoChip(Icons.air, AppStrings.windSpeed(weather.windKph)),
//               const SizedBox(width: AppDimens.spacingLarge),
//               _infoChip(
//                 Icons.thermostat_outlined,
//                 AppStrings.feelsLike(weather.feelsLikeCelsius),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _infoChip(IconData icon, String label) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(
//           icon,
//           size: AppDimens.iconDefault,
//           color: AppColors.infoChipIconColor,
//         ),
//         const SizedBox(width: AppDimens.spacingSmall),
//         Text(label, style: Theme.of(context).textTheme.bodySmall),
//       ],
//     );
//   }

//   Widget _buildForecastPage(Forecast forecast) {
//     final dateStr = _formatDate(forecast.date);

//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(AppDimens.paddingDefault),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Card(
//             child: Padding(
//               padding: const EdgeInsets.all(AppDimens.paddingDefault),
//               child: Row(
//                 children: [
//                   Image.network(
//                     forecast.conditionIconUrl,
//                     width: AppDimens.iconCard,
//                     height: AppDimens.iconCard,
//                     errorBuilder: (_, _, _) =>
//                         const Icon(Icons.cloud, size: AppDimens.iconCard),
//                   ),
//                   const SizedBox(width: AppDimens.spacingLarge),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           dateStr,
//                           style: Theme.of(context).textTheme.titleMedium
//                               ?.copyWith(fontWeight: AppFonts.bold),
//                         ),
//                         Text(forecast.conditionText),
//                       ],
//                     ),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         AppStrings.tempDegree(forecast.maxTempCelsius),
//                         style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                           fontWeight: AppFonts.bold,
//                         ),
//                       ),
//                       Text(
//                         AppStrings.tempDegree(forecast.minTempCelsius),
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                           color: AppColors.minTempColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: AppDimens.spacingMedium),
//           Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(AppDimens.cardRadiusSmall),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: AppDimens.spacingDefault,
//                 horizontal: AppDimens.paddingDefault,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   _detailColumn(
//                     Icons.water_drop,
//                     AppStrings.humidityPercent(forecast.avgHumidity),
//                     AppStrings.humidity,
//                   ),
//                   _detailColumn(
//                     Icons.air,
//                     AppStrings.windSpeed(forecast.maxWindKph),
//                     AppStrings.wind,
//                   ),
//                   _detailColumn(
//                     Icons.umbrella,
//                     AppStrings.rainPercent(forecast.chanceOfRain),
//                     AppStrings.rain,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: AppDimens.spacingDefault),
//           Text(
//             AppStrings.hourlyTitle,
//             style: Theme.of(
//               context,
//             ).textTheme.titleSmall?.copyWith(fontWeight: AppFonts.bold),
//           ),
//           const SizedBox(height: AppDimens.spacingMedium),
//           SizedBox(
//             height: AppDimens.hourlyChipHeight,
//             child: ListView.separated(
//               scrollDirection: Axis.horizontal,
//               itemCount: forecast.hours.length,
//               separatorBuilder: (_, _) =>
//                   const SizedBox(width: AppDimens.spacingSmall),
//               itemBuilder: (context, index) {
//                 final hour = forecast.hours[index];
//                 return _buildHourChip(hour);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _detailColumn(IconData icon, String value, String label) {
//     return Column(
//       children: [
//         Icon(
//           icon,
//           size: AppDimens.iconDetail,
//           color: Theme.of(context).colorScheme.primary,
//         ),
//         const SizedBox(height: AppDimens.spacingSmall),
//         Text(
//           value,
//           style: Theme.of(
//             context,
//           ).textTheme.bodyMedium?.copyWith(fontWeight: AppFonts.bold),
//         ),
//         Text(label, style: Theme.of(context).textTheme.bodySmall),
//       ],
//     );
//   }

//   Widget _buildHourChip(HourForecast hour) {
//     final timeParts = hour.time.split(' ');
//     final displayTime = timeParts.length > 1 ? timeParts[1] : hour.time;

//     return Card(
//       elevation: AppDimens.cardElevationSmall,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppDimens.cardRadiusSmall),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: AppDimens.spacingDefault,
//           vertical: AppDimens.spacingMedium,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(displayTime, style: Theme.of(context).textTheme.bodySmall),
//             Image.network(
//               hour.conditionIconUrl,
//               width: AppDimens.iconHourly,
//               height: AppDimens.iconHourly,
//               errorBuilder: (_, _, _) =>
//                   const Icon(Icons.cloud, size: AppDimens.iconHourly),
//             ),
//             Text(
//               AppStrings.tempDegree(hour.tempCelsius),
//               style: Theme.of(
//                 context,
//               ).textTheme.bodyMedium?.copyWith(fontWeight: AppFonts.bold),
//             ),
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   Icons.water_drop,
//                   size: AppDimens.iconSmall,
//                   color: AppColors.humidityIconColor,
//                 ),
//                 Text(
//                   AppStrings.rainPercent(hour.chanceOfRain),
//                   style: Theme.of(context).textTheme.labelSmall,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _formatDate(String dateStr) {
//     try {
//       final date = DateFormat(AppStrings.dateFormatInput).parse(dateStr);
//       return DateFormat(AppStrings.dateFormatDisplay).format(date);
//     } catch (_) {
//       return dateStr;
//     }
//   }
// }
