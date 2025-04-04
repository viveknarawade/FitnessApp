import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitlife/Authentication/signUp.dart';
import 'package:fitlife/Model/session_data.dart';
import 'package:fitlife/Model/user.dart';
import 'package:fitlife/main.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
List<User> userData = [];
List<Map> tempUserData = [];

class Authservice {
  addData(Map<String, dynamic> temp) {
    db.collection("User").add(temp);
  }

  Future<bool> authenticate(String email, String password) async {
    QuerySnapshot response = await db.collection("User").get();

    for (int i = 0; i < response.docs.length; i++) {
      log("${response.docs[i]["email"] + "=" + email}\n");
      log("${response.docs[i]["password"] + "=" + password}\n");

      if (response.docs[i]["email"] == email &&
          response.docs[i]["password"] == password) {
        tempUserData.add(
          {
            "userName": response.docs[i]["userName"],
            "email": response.docs[i]["email"],
            "id": response.docs[i].id,
            "password": response.docs[i]["password"],
            "age": response.docs[i]["age"],
            "coloriesGoal": response.docs[i]["caloriesGoal"],
            "goal": response.docs[i]["goal"],
            "height": response.docs[i]["height"],
            "weight": response.docs[i]["weight"],
            "gender": response.docs[i]["gender"],
          },
        );
        userData.add(
          User(
            userName: response.docs[i]["userName"],
            email: response.docs[i]["email"],
            id: response.docs[i].id,
            password: response.docs[i]["password"],
            age: response.docs[i]["age"],
            coloriesGoal: response.docs[i]["caloriesGoal"],
            goal: response.docs[i]["goal"],
            height: response.docs[i]["height"],
            weight: response.docs[i]["weight"],
            gender: response.docs[i]["gender"],
          ),
        );

        return true;
      }
    }

    return false;
  }

  Map<String, dynamic> toMap() {
    return {
      'USERNAME': SessionData.userName,
      'PASSWOARD': SessionData.password,
      'EMAIL': SessionData.email,
      'GENDER': SessionData.gender,
      'ID': SessionData.id,
      'COLORISGOAL': SessionData.coloriesGoal,
      'AGE': SessionData.age,
      'GOAL': SessionData.goal,
      'HEIGHT': SessionData.height,
      'WEIGHT': SessionData.weight,
    };
  }
}
