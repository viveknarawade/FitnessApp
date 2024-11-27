import 'dart:developer';
import 'dart:io';

import 'package:fitlife/Authentication/login.dart';
import 'package:fitlife/Authentication/signUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';

import 'package:fitlife/Firebase/Firestore/User/goalGenration.dart'; // Import GoalGeneration class

class Userinfo extends StatefulWidget {
  File img;
  Userinfo({super.key, required this.img});

  @override
  State<Userinfo> createState() => _UserinfoState();
}

class _UserinfoState extends State<Userinfo> {
  String? selectedValue; // To store the selected dropdown value
  TextEditingController genderController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  clearController() {
    genderController.clear();
    weightController.clear();
    heightController.clear();
    ageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 90,
            left: 35,
            right: 35,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Ensure full width
            children: [
              SizedBox(height: 30),
              Text(
                "Let’s complete your profile",
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "It will help us to know more about you!",
                style: GoogleFonts.poppins(
                    fontSize: 15, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 30),
              _buildTextField(
                  "Your Gender", genderController, "assets/icon/gender.svg"),
              const SizedBox(height: 30),
              _buildTextField(
                  "Your Weight", weightController, "assets/icon/weight.svg"),
              const SizedBox(height: 30),
              _buildTextField(
                  "Your Height", heightController, "assets/icon/height.svg"),
              const SizedBox(height: 30),
              _buildTextField(
                  "Your Age", ageController, "assets/icon/height.svg"),
              const SizedBox(height: 30),
              _buildDropdown(),
              const SizedBox(height: 60),
              _buildNextButton(context),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build text fields
  Widget _buildTextField(
      String hintText, TextEditingController controller, String iconPath) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
        hintText: hintText,
        filled: true,
        fillColor: const Color.fromRGBO(247, 248, 248, 1),
        hintStyle:
            GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w300),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(11),
          child: SvgPicture.asset(iconPath),
        ),
      ),
    );
  }

  // Helper function to build the goal dropdown
  Widget _buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color.fromRGBO(247, 248, 248, 1),
        borderRadius: BorderRadius.circular(13),
        border: Border.all(width: 1),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: selectedValue,
        hint: const Text("Choose Goal"),
        items: <String>["Gain", "Loss", "Maintain"]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue; // Update the selected value
          });
        },
      ),
    );
  }

  // Next button to submit and calculate the calories goal
  Widget _buildNextButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color.fromRGBO(150, 179, 254, 1),
          ),
        ),
        onPressed: () async {
          // Capture the input data
          double weight = double.parse(weightController.text.trim());
          double height = double.parse(heightController.text.trim());
          double age = double.parse(ageController.text.trim());
          String gender = genderController.text.trim();
          String goal = selectedValue ??
              "maintain"; // Default to "maintain" if not selected

          // Instantiate the GoalGeneration class with the captured data
          GoalGeneration goalGeneration = GoalGeneration(
            weight: weight,
            height: height,
            age: age,
            gender: gender,
            goal: goal,
          );

          // Get the calculated calories goal
          double caloriesGoal = goalGeneration.getCaloriesGoal();

          // Add to signupData and move to next screen
          signupData.addAll({
            "gender": gender,
            "weight": weight,
            "height": height,
            "age": age,
            "goal": goal,
            "caloriesGoal": caloriesGoal,
          });

          log("signupData: $signupData");
          Authservice().addData(signupData);

          // Navigate to Login screen
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Login()),
          );
          clearController();
          setState(() {});
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icon/Login.svg", width: 30, height: 24),
            const SizedBox(width: 10),
            Text(
              "Next",
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
