import 'package:fitlife/Firebase/Firestore/User/auth.dart';
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
            .collection("Workout") // Meal collection
            .doc(userData[0].id) // Use the actual user ID dynamically
            .collection("dayDate")
            .doc(dayAndDateId) // Day document (e.g., "Sunday_2024-11-14")
            .collection("Category") // Category subcollection
            .doc("FullBody") // Document for Breakfast category
            .collection("Workout_items") // items subcollection for meal items
            .add(fullbody[i]); // Add the meal data
      }
    }
    if (category == "LowerBody") {
      lowerbody.clear();
      lowerbody.add(tempMealData);
      for (int i = 0; i < lowerbody.length; i++) {
        await db
            .collection("Workout")
            .doc(userData[0].id)
            .collection("dayDate")
            .doc(dayAndDateId) // Use the actual user ID dynamically
            .collection("Category")
            .doc("LowerBody") // Document for Lunch category
            .collection("Workout_items")
            .add(lowerbody[i]); // Correct reference to mealLunch
      }
    }
    if (category == "UpperBody") {
      upperbody.clear();
      upperbody.add(tempMealData);
      for (int i = 0; i < upperbody.length; i++) {
        await db
            .collection("Workout")
            .doc(userData[0].id)
            .collection("dayDate")
            .doc(dayAndDateId)
            .collection("Category")
            .doc("UpperBody") // Document for Dinner category
            .collection("Workout_items")
            .add(upperbody[i]); // Correct reference to
      }
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
}
