import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';
import 'package:fitlife/Model/session_data.dart';
import 'package:intl/intl.dart';

class WorkoutCalories {
  List<Map<String, dynamic>> fullbody = [];
  List<Map<String, dynamic>> upperbody = [];
  List<Map<String, dynamic>> lowerbody = [];

  Future<void> addWorkoutData(
      String category, Map<String, dynamic> tempMealData) async {
    String dayAndDateId = generateDayDateDocumentId();
    if (category == "FullBody") {
      fullbody.clear();
      fullbody.add(tempMealData);
      for (int i = 0; i < fullbody.length; i++) {
        await db
            .collection("Workout")
            .doc(SessionData.id)
            .collection("dayDate")
            .doc(dayAndDateId)
            .collection("Category")
            .doc("FullBody")
            .collection("Workout_items")
            .add(fullbody[i]);
      }
      log("FullBody data added");
    }
    if (category == "LowerBody") {
      lowerbody.clear();
      lowerbody.add(tempMealData);
      for (int i = 0; i < lowerbody.length; i++) {
        await db
            .collection("Workout")
            .doc(SessionData.id)
            .collection("dayDate")
            .doc(dayAndDateId)
            .collection("Category")
            .doc("LowerBody")
            .collection("Workout_items")
            .add(lowerbody[i]);
      }
      log("lowerbody data added");
    }
    if (category == "UpperBody") {
      upperbody.clear();
      upperbody.add(tempMealData);
      for (int i = 0; i < upperbody.length; i++) {
        await db
            .collection("Workout")
            .doc(SessionData.id)
            .collection("dayDate")
            .doc(dayAndDateId)
            .collection("Category")
            .doc("UpperBody")
            .collection("Workout_items")
            .add(upperbody[i]);
      }
      log("upperbody data added");
    }
  }

  String generateDayDateDocumentId() {
    DateTime date = DateTime.now(); // Get the current date
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(date); // Format the date as YYYY-MM-DD
    String weekday = DateFormat('EEEE')
        .format(date); // Full weekday name (Sunday, Monday, etc.)
    return '$weekday-$formattedDate';
  }

  // Function to fetch data for a specific category from Firestore
  Future<List<Map<String, dynamic>>> fetchWorkoutDataForCategory(
      String category) async {
    String dayAndDateId = generateDayDateDocumentId();
    List<Map<String, dynamic>> workoutDataList = [];
    try {
      QuerySnapshot mealResponse = await db
          .collection("Workout")
          .doc(SessionData.id)
          .collection("dayDate")
          .doc(dayAndDateId)
          .collection("Category")
          .doc(category)
          .collection("Workout_items")
          .get();

      for (var doc in mealResponse.docs) {
        Map<String, dynamic> tempFoodItem = {
          "WorkoutName": doc["WorkoutName"],
          "burn": doc["burn"],
        };
        workoutDataList.add(tempFoodItem);
      }
      log("${workoutDataList}");
    } catch (e) {
      print("Error fetching $category data: $e");
    }
    return workoutDataList;
  }

  Future<num> getTotalCalories(String category) async {
    String dayAndDateId = generateDayDateDocumentId();
    num TotalCalories = 0; // Corrected to int type
    try {
      QuerySnapshot mealResponse = await db
          .collection("Workout")
          .doc(SessionData.id)
          .collection("dayDate")
          .doc(dayAndDateId)
          .collection("Category")
          .doc(category)
          .collection("Workout_items")
          .get();

      for (var doc in mealResponse.docs) {
        TotalCalories += doc["burn"]; // Accumulate calories as integers
      }

      log("Total calories burned: $TotalCalories");
    } catch (e) {
      print("Error fetching $category data: $e");
    }
    return TotalCalories;
  }
}
