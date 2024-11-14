import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';
import 'package:fitlife/Firebase/Storage/exerciseData.dart';

import 'package:flutter/material.dart';

List lunch = [
  {
    "food_item": "Broccoli",
    "calories": "55.0",
    "protein": "4.0",
    "fat": "0.6",
    "carbs": "11.0",
    "description":
        "Broccoli is a green vegetable rich in vitamins and fiber. It's low in calories and provides a good source of antioxidants. Ideal for boosting immunity. Often used in salads or stir-fry dishes. Great for supporting digestive health."
  },
  {
    "food_item": "Avocado",
    "calories": "240.0",
    "protein": "3.0",
    "fat": "22.0",
    "carbs": "12.0",
    "description":
        "Avocado is a creamy fruit high in healthy fats, particularly monounsaturated fat. It's packed with vitamins, including Vitamin K and E. Known for promoting heart health. Excellent source of fiber and potassium. Perfect for salads or toast."
  },
];

List breakfast = [
  {
    "food_item": "Apple",
    "calories": "95.0",
    "protein": "0.5",
    "fat": "0.3",
    "carbs": "25.0",
    "description":
        "Apples are sweet and crunchy fruits rich in dietary fiber. They help improve digestion and promote heart health. High in antioxidants like Vitamin C. Low in calories, making them a great snack option. Ideal for maintaining healthy blood sugar levels."
  },
  {
    "food_item": "Banana",
    "calories": "105.0",
    "protein": "1.3",
    "fat": "0.3",
    "carbs": "27.0",
    "description":
        "Bananas are a great source of potassium, which helps regulate blood pressure. They're high in carbohydrates, providing energy throughout the day. Great for improving digestion. Rich in Vitamin B6 and Vitamin C. Easily portable for a quick snack."
  },
  {
    "food_item": "Eggs",
    "calories": "72.0",
    "protein": "6.3",
    "fat": "4.8",
    "carbs": "0.4",
    "description":
        "Eggs are a highly nutritious food, providing a complete source of protein. Rich in vitamins, including Vitamin A and B12. They support muscle growth and repair. Contain healthy fats and antioxidants. Versatile for various recipes like scrambled, boiled, or poached."
  },
  {
    "food_item": "Almonds",
    "calories": "160.0",
    "protein": "6.0",
    "fat": "14.0",
    "carbs": "6.0",
    "description":
        "Almonds are a nutrient-dense snack that provides healthy fats, protein, and fiber. Rich in Vitamin E, they help improve skin health. Known for supporting heart health. Low in carbs, making them suitable for low-carb diets. Great for on-the-go energy."
  },
  {
    "food_item": "Oats",
    "calories": "154.0",
    "protein": "5.4",
    "fat": "2.5",
    "carbs": "27.0",
    "description":
        "Oats are a wholesome whole grain that provides complex carbohydrates and fiber. They help in maintaining stable blood sugar levels. Rich in beta-glucan, which supports cholesterol reduction. Full of antioxidants to combat inflammation. A great breakfast option, often enjoyed as oatmeal or overnight oats."
  },
  {
    "food_item": "Yogurt",
    "calories": "100.0",
    "protein": "10.0",
    "fat": "0.0",
    "carbs": "6.0",
    "description":
        "Yogurt is a probiotic-rich dairy product that supports gut health. It's high in protein, helping with muscle repair. Contains calcium for bone health. Often consumed as a snack or added to smoothies. Ideal for those looking for a light, low-fat dairy option."
  },
];

List dinner = [
  {
    "food_item": "Sweet Potato",
    "calories": "103.0",
    "protein": "2.3",
    "fat": "0.2",
    "carbs": "24.0",
    "description":
        "Sweet potatoes are a rich source of vitamins, particularly Vitamin A. They are high in fiber, supporting digestive health. Known for their antioxidant properties, they help combat inflammation. Great for improving vision and immune function. Can be roasted, mashed, or added to soups."
  },
  {
    "food_item": "Mixed Salad",
    "calories": "40.0",
    "protein": "1.5",
    "fat": "0.2",
    "carbs": "9.0",
    "description":
        "A mixed salad is a combination of various vegetables like lettuce, tomatoes, and cucumbers. It's low in calories and high in fiber. Great for weight management and digestion. Packed with vitamins and minerals to support overall health. Can be served with a variety of dressings and toppings."
  },
  {
    "food_item": "Tofu",
    "calories": "94.0",
    "protein": "10.0",
    "fat": "5.9",
    "carbs": "2.3",
    "description":
        "Tofu is a plant-based protein made from soybeans. It's rich in essential amino acids and supports muscle growth. Low in carbs and fat, making it a healthy protein source. Ideal for vegetarians and vegans. Can be grilled, stir-fried, or added to soups."
  },
  {
    "food_item": "Brown Rice",
    "calories": "218.0",
    "protein": "5.0",
    "fat": "1.6",
    "carbs": "45.0",
    "description":
        "Brown rice is a whole grain that's rich in fiber and antioxidants. It helps stabilize blood sugar levels and aids in digestion. High in magnesium, supporting muscle and nerve function. Provides long-lasting energy due to its complex carbohydrates. Can be used in various dishes like stir-fries or as a side."
  },
];

class Food {
  addFoodData() async {
    for (int i = 0; i < breakfast.length; i++) {
      await db
          .collection("Food")
          .doc("Breakfast")
          .collection("items")
          .add(breakfast[i]);
    }
    for (int i = 0; i < lunch.length; i++) {
      await db
          .collection("Food")
          .doc("Lunch")
          .collection("items")
          .add(lunch[i]);
    }
    for (int i = 0; i < dinner.length; i++) {
      await db
          .collection("Food")
          .doc("Dinner")
          .collection("items")
          .add(dinner[i]);
    }
  }

  Future<List<Map<String, dynamic>>> getFoodData(String category) async {
    List<Map<String, dynamic>> foodCategoryData = [];

    // Clear any existing data in the list before fetching new data
    foodCategoryData.clear();

    // Fetch data from Firestore (ensure db is your firestore instance)
    QuerySnapshot foodResponse =
        await db.collection("Food").doc(category).collection("items").get();

    // Map the response to a list of food items
    for (int i = 0; i < foodResponse.docs.length; i++) {
      Map<String, dynamic> foodItem = {
        "food_item": foodResponse.docs[i]["food_item"],
        "calories": foodResponse.docs[i]["calories"],
        "protein": foodResponse.docs[i]["protein"],
        "fat": foodResponse.docs[i]["fat"],
        "carbs": foodResponse.docs[i]["carbs"],
        "description": foodResponse.docs[i]["description"],
      };

      // Add to the foodCategoryData list
      foodCategoryData.add(foodItem);
    }

    // Print the result for debugging purposes
    print("-------$foodCategoryData---------");

    if (foodCategoryData.isEmpty) {
      print("empty");
    }

    return foodCategoryData;
  }
}

class Fooddata extends StatefulWidget {
  const Fooddata({super.key});

  @override
  State<Fooddata> createState() => _FooddataState();
}

class _FooddataState extends State<Fooddata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Food().addFoodData();
            // ExerciseStorage().addFoodData();
          },
          child: Text("add data"),
        ),
      ),
    );
  }
}
