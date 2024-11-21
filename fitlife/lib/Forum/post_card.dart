import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlife/Firebase/ForumDB/postDB.dart';
import 'package:fitlife/Forum/comment_screen.dart';
import 'package:fitlife/Model/forum_post.dart';
import 'package:flutter/material.dart';

class ForumPostCard extends StatelessWidget {
  final ForumPost post;

  const ForumPostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Username with blue color
                Text(
                  post.username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF5D7AEA), // Changed to deep blue
                  ),
                ),
                Text(
                  post.timestamp, // Ensure the date is formatted properly
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Title in a larger blue font
            Text(
              post.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF5D7AEA), // Changed to blue
              ),
            ),
            const SizedBox(height: 10),

            // Content text remains black or default
            Text(post.content),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // StreamBuilder for Like Status
                    StreamBuilder<bool>(
                      stream: Postdb().isPostLiked(post.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Icon(Icons.favorite_border,
                              color: Colors.grey); // Loading state
                        }
                        bool isLiked = snapshot.data ?? false;

                        return IconButton(
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked
                                ? Colors.red
                                : Colors.grey, // Like icon changed to blue
                          ),
                          onPressed: () async {
                            await Postdb().toggleLike(post.id);
                          },
                        );
                      },
                    ),
                    Text(
                      '${post.likes} likes',
                      style: TextStyle(
                          color: const Color(0xFF5D7AEA)), // Likes text in blue
                    ),
                  ],
                ),

                // Real-time comment count
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Forum")
                      .doc(post.id)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('0 Comments');
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return const Text('0 Comments');
                    }

                    var postData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    int commentCount = postData["comments"] ?? 0;

                    return Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.comment,
                              color: Colors.red), // Comment icon in light blue
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommentScreen(post: post),
                              ),
                            );
                          },
                        ),
                        Text(
                          '$commentCount Comments',
                          style: TextStyle(
                              color: const Color(
                                  0xFF5D7AEA)), // Comment count text in blue
                        ),
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
