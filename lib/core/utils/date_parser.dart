import 'package:intl/intl.dart';

class DateParser {
  DateParser._();

  static DateTime? parseIsoString(String? isoString) {
    if (isoString == null || isoString.isEmpty) return null;
    try {
      return DateTime.parse(isoString).toLocal();
    } catch (_) {
      return null;
    }
  }

  static String toShortDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String toLongDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat.yMMMMd().format(date);
  }

  static String toTime(DateTime? date) {
    if (date == null) return '';
    return DateFormat('HH:mm').format(date);
  }

  static String toIsoString(DateTime? date) {
    if (date == null) return '';
    return date.toUtc().toIso8601String();
  }
}
