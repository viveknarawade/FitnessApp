import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlife/Model/session_data.dart';
import 'package:intl/intl.dart';
import '../../Model/forum_post.dart';

class NewPostdb {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Method to add a new post to Firestore
  Future<void> addNewPost(String title, String content, bool isLike) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    
    Map<String, dynamic> tempPostData = {
      "userName": SessionData.userName,
      "title": title,
      "content": content,
      "timestamp": formattedDate,
      "likes": 0,
      "comments": 0,
    };

    // Add new post and get postId
    DocumentReference newPostRef = await db.collection("Forum").add(tempPostData);
    log("NEW POST DATA ADDED");

    // Create the like collection for the post
    createLikeCollection(newPostRef.id, isLike);
  }

  // Method to create a like collection for each post with initial like status for the current user
  void createLikeCollection(String postId, bool isLike) {
    db
        .collection("Forum")
        .doc(postId)
        .collection("likesCollection")
        .doc(SessionData.id) // Use a unique identifier for each user
        .set({"isLike": isLike});
  }

  // Fetch post data
  Future<List<ForumPost>> getNewPostData() async {
    QuerySnapshot newPostResponse = await db.collection("Forum").get();
    List<ForumPost> tempPostData = [];

    for (var doc in newPostResponse.docs) {
      tempPostData.add(
        ForumPost(
          id: doc.id,
          username: doc["userName"],
          title: doc["title"],
          content: doc["content"],
          timestamp: doc["timestamp"],
          likes: doc["likes"],
          comments: doc["comments"],
        ),
      );
    }
    return tempPostData;
  }

  addIsLike(bool isLike, String postId) {
    db.collection("Forum").doc(postId).update({"isLike": isLike});
  }

  addUnLike(bool isLike, String postId) {
    db.collection("Forum").doc(postId).update({"isLike": isLike});
  }

  incrementLike(String postId) async {
    await db.collection("Forum").doc(postId).update({
      "likes": FieldValue.increment(1),
    });
  }

  decrementLike(String postId) async {
    await db.collection("Forum").doc(postId).update({
      "likes": FieldValue.increment(-1),
    });
  }
}
