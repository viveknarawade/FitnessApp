import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlife/Model/session_data.dart';
import 'package:intl/intl.dart';
import '../../Model/forum_post.dart';

class NewPostdb {
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

// Method to like or unlike the post with a specific postId
  Future<void> likePost(String postId) async {
    // Reference to the post document
    DocumentReference postRef = db.collection("Forum").doc(postId);

    // Reference to the Likes subcollection of the post (to track which users liked the post)
    DocumentReference userLikeRef =
        postRef.collection("Likes").doc(SessionData.id);

    // Check if the user has already liked the post
    DocumentSnapshot snapshot = await userLikeRef.get();
    if (snapshot.exists) {
      // If the document exists, the user already liked the post, so we remove the like
      await db.runTransaction((transaction) async {
        // Decrement the like count on the post
        transaction.update(postRef, {"likes": FieldValue.increment(-1)});
        // Remove the user's like status from the Likes subcollection
        transaction.delete(userLikeRef);
      });
      log("Post unliked by user: ${SessionData.id}");
    } else {
      // If the document does not exist, we add the like
      await db.runTransaction((transaction) async {
        // Increment the like count on the post
        transaction.update(postRef, {"likes": FieldValue.increment(1)});
        // Add the user to the Likes subcollection with their like status
        transaction.set(userLikeRef, {"isLiked": true});
      });
      log("Post liked by user: ${SessionData.id}");
    }
  }

// fetch post 
  Future<List<ForumPost>> getNewPostData() async {
    QuerySnapshot newPostResponse = await db.collection("Forum").get();
    List<ForumPost> tempPostData = [];

    for (var doc in newPostResponse.docs) {
      // Create a ForumPost object from Firestore data
      ForumPost post = ForumPost.fromFirestore(doc);

      // Check if the current user has liked this post
      DocumentReference userLikeRef =
          doc.reference.collection("Likes").doc(SessionData.id);
      DocumentSnapshot userLikeSnapshot = await userLikeRef.get();

      // Set isLike based on whether the user has liked the post
      post.isLike = userLikeSnapshot.exists;

      tempPostData.add(post);
    }

    return tempPostData;
  }

 
}
