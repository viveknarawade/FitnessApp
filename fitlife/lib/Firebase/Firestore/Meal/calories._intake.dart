import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';

class CaloriesIntake {
 static int dayCalories = 0;

  Future<void> addDayCaloriesData(String caloriesString) async {
    // First get the current calorie intake data from Firestore
    await getCaloriesIntakeData();

    // Now calculate and add the new calories to dayCalories
    calculateCalories(caloriesString);

    // After updating, store the new total back to Firestore as a string
    await db
        .collection("Calories")
        .doc(userData[0].id)
        .collection("Intake")
        .doc("vk0OlXNJn4H0t2bGJwbT") // Specify the document ID
        .update({
      "DailyIntake": dayCalories.toString(),
    });

    log("Calories data added");
  }

  void calculateCalories(String caloriesString) {
    caloriesString = caloriesString.trim();

    double? caloriesDouble = double.tryParse(caloriesString);
    if (caloriesDouble != null) {
      int calories = caloriesDouble.toInt();
      log("Calories int: $calories");
      dayCalories += calories;
    } else {
      log("Failed to parse calories string: '$caloriesString'");
    }
    log("Total calories for today: $dayCalories");
  }

  Future<void> getCaloriesIntakeData() async {
    try {
      // Fetch all documents in the 'Intake' collection for this user
      QuerySnapshot caloriesResponse = await db
          .collection("Calories")
          .doc(userData[0].id)
          .collection("Intake")
          .get();

      // Iterate over the retrieved documents
      for (var doc in caloriesResponse.docs) {
        // Fetch 'DailyIntake' and handle it
        var dailyIntake = doc["DailyIntake"];

        // Convert DailyIntake to int safely
        int dailyIntakeInt = int.tryParse(dailyIntake.toString()) ?? 0;
        dayCalories += dailyIntakeInt; // Add to dayCalories
      }

      log("Total calories from Firestore: $dayCalories");
    } catch (e) {
      log("Error fetching calorie intake data: $e");
    }
  }
}
