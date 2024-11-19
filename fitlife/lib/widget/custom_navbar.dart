import 'package:fitlife/Dashboard/profile_ui.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              SvgPicture.asset(
                "assets/icon/home.svg",
                width: 30,
                height: 33,
              ),
              const SizedBox(
                width: 50,
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
                  )),
              SizedBox(
                width: 150,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Mealhome();
                      }));
                    },
                    child: Image.asset(
                      "assets/icon/meal.png",
                      width: 34,
                      height: 36,
                    ),
                  ),
                  const SizedBox(
                    width: 50,
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
                      child: SvgPicture.asset(
                        "assets/icon/profile.svg",
                        width: 30,
                        height: 33,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
