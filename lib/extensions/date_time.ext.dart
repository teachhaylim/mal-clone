import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String formatDate({String pattern = "MMM dd, yyyy", String locale = "en-US"}) {
    final formatter = DateFormat(pattern, locale);
    return formatter.format(this);
  }
}
