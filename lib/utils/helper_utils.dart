import 'package:intl/intl.dart';
import 'package:weather_app/utils/app_constant.dart';

class HelperUtils {
  static String formatDate(String dateStr) {
    try {
      final date = DateFormat(AppConstants.dateFormatInput).parse(dateStr);
      return DateFormat(AppConstants.dateFormatDisplay).format(date);
    } catch (_) {
      return dateStr;
    }
  }
}
