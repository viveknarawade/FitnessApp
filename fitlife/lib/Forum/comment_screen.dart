import 'dart:developer';

import 'package:fitlife/Firebase/ForumDB/commentDB.dart';
import 'package:fitlife/Forum/comment_card.dart';
import 'package:fitlife/Forum/forum_home.dart';
import 'package:fitlife/Model/comment.dart';
import 'package:fitlife/Model/forum_post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentScreen extends StatefulWidget {
  final ForumPost post;

  const CommentScreen({Key? key, required this.post}) : super(key: key);

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  void _addCommentData() async {
    if (_commentController.text.isNotEmpty) {
      // Add the new comment to Firestore
      Commentdb().addComment(widget.post.id, _commentController.text.trim());

      // Clear the comment input field
      _commentController.clear();

      // Increment the comment count for the post locally
      setState(() {
        widget.post.comments++;
      });
    }
  }

  void _dismissPost() {
    // Handle post dismissal, for example, by removing it from the UI
    // You can also trigger a delete operation from Firebase or navigate away.
    log('Post dismissed: ${widget.post.title}');
    // Example: Navigate back to the previous screen or delete the post from the database
    // Navigator.pop(context);
    // Commentdb().deletePost(widget.post.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Comments',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Original Post Preview with Dismissible Widget
          Dismissible(
            key: Key(widget.post.id),  // Use a unique identifier for the post (e.g., post ID)
            direction: DismissDirection.endToStart, // Swipe from right to left
            onDismissed: (direction) {
              _dismissPost();  // Call the function when dismissed
            },
            background: Container(
              color: Colors.red,  // Background color for the swipe
              alignment: Alignment.centerRight,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: Card(
              margin: const EdgeInsets.all(10),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18, // Larger title
                        color: Colors.black87, // Dark text color for contrast
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.post.content,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54), // Subtle content color
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Comments List using StreamBuilder
          Expanded(
            child: StreamBuilder<List<Comment>>(
              stream: Commentdb().getComment(widget.post.id), // Listening to real-time comments
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No comments yet.'));
                } else {
                  List<Comment> comments = snapshot.data!;
                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      return CommentCard(comment: comments[index]);
                    },
                  );
                }
              },
            ),
          ),

          // Comment Input Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(25), // Rounded input field
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Colors.blue, // Focus color matching theme
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 25, // Larger send button for easy interaction
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _addCommentData,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
