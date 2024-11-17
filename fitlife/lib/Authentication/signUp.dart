import 'dart:developer';
import 'dart:io';

import 'package:fitlife/Authentication/login.dart';
import 'package:fitlife/Authentication/userInfo.dart';
import 'package:fitlife/main.dart';
import 'package:fitlife/widget/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

Map<String, dynamic> signupData = {};

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  static File? image;

  // Controllers to capture user input
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  clearController() {
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  pickImage() async {
    ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      setState(() {});
    } else {
      log("NO IMAGE SELECTED");
    }
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
              Text(
                "Hey there,",
                style: GoogleFonts.poppins(
                    fontSize: 17, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              Text(
                "Create an Account",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(150, 179, 254, 1),
                        shape: BoxShape.circle,
                      ),
                      child: image != null
                          ? ClipOval(
                              child: Image.file(
                                image!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            )
                          : SvgPicture.asset("assets/icon/profile.svg"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              TextField(
                controller: userNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  hintText: "Username",
                  filled: true,
                  fillColor: const Color.fromRGBO(247, 248, 248, 1),
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 17, fontWeight: FontWeight.w300),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(11),
                    child: SvgPicture.asset(
                      "assets/icon/profile.svg",
                      color: const Color.fromRGBO(123, 111, 114, 1),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  hintText: "Email",
                  filled: true,
                  fillColor: const Color.fromRGBO(247, 248, 248, 1),
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 17, fontWeight: FontWeight.w300),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(11),
                    child: SvgPicture.asset("assets/icon/email.svg"),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Password TextField
              TextField(
                controller: passwordController,
                obscureText:
                    true, // Hide the text to show it as a password field
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  hintText: "Password",
                  filled: true,
                  fillColor: const Color.fromRGBO(247, 248, 248, 1),
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 17, fontWeight: FontWeight.w300),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(11),
                    child: SvgPicture.asset("assets/icon/Lock.svg"),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Confirm Password TextField
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  hintText: "Confirm Password",
                  filled: true,
                  fillColor: const Color.fromRGBO(247, 248, 248, 1),
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 17, fontWeight: FontWeight.w300),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(11),
                    child: SvgPicture.asset("assets/icon/Lock.svg"),
                  ),
                ),
              ),

              const SizedBox(height: 60),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(150, 179, 254, 1)),
                  ),
                  onPressed: () {
                    if (userNameController.text.trim().isNotEmpty &&
                        emailController.text.trim().isNotEmpty &&
                        passwordController.text.trim().isNotEmpty &&
                        confirmPasswordController.text.trim().isNotEmpty) {
                      signupData.addAll(
                        {
                          "userName": userNameController.text.trim(),
                          "email": emailController.text.trim(),
                          "password": confirmPasswordController.text.trim(),
                          "profilePic": image
                        },
                      );
                      print(signupData);
                     
                      CustomSnackBar.customSnackBar(
                          context: context,
                          message: "Register Sucsseful",
                          color: Colors.green);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Userinfo(),
                        ),
                      );
                      clearController();
                    } else {}

                    setState(() {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icon/Login.svg",
                        width: 30,
                        height: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Register",
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account yet?",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>  Login()),
                        );
                      },
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(
                            fontSize: 17,
                            color: Color.fromRGBO(150, 179, 254, 1)),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
