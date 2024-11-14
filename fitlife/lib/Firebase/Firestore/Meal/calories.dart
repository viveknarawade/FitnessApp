import 'package:fitlife/Firebase/Firestore/User/auth.dart';

class Calories {
  int intake = 0; // Initialize intake to 0

  void calculateCalories(String calories) {
    int calorie = int.parse(calories);
    intake += calorie;
  }

  addCaloriesData(String category, String calories) async {
    calculateCalories(calories);
    await db
        .collection("Calories")
        .doc(category)
        .collection("CaloriesIntake")
        .add({"intake": intake.toString()});
  }
}
