import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateNewTopicdb {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addNewTopic(String topicName, String description) async {
    try {
      await db.collection("Forum").doc("topics").collection("topic_list").add({
        "title": topicName,
        "description": description,
        "postCount": 0,
        "lastPostTime": FieldValue.serverTimestamp(),
      });
      log("New topic created successfully");
    } catch (e) {
      log("Error creating topic: $e");
    }
  }

  // Fetch all topics data
  Future<List<Map<String, dynamic>>> getTopicData() async {
    try {
      QuerySnapshot response = await db
          .collection("Forum")
          .doc("topics")
          .collection("topic_list")
          .get();

      print("Firestore response: ${response.docs.map((doc) => doc.data())}");

      return response.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error getting topic data: $e");
      return [];
    }
  }
}
