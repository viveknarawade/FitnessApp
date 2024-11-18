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
    "steps": [
      {
        "1": "Spread Your Arms",
        "stepDescription":
            "Hold the jump rope handles and stretch your arms to feel relaxed. Avoid bending your arms."
      },
      {
        "2": "Stay on Your Toes",
        "stepDescription":
            "Jump using the tips of your feet, making sure to land lightly with a steady rhythm."
      },
      {
        "3": "Maintain Smooth Jumps",
        "stepDescription":
            "Keep the jumps consistent and avoid excessive impact, focusing on keeping your body relaxed."
      },
      {
        "4": "Breathe Steadily",
        "stepDescription":
            "Breathe deeply and keep a rhythmic pace to improve stamina while skipping."
      }
    ]
  },
  {
    "name": "Push-Ups",
    "reps": "3 sets of 15 reps",
    "description":
        "Push-ups target the chest, shoulders, and triceps while engaging your core. A great full-body workout.",
    "steps": [
      {
        "1": "Get Into Position",
        "stepDescription":
            "Start in a high plank with your hands placed slightly wider than shoulder-width apart."
      },
      {
        "2": "Lower Your Body",
        "stepDescription":
            "Bend your elbows, lowering your body towards the ground. Keep your back straight."
      },
      {
        "3": "Push Back Up",
        "stepDescription":
            "Extend your arms to return to the starting position, maintaining control throughout the movement."
      },
      {
        "4": "Repeat with Proper Form",
        "stepDescription":
            "Ensure your body remains in a straight line and avoid sagging hips during each repetition."
      }
    ]
  },
  {
    "name": "Squats",
    "reps": "3 sets of 20 reps",
    "description":
        "Squats are a key exercise for strengthening the lower body muscles including quads, hamstrings, and glutes.",
    "steps": [
      {
        "1": "Stand with Feet Shoulder-Width Apart",
        "stepDescription": "Keep your chest up and your core tight."
      },
      {
        "2": "Lower Your Hips",
        "stepDescription":
            "Bend your knees and lower your hips as if sitting in a chair, keeping your knees behind your toes."
      },
      {
        "3": "Go Down Until Your Thighs Are Parallel",
        "stepDescription":
            "Ensure your thighs are parallel to the ground or slightly lower."
      },
      {
        "4": "Return to Start",
        "stepDescription":
            "Press through your heels to return to the starting position."
      }
    ]
  },
  {
    "name": "Burpees",
    "reps": "3 minutes",
    "description":
        "Burpees are a full-body exercise that improves strength and endurance.",
    "steps": [
      {
        "1": "Start in a Standing Position",
        "stepDescription":
            "Stand with your feet shoulder-width apart and arms at your sides."
      },
      {
        "2": "Squat and Place Hands on the Floor",
        "stepDescription":
            "Lower into a squat and place your hands on the ground in front of you."
      },
      {
        "3": "Kick Your Legs Back",
        "stepDescription": "Jump your feet back into a plank position."
      },
      {
        "4": "Jump Forward and Stand Up",
        "stepDescription": "Return to a standing position and jump at the end."
      }
    ]
  },
  {
    "name": "Mountain Climbers",
    "reps": "2 minutes",
    "description":
        "Mountain Climbers are a dynamic movement that engages the core and improves cardiovascular endurance.",
    "steps": [
      {
        "1": "Get into a Plank Position",
        "stepDescription":
            "Place your hands shoulder-width apart and straighten your body."
      },
      {
        "2": "Drive One Knee Towards Your Chest",
        "stepDescription":
            "Bring one knee forward while keeping the other leg extended."
      },
      {
        "3": "Switch Legs Quickly",
        "stepDescription":
            "In a jumping motion, switch legs, bringing the other knee towards your chest."
      },
      {
        "4": "Maintain Speed and Form",
        "stepDescription":
            "Continue alternating legs at a fast pace while maintaining proper plank form."
      }
    ]
  },
  {
    "name": "Plank",
    "reps": "2 minutes",
    "description":
        "Plank is an isometric exercise that strengthens the core and stabilizing muscles.",
    "steps": [
      {
        "1": "Get into Position",
        "stepDescription":
            "Start in a push-up position, resting on your forearms."
      },
      {
        "2": "Engage Your Core",
        "stepDescription":
            "Tighten your abs and ensure your body is in a straight line."
      },
      {
        "3": "Hold the Position",
        "stepDescription":
            "Keep your body stable without sagging your hips or raising your buttocks."
      },
      {
        "4": "Focus on Breathing",
        "stepDescription":
            "Maintain steady breathing while holding the position."
      }
    ]
  },
  {
    "name": "Lunges",
    "reps": "3 sets of 15 reps per leg",
    "description":
        "Lunges strengthen the legs and glutes while improving balance and coordination.",
    "steps": [
      {
        "1": "Stand Upright with Feet Together",
        "stepDescription": "Keep your chest up and engage your core."
      },
      {
        "2": "Step Forward",
        "stepDescription":
            "Take a big step forward with one leg and lower your hips."
      },
      {
        "3": "Lower Until Your Back Knee is Near the Ground",
        "stepDescription": "Ensure your front thigh is parallel to the ground."
      },
      {
        "4": "Return to Start",
        "stepDescription":
            "Push off your front foot to return to the starting position."
      }
    ]
  },
  {
    "name": "Bicycle Crunches",
    "reps": "3 sets of 20 reps",
    "description":
        "Bicycle crunches engage the abdominal muscles and help improve core stability.",
    "steps": [
      {
        "1": "Lie on Your Back",
        "stepDescription":
            "Place your hands behind your head and lift your legs off the floor."
      },
      {
        "2": "Bring One Knee Towards Your Chest",
        "stepDescription":
            "Simultaneously twist your torso to bring the opposite elbow towards the knee."
      },
      {
        "3": "Switch Sides",
        "stepDescription":
            "Repeat the movement on the other side, bringing the opposite knee and elbow together."
      },
      {
        "4": "Maintain Control",
        "stepDescription":
            "Continue alternating sides in a controlled, fluid motion."
      }
    ]
  }
];

