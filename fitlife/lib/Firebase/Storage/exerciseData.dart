import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';
import 'package:flutter/material.dart';

List fullBodyStorageList = [
  {
    "name": "Skipping",
    "reps": "5 minutes",
    "description":
        "Skipping is a high-intensity cardiovascular exercise that helps improve agility, endurance, and coordination.",
  },
  {
    "name": "Push-Ups",
    "reps": "3 sets of 15 reps",
    "description":
        "Push-ups target the chest, shoulders, and triceps while engaging your core. A great full-body workout.",
  },
  {
    "name": "Squats",
    "reps": "3 sets of 20 reps",
    "description":
        "Squats are a key exercise for strengthening the lower body muscles including quads, hamstrings, and glutes.",
  },
  {
    "name": "Burpees",
    "reps": "3 minutes",
    "description":
        "Burpees are a full-body exercise that improves strength and endurance.",
  },
  {
    "name": "Mountain Climbers",
    "reps": "2 minutes",
    "description":
        "Mountain Climbers are a dynamic movement that engages the core and improves cardiovascular endurance.",
  },
  {
    "name": "Plank",
    "reps": "2 minutes",
    "description":
        "Plank is an isometric exercise that strengthens the core and stabilizing muscles.",
  },
  {
    "name": "Lunges",
    "reps": "3 sets of 15 reps per leg",
    "description":
        "Lunges strengthen the legs and glutes while improving balance and coordination.",
  },
  {
    "name": "Bicycle Crunches",
    "reps": "3 sets of 20 reps",
    "description":
        "Bicycle crunches engage the abdominal muscles and help improve core stability.",
  }
];

List lowerBodyStorageList = [
  {
    "name": "Squats",
    "reps": "3 sets of 20 reps",
    "description":
        "Squats are essential for strengthening the lower body, targeting the quads, hamstrings, and glutes.",
  },
  {
    "name": "Lunges",
    "reps": "3 sets of 15 reps per leg",
    "description":
        "Lunges help build strength in the legs and glutes while improving balance and coordination.",
  },
  {
    "name": "Jump Squats",
    "reps": "2 minutes",
    "description":
        "Jump squats add explosive power to your lower body, improving strength and cardiovascular endurance.",
  },
  {
    "name": "Glute Bridges",
    "reps": "3 sets of 20 reps",
    "description":
        "Glute bridges target the glutes and hamstrings while improving core stability.",
  },
  {
    "name": "Wall Sit",
    "reps": "2 minutes",
    "description":
        "The wall sit is an isometric exercise that strengthens the quads, hamstrings, and glutes.",
  },
  {
    "name": "Step-Ups",
    "reps": "3 sets of 12 reps per leg",
    "description":
        "Step-ups strengthen the legs and glutes, improving coordination and balance.",
  },
  {
    "name": "Calf Raises",
    "reps": "3 sets of 20 reps",
    "description":
        "Calf raises target the calf muscles, improving lower leg strength and stability.",
  },
  {
    "name": "Side Lunges",
    "reps": "3 sets of 15 reps",
    "description":
        "Side lunges strengthen the inner and outer thighs, improving lateral movement.",
  }
];
List upperBodyStorageList = [
  {
    "name": "Push-Ups",
    "reps": "3 sets of 15 reps",
    "description":
        "Push-ups strengthen the chest, shoulders, triceps, and core, providing a full upper body workout.",
  },
  {
    "name": "Tricep Dips",
    "reps": "3 sets of 15 reps",
    "description":
        "Tricep dips target the triceps, shoulders, and chest, improving upper body strength.",
  },
  {
    "name": "Plank-to-Push-Up",
    "reps": "3 sets of 10 reps",
    "description":
        "This exercise engages the chest, shoulders, triceps, and core, improving stability and endurance.",
  },
  {
    "name": "Shoulder Press",
    "reps": "3 sets of 12 reps",
    "description":
        "The shoulder press works the deltoids, triceps, and upper back, enhancing shoulder strength and stability.",
  },
  {
    "name": "Bicep Curls",
    "reps": "3 sets of 15 reps",
    "description":
        "Bicep curls focus on building strength in the biceps, improving arm definition and strength.",
  },
  {
    "name": "Chest Press",
    "reps": "3 sets of 12 reps",
    "description":
        "The chest press targets the pectorals, shoulders, and triceps, enhancing upper body strength and muscle mass.",
  },
  {
    "name": "Lat Pulldowns",
    "reps": "3 sets of 12 reps",
    "description":
        "Lat pulldowns strengthen the latissimus dorsi, improving upper back and shoulder stability.",
  },
  {
    "name": "Renegade Rows",
    "reps": "3 sets of 10 reps",
    "description":
        "Renegade rows engage the upper back, shoulders, and core, improving stability and strength.",
  }
];

class ExerciseStorage {
  addExerciseData() async {
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
        "description": foodResponse.docs[i]["description"],
      };

      // Add to the foodCategoryData list
      exerciseStorageData.add(foodItem);
    }
    return exerciseStorageData;
  }
}
