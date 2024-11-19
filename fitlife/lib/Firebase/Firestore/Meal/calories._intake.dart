import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlife/Dashboard/home_ui.dart';
import 'package:fitlife/Firebase/Firestore/Meal/meal_Intake.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';
import 'package:fitlife/Model/session_data.dart';

class CaloriesIntake {
  static int dayCalories = 0;

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
  Future<void> addDayCaloriesData(String caloriesString) async {
    await getCaloriesIntakeData();
    calculateCalories(caloriesString);

    String dayAndDateId = MealIntake().generateDayDateDocumentId();
    log("Adding calories with docId: $dayAndDateId");

    try {
      await db
          .collection("Calories")
          .doc(SessionData.id)
          .collection("dayDate")
          .doc(dayAndDateId)
          .collection("Intake")
          .doc("total_calories")
          .set({
        "DailyIntake": dayCalories.toString(),
      });

      log("Calories data added successfully for docId: $dayAndDateId");
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
      dayCalories += calories;
    } else {
      log("Failed to parse calories string: '$caloriesString'");
    }
    log("Total calories for today: $dayCalories");
  }

  // Fetch calories for current day
  Future<int> getCaloriesIntakeData() async {
    try {
      String dayAndDateId = MealIntake().generateDayDateDocumentId();
 

      var docSnapshot = await db
          .collection("Calories")
          .doc(SessionData.id)
          .collection("dayDate")
          .doc(dayAndDateId)
          .collection("Intake")
          .doc("total_calories")
          .get();

      dayCalories = 0;

      if (docSnapshot.exists) {
        var dailyIntake = docSnapshot.data()?["DailyIntake"] ?? "0";
        dayCalories = int.tryParse(dailyIntake.toString()) ?? 0;
      }

    } catch (e) {
      log("Error fetching calorie intake data: $e");
    }

    return dayCalories;
  }

  // Updated method to fetch weekly calories with proper handling of missing data
  Future<Map<String, String>> getWeeklyCaloriesData() async {
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

       

        try {
          var docSnapshot = await db
              .collection("Calories")
              .doc(SessionData.id)
              .collection("dayDate")
              .doc(docId)
              .collection("Intake")
              .doc("total_calories")
              .get();

          if (docSnapshot.exists) {
            var dailyIntake = docSnapshot.data()?["DailyIntake"] ?? "0";
            weeklyCalories[dayName] = dailyIntake;
       
          } else {
            log("No data found for $dayName with docId: $docId");
          }
        } catch (e) {
          log("Error fetching data for $dayName: $e");
        }
      }

    } catch (e) {
      log("Error in getWeeklyCaloriesData: $e");
    }

    return weeklyCalories;
  }
}
