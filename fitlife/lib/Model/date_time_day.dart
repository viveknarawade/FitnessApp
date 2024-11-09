import 'package:intl/intl.dart';

class DateTimeDay {
  String? formattedTime;
  String? formattedDate;
  String? dayOfWeek;

  // Constructor to initialize the DateTimeDay object
  DateTimeDay() {
    DateTime now = DateTime.now();

    // Format the time to 'hh.mm a' (07.00 AM format)
    formattedTime = DateFormat('hh.mm a').format(now);

    // Get the current date in 'dd MMM yyyy' format (e.g., 10 Nov 2024)
    formattedDate = DateFormat('dd MMM yyyy').format(now);

    // Get the day of the week (e.g., Sunday)
    dayOfWeek = getDayOfWeek(now.weekday);
  }

  // Convert weekday number (1-7) to the corresponding day name
  String getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "";
    }
  }
}


