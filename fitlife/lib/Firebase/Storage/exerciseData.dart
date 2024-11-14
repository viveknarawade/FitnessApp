import 'package:fitlife/Firebase/Firestore/User/auth.dart';

class Exercisedata {
  List<Map> exerciseTypeCardData = [
    {
      "title": "FullBody Workout",
      "noOfExcercise": "11 Excercise",
      "min": "32Mins"
    },
    {
      "title": "LowerBody Workout",
      "noOfExcercise": "8 Excercise",
      "min": "22Mins"
    },
    {
      "title": "UpperBody Workout",
      "noOfExcercise": "5 Excercise",
      "min": "76Mins"
    },
  ];
  showData() async {
    for (int i = 0; i <= exerciseTypeCardData.length; i++) {
      await db.collection("Exercise").doc("FullBody");
    }
  }
}
