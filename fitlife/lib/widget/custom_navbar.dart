import 'package:fitlife/Dashboard/home_ui.dart';
import 'package:fitlife/Dashboard/profile_ui.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';
import 'package:fitlife/Forum/forum_home.dart';
import 'package:fitlife/Meal_Planner/mealHome.dart';
import 'package:fitlife/workout/workoutTracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomNavbar {
  static Widget showCustomAppbar(BuildContext context, {int currentIndex = 0}) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF5D7AEA), Color(0xFF3A6FB7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                icon: SvgPicture.asset(
                  "assets/icon/home.svg",
                  width: 30,
                  height: 33,
                  color: _getIconColor(0, currentIndex),
                ),
                tooltip: "Home",
                onTap: () => _navigateToHome(context),
                isActive: currentIndex == 0,
              ),
              _buildNavItem(
                context,
                icon: Icon(
                  FontAwesomeIcons.dumbbell,
                  color: _getIconColor(1, currentIndex),
                  size: 30,
                ),
                tooltip: "Workout Tracker",
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => WorkoutTracker()),
                ),
                isActive: currentIndex == 1,
              ),
              _buildNavItem(
                context,
                icon: Icon(
                  FontAwesomeIcons.comment,
                  color: _getIconColor(2, currentIndex),
                  size: 36,
                ),
                tooltip: "Nutrition Forum",
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => FitnessNutritionForum()),
                ),
                isActive: currentIndex == 2,
              ),
              _buildNavItem(
                context,
                icon: Icon(
                  Icons.restaurant_menu,
                  color: _getIconColor(3, currentIndex),
                  size: 38,
                ),
                tooltip: "Meal Tracker",
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Mealhome()),
                ),
                isActive: currentIndex == 3,
              ),
              _buildNavItem(
                context,
                icon: Icon(
                  FontAwesomeIcons.user,
                  color: _getIconColor(4, currentIndex),
                  size: 30,
                ),
                tooltip: "Profile",
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProfileUi()),
                ),
                isActive: currentIndex == 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build nav items with consistent styling
  static Widget _buildNavItem(
    BuildContext context, {
    required Widget icon,
    required String tooltip,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.all(8),
          child: icon,
        ),
      ),
    );
  }

  // Helper method to handle home navigation or update current page
  static void _navigateToHome(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return HomeUi();
        },
      ),
    );
  }

  // Helper method to dynamically color icons based on active state
  static Color _getIconColor(int itemIndex, int currentIndex) {
    return Colors.white;
  }
}
