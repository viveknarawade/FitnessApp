import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlife/Model/comment.dart';
import 'package:fitlife/Model/session_data.dart';
import 'package:intl/intl.dart';

class Commentdb {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> addComment(String postId, String commentContent) async {
    DocumentReference postRef = db.collection("Forum").doc(postId);

    // Check if the post document exists before updating
    DocumentSnapshot postSnapshot = await postRef.get();

    if (postSnapshot.exists) {
      // If the post exists, proceed to add the comment
      CollectionReference commentRef =
          postRef.collection("Comments"); // Nested comments collection

      Map<String, dynamic> newComment = {
        "userName": SessionData.userName,
        "content": commentContent,
        "timestamp": DateFormat('hh:mm a').format(DateTime.now()),
      };

      // Add comment to the subcollection of the post
      await commentRef.add(newComment);

      // Update comment count on the post document in the Forum collection
      await postRef.update({"comments": FieldValue.increment(1)});

      log("Comment added and comment count updated successfully!");
    }
  }

  Future<List<Comment>> getComment(String postId) async {
    DocumentReference postRef = db.collection("Forum").doc(postId);

    // List to store the fetched comments
    List<Comment> tempCommentData = [];

    // Check if the post document exists
    DocumentSnapshot postSnapshot = await postRef.get();

    if (postSnapshot.exists) {
      // If the post exists, proceed to fetch the comments
      QuerySnapshot commentResponse =
          await postRef.collection("Comments").get();

      for (var doc in commentResponse.docs) {
        // Create Comment object from Firestore document
        Comment comment = Comment.fromFirestore(doc);
        tempCommentData.add(comment); // Add comment to the list
      }

      log("Comments fetched: ${tempCommentData.length} comments found.");
    } else {
      log("Post does not exist.");
    }

    // Return the list of comments
    return tempCommentData;
  }
}
