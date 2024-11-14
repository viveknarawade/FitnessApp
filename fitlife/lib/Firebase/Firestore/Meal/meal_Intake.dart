import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';
import 'package:fitlife/Firebase/Storage/fooddata.dart';
import 'package:intl/intl.dart';

List mealBreakfast = [];
List mealLunch = [];
List mealDinner = [];

class MealIntake {
  // Lists to store data for each category

  List<Map<String, dynamic>> mealBreakfastData = [];
  List<Map<String, dynamic>> mealLunchData = [];
  List<Map<String, dynamic>> mealDinnerData = [];

  // Method to add meal data to Firestore
  Future<void> addMealData(
      String category, Map<String, dynamic> tempMealData) async {
    String dayAndDateId = generateDayDateDocumentId();
    if (category == "Breakfast") {
      mealBreakfast.clear();
      mealBreakfast.add(tempMealData);
      for (int i = 0; i < mealBreakfast.length; i++) {
        await db
            .collection("Meal") // Meal collection
            .doc(userData[0].id) // Use the actual user ID dynamically
            .collection("dayDate")
            .doc(dayAndDateId) // Day document (e.g., "Sunday_2024-11-14")
            .collection("Category") // Category subcollection
            .doc("Breakfast") // Document for Breakfast category
            .collection("items") // items subcollection for meal items
            .add(mealBreakfast[i]); // Add the meal data
      }
      log("Meal breakfast data added ");
    }
    if (category == "Lunch") {
      mealLunch.clear();
      mealLunch.add(tempMealData);
      for (int i = 0; i < mealLunch.length; i++) {
        await db
            .collection("Meal")
            .doc(userData[0].id)
            .collection("dayDate")
            .doc(dayAndDateId) // Use the actual user ID dynamically
            .collection("Category")
            .doc("Lunch") // Document for Lunch category
            .collection("items")
            .add(mealLunch[i]); // Correct reference to mealLunch
      }
      print("Meal lunch data added");
    }
    if (category == "Dinner") {
      mealDinner.clear();
      mealDinner.add(tempMealData);
      for (int i = 0; i < mealDinner.length; i++) {
        await db
            .collection("Meal")
            .doc(userData[0].id)
            .collection("dayDate")
            .doc(dayAndDateId)
            .collection("Category")
            .doc("Dinner") // Document for Dinner category
            .collection("items")
            .add(mealDinner[i]); // Correct reference to mealDinner
      }
      print("Meal dinner data added");
    }
  }

  String generateDayDateDocumentId() {
    DateTime date = DateTime.now(); // Get the current date

    // Format the date as YYYY-MM-DD
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    // Get the weekday (e.g., "Sunday")
    String weekday = DateFormat('EEEE')
        .format(date); // Full weekday name (Sunday, Monday, etc.)

    // Combine the weekday and formatted date (e.g., "Sunday_2024-11-14")
    return '$weekday-$formattedDate';
  }

  // Method to fetch meal data for each category
  Future<void> getMealData() async {
    // Fetch data for each category
    mealBreakfastData = await _fetchMealDataForCategory("Breakfast");
    log("Breakfast data: $mealBreakfastData");

    mealLunchData = await _fetchMealDataForCategory("Lunch");
    log("Lunch data: $mealLunchData");

    mealDinnerData = await _fetchMealDataForCategory("Dinner");
    log("Dinner data: $mealDinnerData");
  }

  // Function to fetch data for a specific category from Firestore
  Future<List<Map<String, dynamic>>> _fetchMealDataForCategory(
      String category) async {
    String dayAndDateId = generateDayDateDocumentId();
    List<Map<String, dynamic>> mealDataList = [];
    try {
      QuerySnapshot mealResponse = await db
          .collection("Meal")
          .doc(userData[0].id) // Fetch data for the specific user
          .collection("dayDate")
          .doc(dayAndDateId)
          .collection("Category")
          .doc(category) // Dynamically use the category
          .collection("items")
          .get();

      for (var doc in mealResponse.docs) {
        Map<String, dynamic> tempFoodItem = {
          "food_item": doc["food_item"],
          "calories": doc["calories"],
          "protein": doc["protein"],
          "fat": doc["fat"],
          "carbs": doc["carbs"],
          "Time": doc["Time"],
          "Day": doc["Day"],
          "Date": doc["Date"],
          "description": doc["description"],
        };
        mealDataList.add(tempFoodItem);
      }
    } catch (e) {
      print("Error fetching $category data: $e");
    }
    return mealDataList;
  }
}
