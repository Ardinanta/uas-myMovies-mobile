import 'package:intl/intl.dart';

abstract class DateFormatter {
  const DateFormatter._();

  static String formatMovieDate(String? value) {
    if (value == null || value.isEmpty) {
      return '-';
    }

    final date = DateTime.tryParse(value);
    if (date == null) {
      return value;
    }

    return DateFormat('dd MMM yyyy').format(date);
  }

  static String year(String? value) {
    final date = value == null ? null : DateTime.tryParse(value);
    return date?.year.toString() ?? '-';
  }
}
