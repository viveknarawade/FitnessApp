import 'package:fitlife/Authentication/login.dart';
import 'package:fitlife/SqfLite/intializeSqfLite.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatelessWidget {
  final SqfLite sqfliteObj;
  const Splashscreen({required this.sqfliteObj,super.key});
  navigateToLogin(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return Login();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    navigateToLogin(context);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(60),
          child: Image.asset("assets/authentication/logo.png"),
        ),
      ),
    );
  }
}
