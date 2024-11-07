import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

config() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDz0jTJP_7pOA2VqTpKuK_R1zTOpVQajJI",
          appId: "1:133562776760:android:d24731f903b36e82d7c84d",
          messagingSenderId: "133562776760",
          projectId: "fitnessapp-431bf"));
}
