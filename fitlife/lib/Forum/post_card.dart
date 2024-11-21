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
      margin: const EdgeInsets.symmetric(
          horizontal: 15, vertical: 10), // Updated margin for better spacing
      elevation: 3, // Softer shadow
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(15), // Rounded corners for a modern look
      ),
      child: Padding(
        padding: const EdgeInsets.all(
            15), // Internal padding to create space inside the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Username with a more noticeable color
                Text(
                  post.username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16, // Slightly larger for emphasis
                    color: const Color(0xFF5D7AEA), // Blue color for username
                  ),
                ),
                Text(
                  post.timestamp, // Ensure the date is formatted properly
                  style: const TextStyle(
                      color: Colors.grey, fontSize: 12), // Subtle date text
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Title in a bold blue font for prominence
            Text(
              post.title,
              style: TextStyle(
                fontSize: 20, // Slightly larger font size for titles
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2C3E50), // Darker blue for titles
              ),
            ),
            const SizedBox(height: 10),

            // Content text remains black or default, with proper spacing
            Text(
              post.content,
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87), // Content text in a readable size
            ),
            const SizedBox(
                height: 15), // Increased spacing before interaction buttons

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
                          return const Icon(
                            Icons.favorite_border,
                            color: Colors.grey,
                          ); // Loading state
                        }
                        bool isLiked = snapshot.data ?? false;

                        return IconButton(
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked
                                ? Colors.red
                                : Colors.grey, // Like icon logic
                          ),
                          onPressed: () async {
                            await Postdb().toggleLike(post.id);
                          },
                        );
                      },
                    ),
                    const SizedBox(
                        width: 5), // Small space between icon and text
                    Text(
                      '${post.likes} likes',
                      style: TextStyle(
                        color: const Color(
                            0xFF5D7AEA), // Blue color for like count
                        fontWeight:
                            FontWeight.w500, // Slightly bold for clarity
                      ),
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
                      return const Text(
                        '0 Comments',
                        style: TextStyle(
                            color: Colors
                                .grey), // Consistent style with placeholders
                      );
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return const Text(
                        '0 Comments',
                        style: TextStyle(color: Colors.grey),
                      );
                    }

                    var postData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    int commentCount = postData["comments"] ?? 0;

                    return Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.comment,
                            color: Color(
                                0xFF5D7AEA), // Consistent blue for comment icon
                          ),
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
                                0xFF5D7AEA), // Blue color for comment count
                            fontWeight: FontWeight.w500, // Slightly bold
                          ),
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
