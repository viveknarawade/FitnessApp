import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitlife/Authentication/signUp.dart';
import 'package:fitlife/Model/user.dart';
import 'package:fitlife/main.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
List<User> userData = [];

class Authservice {
  addData() {
    db.collection("User").add(signupData);
  }

  Future<bool> authenticate(String userName, String password) async {
    QuerySnapshot response = await db.collection("User").get();

    for (int i = 0; i < response.docs.length; i++) {
      if (response.docs[i]["userName"] == userName &&
          response.docs[i]["password"] == password) {
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
        print("${response.docs[i]["userName"] == userName}");
        print("${response.docs[i]["password"] == password}");

        return true;
      }
    }

    return false;
  }

  Map<String, dynamic> toMap() {
    return {
      'USERNAME': userData[0].userName,
      'PASSWOARD': userData[0].password,
      'EMAIL': userData[0].email,
      'GENDER': userData[0].gender,
      'ID': userData[0].id,
      'COLORISGOAL': userData[0].coloriesGoal,
      'AGE': userData[0].age,
      'GOAL': userData[0].goal,
      'HEIGHT': userData[0].height,
      'WEIGHT': userData[0].weight,
    };
  }
}
