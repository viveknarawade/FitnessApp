import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlife/Firebase/ForumDB/postDB.dart';
import 'package:fitlife/Forum/comment_screen.dart';
import 'package:fitlife/Forum/forum_home.dart';
import 'package:fitlife/Model/forum_post.dart';
import 'package:flutter/material.dart';


class ForumPostCard extends StatelessWidget {
  final ForumPost post;

  const ForumPostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  post.username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange[700],
                  ),
                ),
                Text(
                  post.timestamp, // Ensure the date is formatted properly
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              post.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(post.content),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // StreamBuilder for Like Status
                    StreamBuilder<bool>(
                      stream: Postdb().isPostLiked(post.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Icon(Icons.favorite_border, color: Colors.grey); // Loading state
                        }
                        bool isLiked = snapshot.data ?? false;

                        return IconButton(
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.grey,
                          ),
                          onPressed: () async {
                            await Postdb().toggleLike(post.id);
                          },
                        );
                      },
                    ),
                    Text('${post.likes} likes'),
                  ],
                ),

                // Real-time comment count
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection("Forum").doc(post.id).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('0 Comments');
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return Text('0 Comments');
                    }

                    var postData = snapshot.data!.data() as Map<String, dynamic>;
                    int commentCount = postData["comments"] ?? 0;

                    return Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.comment, color: Colors.deepOrange[400]),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommentScreen(post: post),
                              ),
                            );
                          },
                        ),
                        Text('$commentCount Comments'),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
