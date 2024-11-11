class caloriesIntake {
  int dayCalories = 0;
  addDayCaloriesData(String caloriesString) {
    print(
        "Calories String before trim: '$caloriesString'"); // Debugging step to see any extra spaces

    // Trim the string to remove leading/trailing whitespace
    caloriesString = caloriesString.trim();

    // Try parsing the string again
    int calories = int.tryParse(caloriesString) ?? 0;

    print("Calories int: $calories");
    dayCalories += calories;
    print("Total calories for today: $dayCalories");
  }
}
