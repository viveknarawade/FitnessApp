
import 'dart:io';

class User {
  String userName;
  String email;
  String password;
  String gender;
  String goal;
  String id;
  double age;
  double height;
  double weight;
  double coloriesGoal;


  User(
      {
      required this.userName,
      required this.email,
      required this.gender,
      required this.id,
      required this.password,
      required this.age,
      required this.coloriesGoal,
      required this.goal,
      required this.height,
      required this.weight});
}
