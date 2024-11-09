import 'package:fitlife/Model/user.dart';

class GoalGeneration {
  double? BMR;
  double? TDEE;
  double? caloriesGoal;

  // Constructor that takes the user's data
  GoalGeneration({
    required double weight,
    required double height,
    required double age,
    required String gender,
    required String goal,  // user's goal (gain, loss, or maintain)
  })
  
   {
    _calculate(weight, height, age, gender, goal);
  }

  // Function to calculate BMR, TDEE, and caloriesGoal
  void _calculate(double weight, double height, double age, String gender, String goal) {
    // Calculate BMR based on gender
    if (gender.toLowerCase() == 'male') {
      BMR = 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      BMR = 10 * weight + 6.25 * height - 5 * age - 161;
    }

    // Calculate TDEE (assuming sedentary activity level)
    TDEE = BMR! * 1.2;

    // Adjust calories based on user's goal
    if (goal == "gain") {
      caloriesGoal = TDEE! + 500;
    } else if (goal == "loss") {
      caloriesGoal = TDEE! - 500;
    } else {
      caloriesGoal = TDEE;
    }

    print("Calculated Calories Goal: $caloriesGoal");
  }

  double getCaloriesGoal() {
    return caloriesGoal ?? 0.0;  // Return 0 if caloriesGoal is null
  }
}
