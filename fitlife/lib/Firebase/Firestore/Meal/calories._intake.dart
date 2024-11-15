import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlife/Dashboard/home_ui.dart';
import 'package:fitlife/Firebase/Firestore/Meal/meal_Intake.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';

class CaloriesIntake {
  static int dayCalories = 0;

  Future<void> addDayCaloriesData(String caloriesString) async {
    // First, get the current calorie intake data from Firestore
    await getCaloriesIntakeData();

    // Now calculate and add the new calories to dayCalories
    calculateCalories(caloriesString);

    String dayAndDateId = MealIntake().generateDayDateDocumentId();

    try {
      // Store the updated total calorie intake back to Firestore
      await db
          .collection("Calories")
          .doc(userData[0].id) // Use dynamic user ID
          .collection("dayDate")
          .doc(dayAndDateId) // Dynamically generated day and date document ID
          .collection("Intake")
          .doc("total_calories") // Use a fixed or dynamic document ID
          .set({
        "DailyIntake": dayCalories.toString(),
      });

      log("Calories data added successfully");
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

  Future<int> getCaloriesIntakeData() async {
    try {
      String dayAndDateId = MealIntake().generateDayDateDocumentId();

      // Fetch all documents in the 'Intake' collection for this user
      QuerySnapshot caloriesResponse = await db
          .collection("Calories")
          .doc(userData[0].id) // Use dynamic user ID
          .collection("dayDate")
          .doc(dayAndDateId)
          .collection("Intake")
          .get();

      // Reset dayCalories before summing up values
      dayCalories = 0;

      // Iterate over the retrieved documents and sum calories
      for (var doc in caloriesResponse.docs) {
        var dailyIntake = doc["DailyIntake"];

        // Ensure the value exists and is a valid integer
        int dailyIntakeInt = int.tryParse(dailyIntake.toString()) ?? 0;
        dayCalories += dailyIntakeInt;
      }

      log("Total calories fetched from Firestore: $dayCalories");
    } catch (e) {
      log("Error fetching calorie intake data: $e");
    }

    return dayCalories;
  }
}
