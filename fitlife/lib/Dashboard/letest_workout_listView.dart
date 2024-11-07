import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class LetestWorkoutListview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LetestWorkoutListviewState();
  }
}

class _LetestWorkoutListviewState extends State {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  "assets/workout/fullbody.svg",
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("FullBodyWorkout"),
                  SizedBox(
                    height: 2,
                  ),
                  Text("180 Calories burn | 20 min"),
                  SizedBox(
                    height: 7,
                  ),
                  SimpleAnimationProgressBar(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    ratio: .5,
                    width: 170,
                    height: 13,
                    direction: Axis.horizontal,
                    backgroundColor: Color.fromRGBO(247, 248, 248, 1),
                    foregrondColor: Color.fromRGBO(159, 158, 251, 1),
                    duration: Duration(seconds: 3),
                    curve: Curves.fastLinearToSlowEaseIn,
                  ),
                  SizedBox(
                    height: 17,
                  ),
                ],
              ),
              const Spacer(),
              Container(
                child: SvgPicture.asset(
                  "assets/icon/next-btn.svg",
                  width: 40,
                  height: 35,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
