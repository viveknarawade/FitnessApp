import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlife/Model/comment.dart';
import 'package:fitlife/Model/session_data.dart';
import 'package:intl/intl.dart';

class Commentdb {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Method to add a comment (no changes here)
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

  // Method to fetch comments in real-time

  Stream<List<Comment>> getComment(String postId) {
    DocumentReference postRef = db.collection("Forum").doc(postId);

    // Stream to listen to the comments collection in real-time
    return postRef.collection("Comments").orderBy("timestamp").snapshots().map(
      (querySnapshot) {
        // Convert Firestore documents into Comment objects
        return querySnapshot.docs
            .map(
                (doc) => Comment.fromFirestore(doc)) // Pass doc.id to the model
            .toList();
      },
    );
  }

// Method to delete a specific comment by its ID
  Future<void> deleteComment(String postId, String commentId) async {
    try {
      log(commentId);
      //Get reference to the specific post document
      DocumentReference postRef = db.collection("Forum").doc(postId);

      // Delete the comment document from the Comments subcollection using the commentId
      await postRef.collection("Comments").doc(commentId).delete();

      // Optionally, update the comment count for the post after a comment is deleted
      await postRef.update({"comments": FieldValue.increment(-1)});

      log("Comment deleted successfully");
    } catch (e) {
      log("Error deleting comment: $e");
    }
  }
}
