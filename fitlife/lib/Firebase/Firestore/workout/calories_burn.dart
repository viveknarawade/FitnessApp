import 'dart:developer';

import 'package:fitlife/Firebase/Firestore/Meal/meal_Intake.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';

class CaloriesBurn {
  static int dayBurnCalories = 0;

  // Helper method to get the full day name from a date
  String _getDayName(DateTime date) {
    switch (date.weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }

  // Helper method to generate document ID for a specific date
  String _generateDocIdForDate(DateTime date) {
    String dayName = _getDayName(date);
    String formattedDate = "$dayName-${date.year}-${date.month}-${date.day}";
    log("Generated docId: $formattedDate");
    return formattedDate;
  }

  // Add calories for current day
  Future<void> addDayBurnCaloriesData(String caloriesString) async {
    await getCaloriesBurnData();
    calculateCalories(caloriesString);

    String dayAndDateId = MealIntake().generateDayDateDocumentId();
    log("Adding calories with docId: $dayAndDateId");

    try {
      await db
          .collection("Calories")
          .doc(userData[0].id)
          .collection("dayDate")
          .doc(dayAndDateId)
          .collection("Burn")
          .doc("total_Burn_calories")
          .set({
        "DailyBurn": dayBurnCalories.toString(),
      });

      log("Calories data added successfully for docId: $dayAndDateId");
      log("Calories data : $dayBurnCalories");
    } catch (e) {
      log("Error adding calorie data: $e");
    }
  }

  void calculateCalories(String caloriesString) {
    caloriesString = caloriesString.trim();
    double? caloriesDouble = double.tryParse(caloriesString);
    if (caloriesDouble != null) {
      int calories = caloriesDouble.toInt();
      log("Calories added: $calories");
      dayBurnCalories += calories;
    } else {
      log("Failed to parse calories string: '$caloriesString'");
    }
    log("Total calories for today: $dayBurnCalories");
  }

  // Fetch calories for current day
  Future<int> getCaloriesBurnData() async {
    try {
      String dayAndDateId = MealIntake().generateDayDateDocumentId();
      log("Fetching calories for docId: $dayAndDateId");

      var docSnapshot = await db
          .collection("Calories")
          .doc(userData[0].id)
          .collection("dayDate")
          .doc(dayAndDateId)
          .collection("Burn")
          .doc("total_Burn_calories")
          .get();

      dayBurnCalories = 0;

      if (docSnapshot.exists) {
        var dailyIntake = docSnapshot.data()?["DailyBurn"] ?? "0";
        dayBurnCalories = int.tryParse(dailyIntake.toString()) ?? 0;
      }

      log("Total calories fetched from Firestore: $dayBurnCalories");
    } catch (e) {
      log("Error fetching calorie intake data: $e");
    }

    return dayBurnCalories;
  }

  // Updated method to fetch weekly calories with proper handling of missing data
  Future<Map<String, String>> getWeeklyCaloriesBurnData() async {
    Map<String, String> weeklyCalories = {
      'Monday': '0',
      'Tuesday': '0',
      'Wednesday': '0',
      'Thursday': '0',
      'Friday': '0',
      'Saturday': '0',
      'Sunday': '0'
    };

    try {
      // Get current date
      DateTime now = DateTime.now();

      // Calculate the start of the week (Sunday)
      DateTime startOfWeek = now.subtract(Duration(days: now.weekday % 7));

      // Fetch data for each day of the week
      for (int i = 0; i < 7; i++) {
        DateTime currentDate = startOfWeek.add(Duration(days: i));
        String docId = _generateDocIdForDate(currentDate);
        String dayName = _getDayName(currentDate);

        log("Checking day: $dayName with docId: $docId");

        try {
          var docSnapshot = await db
              .collection("Calories")
              .doc(userData[0].id)
              .collection("dayDate")
              .doc(docId)
              .collection("Burn")
              .doc("total_Burn_calories")
              .get();

          if (docSnapshot.exists) {
            var dailyIntake = docSnapshot.data()?["DailyBurn"] ?? "0";
            weeklyCalories[dayName] = dailyIntake;
            log("Found calories for $dayName: $dailyIntake (docId: $docId)");
          } else {
            log("No data found for $dayName with docId: $docId");
          }
        } catch (e) {
          log("Error fetching data for $dayName: $e");
        }
      }

      log("Weekly calories data fetched successfully: $weeklyCalories");
    } catch (e) {
      log("Error in getWeeklyCaloriesData: $e");
    }

    return weeklyCalories;
  }
}
