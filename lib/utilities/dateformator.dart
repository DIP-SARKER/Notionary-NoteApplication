import 'package:intl/intl.dart';

String formatDateTime(String? dateTime) {
  DateTime dt = dateTime != null ? DateTime.parse(dateTime) : DateTime.now();
  return DateFormat(
    'MMM dd, yyyy,  hh:mm a',
  ).format(DateTime.parse(dt.toIso8601String()));
}
