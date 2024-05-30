import 'package:intl/intl.dart';

String reformatDate(String dateString) {
  // Parse the string into a DateTime object
  DateTime dateTime = DateTime.parse(dateString);

  // Define the desired date format pattern
  String pattern = 'yyyy-MM-dd';

  // Format the DateTime object using the pattern
  String formattedDate = DateFormat(pattern).format(dateTime);

  return formattedDate;
}