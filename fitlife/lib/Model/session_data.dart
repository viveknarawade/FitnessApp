import 'dart:async';

import 'package:fitlife/Model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionData {
  static bool? isLogin;
  static String? userName;
  static String? email;
  static String? password;
  static String? gender;
  static String? goal;
  static String? id;
  static double? age;
  static double? height;
  static double? weight;
  static double? coloriesGoal;

  static Future<void> setSessionData({
    required bool loginData,
    required String userName,
    required String email,
    required String password,
    required String gender,
    required String goal,
    required String id,
    required double age,
    required double height,
    required double weight,
    required double coloriesGoal,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    //SET DATA

    sharedPreferences.setBool("loginSession", loginData);
    sharedPreferences.setString("userName", userName);
    sharedPreferences.setString("email", email);
    sharedPreferences.setString("password", password);
    sharedPreferences.setString("gender", gender);
    sharedPreferences.setString("goal", goal);
    sharedPreferences.setString("id", id);
    sharedPreferences.setDouble("age", age);
    sharedPreferences.setDouble("height", height);
    sharedPreferences.setDouble("weight", weight);
    sharedPreferences.setDouble("coloriesGoal", coloriesGoal);

    

    // GET DATA
    getSessionData();
  }

  static Future<void> getSessionData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // Get DATA, use default values if data is not found
    isLogin = sharedPreferences.getBool("loginSession") ?? false;
    userName = sharedPreferences.getString("userName") ?? '';
    email = sharedPreferences.getString("email") ?? '';
    password = sharedPreferences.getString("password") ?? '';
    gender = sharedPreferences.getString("gender") ?? '';
    goal = sharedPreferences.getString("goal") ?? '';
    id = sharedPreferences.getString("id") ?? '';

    // Provide default values or handle missing data for numerical fields
    age = sharedPreferences.getDouble("age") ?? 0.0;
    height = sharedPreferences.getDouble("height") ?? 0.0;
    weight = sharedPreferences.getDouble("weight") ?? 0.0;
    coloriesGoal = sharedPreferences.getDouble("coloriesGoal") ?? 0.0;
  }
}
