import 'package:fitness_app/workout/workoutCard.dart';
import 'package:flutter/material.dart';

class WorkoutTracker extends StatefulWidget {
  const WorkoutTracker({super.key});

  @override
  State<WorkoutTracker> createState() => _WorkoutTrackerState();
}

class _WorkoutTrackerState extends State<WorkoutTracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Color.fromRGBO(148, 171, 253, 1.0),
            expandedHeight: MediaQuery.of(context).size.width * 0.9,
            elevation: 0.0,
            pinned: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(0.0),
              child: Container(
                height: 32.0,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Container(
                  width: 65,
                  height: 5.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: Color.fromRGBO(233, 232, 232, 1.0),
                  ),
                ),
              ),
            ),
            leadingWidth: 80,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          SliverToBoxAdapter(
            
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "What Do You Want To Train",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold), // Optional styling
              ),
            ),
          ),
          Workoutcard(),
        ],
      ),
    );
  }
}