List lowerBodyStorageList = [
  {
    "name": "Squats",
    "reps": "3 sets of 20 reps",
    "description":
        "Squats are essential for strengthening the lower body, targeting the quads, hamstrings, and glutes.",
    "steps": [
      {
        "1": "Stand with Feet Shoulder-Width Apart",
        "stepDescription":
            "Position your feet shoulder-width apart, keeping your chest up and core engaged."
      },
      {
        "2": "Lower into a Squat",
        "stepDescription":
            "Bend your knees and push your hips back as if sitting in a chair."
      },
      {
        "3": "Go Down Until Thighs Are Parallel",
        "stepDescription":
            "Lower your body until your thighs are parallel to the ground or slightly below."
      },
      {
        "4": "Push Back Up",
        "stepDescription":
            "Drive through your heels to return to the starting position, maintaining good form."
      }
    ]
  },
  {
    "name": "Lunges",
    "reps": "3 sets of 15 reps per leg",
    "description":
        "Lunges help build strength in the legs and glutes while improving balance and coordination.",
    "steps": [
      {
        "1": "Stand Upright with Feet Together",
        "stepDescription": "Keep your chest up and your core engaged."
      },
      {
        "2": "Step Forward with One Leg",
        "stepDescription":
            "Take a big step forward and lower your hips to create a 90-degree angle at both knees."
      },
      {
        "3": "Lower Until Your Back Knee is Near the Floor",
        "stepDescription":
            "Make sure your front knee doesn't extend past your toes."
      },
      {
        "4": "Return to Start Position",
        "stepDescription":
            "Push off your front foot to return to the starting position, then switch legs."
      }
    ]
  },
  {
    "name": "Jump Squats",
    "reps": "2 minutes",
    "description":
        "Jump squats add explosive power to your lower body, improving strength and cardiovascular endurance.",
    "steps": [
      {
        "1": "Start in a Squat Position",
        "stepDescription":
            "Stand with feet shoulder-width apart, lower into a squat with your hands in front of you."
      },
      {
        "2": "Jump Explosively",
        "stepDescription":
            "Push through your heels and jump as high as you can, extending your arms upwards."
      },
      {
        "3": "Land Softly",
        "stepDescription":
            "Land softly on your feet and immediately lower back into the squat position."
      },
      {
        "4": "Repeat the Movement",
        "stepDescription":
            "Continue the jump and squat movement, maintaining good form throughout."
      }
    ]
  },
  {
    "name": "Glute Bridges",
    "reps": "3 sets of 20 reps",
    "description":
        "Glute bridges target the glutes and hamstrings while improving core stability.",
    "steps": [
      {
        "1": "Lie on Your Back",
        "stepDescription":
            "Lie on your back with your knees bent and feet flat on the floor, hip-width apart."
      },
      {
        "2": "Lift Your Hips",
        "stepDescription":
            "Squeeze your glutes and lift your hips off the ground until your body forms a straight line from shoulders to knees."
      },
      {
        "3": "Hold the Position",
        "stepDescription":
            "Pause at the top, squeezing your glutes for maximum activation."
      },
      {
        "4": "Lower Back Down",
        "stepDescription":
            "Lower your hips slowly back to the floor and repeat."
      }
    ]
  },
  {
    "name": "Wall Sit",
    "reps": "2 minutes",
    "description":
        "The wall sit is an isometric exercise that strengthens the quads, hamstrings, and glutes.",
    "steps": [
      {
        "1": "Find a Wall",
        "stepDescription":
            "Stand with your back against a wall, feet shoulder-width apart."
      },
      {
        "2": "Slide Down into a Squat",
        "stepDescription":
            "Lower your body until your thighs are parallel to the floor, as if sitting in a chair."
      },
      {
        "3": "Hold the Position",
        "stepDescription":
            "Hold the squat position while keeping your back flat against the wall."
      },
      {
        "4": "Maintain Core Engagement",
        "stepDescription":
            "Engage your core and hold the position for the desired time."
      }
    ]
  },
  {
    "name": "Step-Ups",
    "reps": "3 sets of 12 reps per leg",
    "description":
        "Step-ups strengthen the legs and glutes, improving coordination and balance.",
    "steps": [
      {
        "1": "Find a Sturdy Step or Bench",
        "stepDescription":
            "Stand in front of a step or bench with your feet hip-width apart."
      },
      {
        "2": "Step Up with One Foot",
        "stepDescription":
            "Place one foot on the bench and push through your heel to lift your body onto the step."
      },
      {
        "3": "Step Down Slowly",
        "stepDescription":
            "Step down with control and return to the starting position."
      },
      {
        "4": "Alternate Legs",
        "stepDescription": "Switch legs and repeat the movement."
      }
    ]
  },
  {
    "name": "Calf Raises",
    "reps": "3 sets of 20 reps",
    "description":
        "Calf raises target the calf muscles, improving lower leg strength and stability.",
    "steps": [
      {
        "1": "Stand Upright",
        "stepDescription":
            "Stand with your feet hip-width apart, with your toes pointing forward."
      },
      {
        "2": "Lift Your Heels",
        "stepDescription":
            "Raise your heels as high as possible, balancing on the balls of your feet."
      },
      {
        "3": "Pause and Squeeze",
        "stepDescription":
            "Hold at the top of the movement and squeeze your calf muscles."
      },
      {
        "4": "Lower Slowly",
        "stepDescription":
            "Lower your heels back down to the floor with control."
      }
    ]
  },
  {
    "name": "Side Lunges",
    "reps": "3 sets of 15 reps",
    "description":
        "Side lunges strengthen the inner and outer thighs, improving lateral movement.",
    "steps": [
      {
        "1": "Stand Upright",
        "stepDescription":
            "Stand with your feet hip-width apart and engage your core."
      },
      {
        "2": "Step to the Side",
        "stepDescription":
            "Take a big step to the side, bending your knee while keeping the other leg straight."
      },
      {
        "3": "Lower Your Hips",
        "stepDescription":
            "Lower your hips and shift your weight over the bent knee."
      },
      {
        "4": "Return to Starting Position",
        "stepDescription":
            "Push off your bent leg to return to the starting position and switch sides."
      }
    ]
  }
];
List upperBodyStorageList = [
  {
    "name": "Push-Ups",
    "reps": "3 sets of 15 reps",
    "description":
        "Push-ups strengthen the chest, shoulders, triceps, and core, providing a full upper body workout.",
    "steps": [
      {
        "1": "Get into High Plank Position",
        "stepDescription":
            "Place your hands slightly wider than shoulder-width apart, with your body in a straight line."
      },
      {
        "2": "Lower Your Body",
        "stepDescription":
            "Bend your elbows and lower your body until your chest nearly touches the ground."
      },
      {
        "3": "Push Back Up",
        "stepDescription":
            "Extend your arms and push your body back to the starting position, maintaining a straight line from head to heels."
      },
      {
        "4": "Repeat the Movement",
        "stepDescription":
            "Continue lowering and pushing back up, ensuring proper form throughout."
      }
    ]
  },
  {
    "name": "Tricep Dips",
    "reps": "3 sets of 15 reps",
    "description":
        "Tricep dips target the triceps, shoulders, and chest, improving upper body strength.",
    "steps": [
      {
        "1": "Find a Stable Surface",
        "stepDescription":
            "Sit on the edge of a bench or chair with your hands gripping the edge, fingers pointing forward."
      },
      {
        "2": "Lower Your Body",
        "stepDescription":
            "Slide off the edge, bending your elbows to lower your body until your arms are at a 90-degree angle."
      },
      {
        "3": "Push Back Up",
        "stepDescription":
            "Extend your arms to push your body back up to the starting position."
      },
      {
        "4": "Keep Core Engaged",
        "stepDescription":
            "Keep your core tight and avoid swinging your hips as you perform the movement."
      }
    ]
  },
  {
    "name": "Plank-to-Push-Up",
    "reps": "3 sets of 10 reps",
    "description":
        "This exercise engages the chest, shoulders, triceps, and core, improving stability and endurance.",
    "steps": [
      {
        "1": "Start in a Plank Position",
        "stepDescription":
            "Begin in a forearm plank position, keeping your body in a straight line."
      },
      {
        "2": "Push Up with One Hand",
        "stepDescription":
            "Lift one hand and press it into the ground, followed by the other hand to get into a high plank position."
      },
      {
        "3": "Lower Back Down",
        "stepDescription":
            "Lower one forearm back to the ground, followed by the other, returning to the plank position."
      },
      {
        "4": "Alternate Arms",
        "stepDescription":
            "Continue alternating arms while maintaining a strong core throughout the movement."
      }
    ]
  },
  {
    "name": "Shoulder Press",
    "reps": "3 sets of 12 reps",
    "description":
        "The shoulder press works the deltoids, triceps, and upper back, enhancing shoulder strength and stability.",
    "steps": [
      {
        "1": "Hold Weights at Shoulder Height",
        "stepDescription":
            "Stand with feet shoulder-width apart, holding dumbbells or a barbell at shoulder height."
      },
      {
        "2": "Press Weights Overhead",
        "stepDescription":
            "Push the weights up until your arms are fully extended above your head."
      },
      {
        "3": "Lower the Weights",
        "stepDescription":
            "Lower the weights back down to shoulder height with control."
      },
      {
        "4": "Keep Core Engaged",
        "stepDescription":
            "Maintain a strong core throughout the exercise to avoid arching your back."
      }
    ]
  },
  {
    "name": "Bicep Curls",
    "reps": "3 sets of 15 reps",
    "description":
        "Bicep curls focus on building strength in the biceps, improving arm definition and strength.",
    "steps": [
      {
        "1": "Stand with Feet Hip-Width Apart",
        "stepDescription":
            "Hold dumbbells in each hand with your palms facing forward."
      },
      {
        "2": "Curl the Weights Up",
        "stepDescription":
            "Bend your elbows and curl the weights towards your shoulders, squeezing your biceps."
      },
      {
        "3": "Lower the Weights Slowly",
        "stepDescription":
            "Lower the weights back down to the starting position with control."
      },
      {
        "4": "Keep Elbows Close to Your Body",
        "stepDescription":
            "Avoid swinging your arms and keep your elbows stationary during the movement."
      }
    ]
  },
  {
    "name": "Chest Press",
    "reps": "3 sets of 12 reps",
    "description":
        "The chest press targets the pectorals, shoulders, and triceps, enhancing upper body strength and muscle mass.",
    "steps": [
      {
        "1": "Lie on a Bench",
        "stepDescription":
            "Lie on your back on a bench with feet flat on the floor, holding dumbbells or a barbell."
      },
      {
        "2": "Press the Weights Up",
        "stepDescription":
            "Press the weights upwards until your arms are fully extended."
      },
      {
        "3": "Lower the Weights",
        "stepDescription":
            "Slowly lower the weights back down until they are just above your chest."
      },
      {
        "4": "Repeat with Control",
        "stepDescription":
            "Continue pressing and lowering the weights, maintaining control throughout the movement."
      }
    ]
  },
  {
    "name": "Lat Pulldowns",
    "reps": "3 sets of 12 reps",
    "description":
        "Lat pulldowns strengthen the latissimus dorsi, improving upper back and shoulder stability.",
    "steps": [
      {
        "1": "Sit at a Lat Pulldown Machine",
        "stepDescription":
            "Grip the bar with your hands slightly wider than shoulder-width apart, palms facing away."
      },
      {
        "2": "Pull the Bar Down",
        "stepDescription":
            "Pull the bar down towards your chest, engaging your lats as you lower it."
      },
      {
        "3": "Pause at the Bottom",
        "stepDescription":
            "Hold the bar close to your chest for a moment, squeezing your shoulder blades together."
      },
      {
        "4": "Return to Start",
        "stepDescription":
            "Slowly raise the bar back to the starting position with control."
      }
    ]
  },
  {
    "name": "Renegade Rows",
    "reps": "3 sets of 10 reps",
    "description":
        "Renegade rows engage the upper back, shoulders, and core, improving stability and strength.",
    "steps": [
      {
        "1": "Start in a High Plank",
        "stepDescription":
            "Hold a dumbbell in each hand and get into a high plank position with your body in a straight line."
      },
      {
        "2": "Row One Dumbbell",
        "stepDescription":
            "Pull one dumbbell towards your ribcage while keeping your body steady."
      },
      {
        "3": "Lower the Dumbbell",
        "stepDescription":
            "Lower the dumbbell back to the ground and switch sides."
      },
      {
        "4": "Keep Core Engaged",
        "stepDescription":
            "Engage your core throughout the exercise to prevent your hips from sagging or rotating."
      }
    ]
  }
];

