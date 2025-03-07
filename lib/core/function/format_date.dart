import 'package:intl/intl.dart';

String formatDate(String dateString) {
  try {
    final DateTime dateTime = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('d MMMM, y');
    return formatter.format(dateTime);
  } catch (e) {
    return "Invalid date";
  }
}
