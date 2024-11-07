import 'package:firebase_core/firebase_core.dart';
import 'package:fitlife/Authentication/onboarding.dart';
import 'package:fitlife/Firebase/config.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDz0jTJP_7pOA2VqTpKuK_R1zTOpVQajJI",
          appId: "1:133562776760:android:d24731f903b36e82d7c84d",
          messagingSenderId: "133562776760",
          projectId: "fitnessapp-431bf"));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Onbording(),
      ),
    );
  }
}
