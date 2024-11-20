import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlife/Model/session_data.dart';
import 'package:intl/intl.dart';
import '../../Model/forum_post.dart';

class Postdb {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  DocumentReference? newPostRef;

  // Method to add a new post to Firestore
  Future<void> addNewPost(String title, String content) async {
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
    newPostRef = await db.collection("Forum").add(tempPostData);
    log("NEW POST DATA ADDED");
  }

// Method to toggle like status
  Future<void> toggleLike(String postId) async {
    DocumentReference postRef = db.collection("Forum").doc(postId);
    DocumentReference userLikeRef =
        postRef.collection("Likes").doc(SessionData.id);

    // Use a transaction for safe update
    await db.runTransaction((transaction) async {
      DocumentSnapshot likeSnapshot = await transaction.get(userLikeRef);

      if (likeSnapshot.exists) {
        // If user already liked the post, remove the like
        transaction.update(postRef, {"likes": FieldValue.increment(-1)});
        transaction.delete(userLikeRef);
      } else {
        // If not liked, add the like
        transaction.update(postRef, {"likes": FieldValue.increment(1)});
        transaction.set(userLikeRef, {"isLiked": true});
      }
    });
  }

  // Stream to check if the current user has liked a specific post
  Stream<bool> isPostLiked(String postId) {
    DocumentReference userLikeRef = db
        .collection("Forum")
        .doc(postId)
        .collection("Likes")
        .doc(SessionData.id);

    return userLikeRef.snapshots().map((snapshot) => snapshot.exists);
  }

  Stream<List<ForumPost>> getPostData() {
    CollectionReference postRef = db.collection("Forum");

    return postRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => ForumPost.fromFirestore(doc))
          .toList();
    });
  }
}
