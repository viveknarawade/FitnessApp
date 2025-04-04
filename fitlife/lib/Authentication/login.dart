import 'dart:developer';

import 'package:fitlife/Authentication/signUp.dart';
import 'package:fitlife/Dashboard/home_ui.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';

import 'package:fitlife/main.dart';
import 'package:fitlife/widget/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitlife/Model/session_data.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      log("username = ${_userNameController.text}");
      log("password = ${_passwordController.text}");

      bool isAuthenticated = await Authservice().authenticate(
        _userNameController.text.trim(),
        _passwordController.text.trim(),
      );

      if (isAuthenticated) {
        await SessionData.setSessionData(
          loginData: true,
          userName: tempUserData[0]["userName"],
          email: tempUserData[0]["email"],
          password: tempUserData[0]["password"],
          gender: tempUserData[0]["gender"],
          goal: tempUserData[0]["goal"],
          id: tempUserData[0]["id"],
          age: tempUserData[0]["age"],
          height: tempUserData[0]["height"],
          weight: tempUserData[0]["weight"],
          coloriesGoal: tempUserData[0]["coloriesGoal"],
        );
        MainApp().sqfliteObj?.insertData(Authservice().toMap());
        log("SESSIONDATA ADDED :${Authservice().toMap()}");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeUi()),
        );
      } else {
        CustomSnackBar.customSnackBar(
          context: context,
          message: "Invalid Username and Password",
          color: Colors.red,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header
                  Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        "Hey there",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 9),
                      Text(
                        "Welcome Back",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),

                  // SVG Image
                  Stack(
                    children: [
                      SvgPicture.asset(
                        "assets/authentication/loginScr2.svg",
                        height: 250,
                        colorFilter: ColorFilter.mode(
                          Colors.blue.shade300,
                          BlendMode.srcIn,
                        ),
                      ),
                      SvgPicture.asset(
                        "assets/authentication/loginScr.svg",
                        height: 250,
                      ),
                    ],
                  ),
                  const SizedBox(height: 45),

                  // Username Field
                  TextFormField(
                    controller: _userNameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Username",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          "assets/icon/profile.svg",
                          colorFilter: ColorFilter.mode(
                            Colors.blue.shade300,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.blue.shade100,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.blue.shade100,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_passwordVisible,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset(
                          "assets/icon/Lock.svg",
                          colorFilter: ColorFilter.mode(
                            Colors.blue.shade300,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.blue.shade300,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.blue.shade100,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.blue.shade100,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Login Button
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade300,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icon/Login.svg",
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Register Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Signup(),
                            ),
                          );
                        },
                        child: Text(
                          "Register",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade300,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
