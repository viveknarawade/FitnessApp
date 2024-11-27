import 'dart:developer';

import 'package:fitlife/Firebase/Firestore/User/auth.dart';
import 'package:fitlife/Model/session_data.dart';
import 'package:fitlife/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});
  @override
  State createState() => _EditprofileState();
}

class _EditprofileState extends State {
  TextEditingController profileNameController = TextEditingController();
  TextEditingController goalController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              SvgPicture.asset("assets/svg/VectorSection.svg",
                  fit: BoxFit.contain),
              const SizedBox(
                height: 100,
              ),
              Text(
                "Let’s Edit your profile",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Updating your profile helps us personalize your experience!",
                style: GoogleFonts.poppins(
                    fontSize: 15, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: profileNameController,
                decoration: InputDecoration(
                  labelText: "Profile Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 86, 2, 101), width: 2),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      "assets/icon/profile.svg",
                      color: Color.fromRGBO(123, 111, 114, 1),
                      width: 10,
                      height: 10,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: goalController,
                decoration: const InputDecoration(
                  hintText: "Ente Goal",
                  labelText: "Goal",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 86, 2, 101), width: 2),
                  ),
                  prefixIcon:
                      Icon(Icons.monitor_weight_outlined, color: Colors.grey),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Goal';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: heightController,
                decoration: const InputDecoration(
                  labelText: "Height ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 86, 2, 101), width: 2),
                  ),
                  prefixIcon: Icon(Icons.height, color: Colors.grey),
                  hintText: "Enter your height (cm)",
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: weightController,
                decoration: const InputDecoration(
                  labelText: "Weight",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 86, 2, 101), width: 2),
                  ),
                  prefixIcon: Icon(Icons.height, color: Colors.grey),
                  hintText: "Enter your height (Kg)",
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(
                  labelText: "Age",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 86, 2, 101), width: 2),
                  ),
                  prefixIcon: Icon(Icons.height, color: Colors.grey),
                  hintText: "Enter your Age",
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  await db.collection("User").doc(userData[0].id).update({
                    "userName": profileNameController.text.trim(),
                    "goal": goalController.text.trim(),
                    "height": heightController.text.trim(),
                    "weight": weightController.text.trim(),
                    "age": ageController.text.trim()
                  });
                  log("Update Data : ${profileNameController.text.trim()} ${goalController.text.trim()} ${heightController.text.trim()} ${weightController.text.trim()} ${ageController.text.trim()}");
                  MainApp().sqfliteObj?.insertData({
                    'USERNAME': profileNameController.text.trim(),
                    'GOAL': goalController.text.trim(),
                    'HEIGHT': heightController.text.trim(),
                    'WEIGHT': weightController.text.trim(),
                    'AGE': ageController.text.trim(),
                  });

                  bool isLogin = await Authservice().authenticate(
                      profileNameController.text.trim(), SessionData.password!);
                  if (isLogin) {
                    SessionData.setSessionData(
                        loginData: true,
                        userName: profileNameController.text,
                        email: SessionData.email!,
                        password: SessionData.password!,
                        gender: SessionData.gender!,
                        goal: goalController.text.trim(),
                        id: SessionData.id!,
                        age: double.parse(ageController.text.trim()),
                        height: double.parse(heightController.text.trim()),
                        weight: double.parse(weightController.text.trim()),
                        coloriesGoal: SessionData.coloriesGoal!);
                  }
                  Navigator.of(context).pop();
                  setState(() {});
                },
                child: Container(
                  height: 60,
                  width: 320,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                        colors: [
                          Color.fromRGBO(107, 80, 246, 1),
                          Color.fromRGBO(204, 143, 237, 1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 4),
                            blurRadius: 5.0)
                      ]),
                  child: Center(
                    child: Text(
                      "Update",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
