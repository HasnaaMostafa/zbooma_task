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

String formatDateHome(DateTime date) {
  String day = date.day.toString().padLeft(2, '0');
  
  String month = date.month.toString().padLeft(2, '0');
  
  String year = date.year.toString();
  return "$day/$month/$year";
}


String formatDateFromString(String dateString) {
  try {
    DateTime date = DateTime.parse(dateString);
    return formatDateHome(date);
  } catch (e) {
    return "Invalid date format";
  }
}