class ExerciseStorage {
  // Add exercise data to Firestore
  Future<void> addExerciseData() async {
    try {
      // Add Full Body exercises
      for (int i = 0; i < fullBodyStorageList.length; i++) {
        await db
            .collection("Exercise")
            .doc("FullBody")
            .collection("ExerciseItems")
            .add(fullBodyStorageList[i]);
      }

      // Add Upper Body exercises
      for (int i = 0; i < upperBodyStorageList.length; i++) {
        await db
            .collection("Exercise")
            .doc("UpperBody")
            .collection("ExerciseItems")
            .add(upperBodyStorageList[i]);
      }

      // Add Lower Body exercises
      for (int i = 0; i < lowerBodyStorageList.length; i++) {
        await db
            .collection("Exercise")
            .doc("LowerBody")
            .collection("ExerciseItems")
            .add(lowerBodyStorageList[i]);
      }

      log("Exercise data added successfully");
    } catch (e) {
      log("Error adding exercise data: $e");
    }
  }

  // Get exercise data from Firestore based on category
  Future<List<Map<String, dynamic>>> getExerciseData(String category) async {
    List<Map<String, dynamic>> exerciseStorageData = [];

    try {
      QuerySnapshot exerciseResponse = await db
          .collection("Exercise")
          .doc(category)
          .collection("ExerciseItems")
          .get();

      // Map the response to a list of exercises
      for (int i = 0; i < exerciseResponse.docs.length; i++) {
        Map<String, dynamic> exerciseItem = {
          "exerciseName": exerciseResponse.docs[i]["name"], // Corrected typo
          "reps": exerciseResponse.docs[i]["reps"],
          "description": exerciseResponse.docs[i]
              ["description"], // Add description if necessary
          "steps": List<Map<String, String>>.from(
              exerciseResponse.docs[i]["steps"] ?? []), // Steps
        };

        exerciseStorageData.add(exerciseItem);
      }
    } catch (e) {
      log("Error fetching exercise data: $e");
    }

    return exerciseStorageData;
  }
}
