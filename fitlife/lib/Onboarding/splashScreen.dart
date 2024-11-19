import 'dart:developer';

import 'package:fitlife/Authentication/login.dart';
import 'package:fitlife/SqfLite/intializeSqfLite.dart';
import 'package:flutter/material.dart';
import 'package:fitlife/Model/session_data.dart';
import 'package:fitlife/Dashboard/home_ui.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});
  navigateToLogin(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        await SessionData.getSessionData();
        log("IS LOGING :${SessionData.isLogin}");
        if (SessionData.isLogin!) {
          log("NAVIGATE TO HOME");

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return HomeUi();
              },
            ),
          );
        } else {
          log("NAVIGATE TO LOGIN");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Login();
              },
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    navigateToLogin(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(
          children: [
            Spacer(),
            Image.asset("assets/authentication/logo.png"),
            Spacer(),
            Text("Please wait"),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
              backgroundColor: Colors.white24,
            ),
          ],
        ),
      ),
    );
  }
}
