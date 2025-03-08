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

/// Example of how to use:
/// 
/// // Using with DateTime object
/// String formattedDate = formatDate(DateTime.now());
/// 
/// // Using with ISO string
/// String formattedFromString = formatDateFromString("2022-12-30T14:30:00Z");