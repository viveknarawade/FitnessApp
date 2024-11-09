import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';


import 'package:flutter/material.dart';

List lunch = [
  {
    "food_item": "Broccoli",
    "calories": "55.0",
    "protein": "4.0",
    "fat": "0.6",
    "carbs": "11.0"
  },
  {
    "food_item": "Avocado",
    "calories": "240.0",
    "protein": "3.0",
    "fat": "22.0",
    "carbs": "12.0"
  },
];

List breakfast = [
  {
    "food_item": "Apple",
    "calories": "95.0",
    "protein": "0.5",
    "fat": "0.3",
    "carbs": "25.0"
  },
  {
    "food_item": "Banana",
    "calories": "105.0",
    "protein": "1.3",
    "fat": "0.3",
    "carbs": "27.0"
  },
  {
    "food_item": "Eggs",
    "calories": "72.0",
    "protein": "6.3",
    "fat": "4.8",
    "carbs": "0.4"
  },
  {
    "food_item": "Almonds",
    "calories": "160.0",
    "protein": "6.0",
    "fat": "14.0",
    "carbs": "6.0"
  },
  {
    "food_item": "Oats",
    "calories": "154.0",
    "protein": "5.4",
    "fat": "2.5",
    "carbs": "27.0"
  },
  {
    "food_item": "Yogurt",
    "calories": "100.0",
    "protein": "10.0",
    "fat": "0.0",
    "carbs": "6.0"
  },
];

List dinner = [
  {
    "food_item": "Sweet Potato",
    "calories": "103.0",
    "protein": "2.3",
    "fat": "0.2",
    "carbs": "24.0"
  },
  {
    "food_item": "Mixed Salad",
    "calories": "40.0",
    "protein": "1.5",
    "fat": "0.2",
    "carbs": "9.0"
  },
  {
    "food_item": "Tofu",
    "calories": "94.0",
    "protein": "10.0",
    "fat": "5.9",
    "carbs": "2.3"
  },
  {
    "food_item": "Brown Rice",
    "calories": "218.0",
    "protein": "5.0",
    "fat": "1.6",
    "carbs": "45.0"
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
          },
          child: Text("add data"),
        ),
      ),
    );
  }
}
