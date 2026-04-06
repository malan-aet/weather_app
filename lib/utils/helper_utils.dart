import 'package:intl/intl.dart';
import 'package:weather_app/utils/app_strings.dart';

class HelperUtils {
  static String formatDate(String dateStr) {
    try {
      final date = DateFormat(AppStrings.dateFormatInput).parse(dateStr);
      return DateFormat(AppStrings.dateFormatDisplay).format(date);
    } catch (_) {
      return dateStr;
    }
  }
}
