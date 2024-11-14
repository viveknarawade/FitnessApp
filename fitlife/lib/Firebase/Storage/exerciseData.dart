import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';
import 'package:flutter/material.dart';

List fullBodyStorageList = [
  {"name": "Skipping", "reps": "5 minutes"},
  {"name": "Push-Ups", "reps": "3 sets of 15 reps"},
  {"name": "Squats", "reps": "3 sets of 20 reps"},
  {"name": "Burpees", "reps": "3 minutes"},
  {"name": "Mountain Climbers", "reps": "2 minutes"},
  {"name": "Plank", "reps": "2 minutes"},
  {"name": "Lunges", "reps": "3 sets of 15 reps per leg"},
  {"name": "Bicycle Crunches", "reps": "3 sets of 20 reps"},
];

List lowerBodyStorageList = [
  {"name": "Squats", "reps": "3 sets of 20 reps"},
  {"name": "Lunges", "reps": "3 sets of 15 reps per leg"},
  {"name": "Jump Squats", "reps": "2 minutes"},
  {"name": "Glute Bridges", "reps": "3 sets of 20 reps"},
  {"name": "Wall Sit", "reps": "2 minutes"},
  {"name": "Step-Ups", "reps": "3 sets of 12 reps per leg"},
  {"name": "Calf Raises", "reps": "3 sets of 20 reps"},
  {"name": "Side Lunges", "reps": "3 sets of 15 reps"},
];

List upperBodyStorageList = [
  {"name": "Push-Ups", "reps": "3 sets of 15 reps"},
  {"name": "Tricep Dips", "reps": "3 sets of 15 reps"},
  {"name": "Plank-to-Push-Up", "reps": "3 sets of 10 reps"},
  {"name": "Shoulder Press", "reps": "3 sets of 12 reps"},
  {"name": "Bicep Curls", "reps": "3 sets of 15 reps"},
  {"name": "Chest Press", "reps": "3 sets of 12 reps"},
  {"name": "Lat Pulldowns", "reps": "3 sets of 12 reps"},
  {"name": "Renegade Rows", "reps": "3 sets of 10 reps"},
];

class ExerciseStorage {
  addFoodData() async {
    for (int i = 0; i < fullBodyStorageList.length; i++) {
      await db
          .collection("Exercise")
          .doc("FullBody")
          .collection("ExerciseItems")
          .add(fullBodyStorageList[i]);
    }
    for (int i = 0; i < upperBodyStorageList.length; i++) {
      await db
          .collection("Exercise")
          .doc("UpperBody")
          .collection("ExerciseItems")
          .add(upperBodyStorageList[i]);
    }
    for (int i = 0; i < lowerBodyStorageList.length; i++) {
      await db
          .collection("Exercise")
          .doc("LowerBody")
          .collection("ExerciseItems")
          .add(lowerBodyStorageList[i]);
    }
    log("Exercise data added ");
  }

  Future<List<Map<String, dynamic>>> getExerciseData(String category) async {
    List<Map<String, dynamic>> exerciseStorageData = [];

    exerciseStorageData.clear();

    QuerySnapshot foodResponse = await db
        .collection("Exercise")
        .doc(category)
        .collection("ExerciseItems")
        .get();

    // Map the response to a list of food items
    for (int i = 0; i < foodResponse.docs.length; i++) {
      Map<String, dynamic> foodItem = {
        "exersiceName": foodResponse.docs[i]["name"],
        "reps": foodResponse.docs[i]["reps"],
      };

      // Add to the foodCategoryData list
      exerciseStorageData.add(foodItem);
    }

   

    return exerciseStorageData;
  }
}
