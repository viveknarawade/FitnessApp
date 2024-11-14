class caloriesIntake {
  int dayCalories = 0;
  addDayCaloriesData(String caloriesString) {
    print(
        "Calories String : '$caloriesString'"); 

 
    caloriesString = caloriesString.trim();


    int calories = int.tryParse(caloriesString) ?? 0;

    print("Calories int: $calories");
    dayCalories += calories;
    print("Total calories for today: $dayCalories");
  }
}
