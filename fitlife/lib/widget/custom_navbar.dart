import 'package:fitlife/Dashboard/profile_ui.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';
import 'package:fitlife/Forum/forum_home.dart';

import 'package:fitlife/Meal_Planner/mealHome.dart';
import 'package:fitlife/workout/workoutTracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomNavbar {
  static showCustomAppbar(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            "assets/icon/home.svg",
            width: 30,
            height: 33,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return WorkoutTracker();
                  },
                ),
              );
            },
            child: Icon(
              FontAwesomeIcons.dumbbell,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return FitnessNutritionForum();
                  },
                ),
              );
            },
            child: Icon(
              FontAwesomeIcons.comment,
              color: Colors.grey,
              size: 30,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Mealhome();
                  },
                ),
              );
            },
            child: Icon(
              Icons.restaurant_menu,
              size: 30,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ProfileUi();
                  },
                ),
              );
            },
            child: Icon(
              FontAwesomeIcons.user,
              color: Colors.grey,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
