import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlife/Firebase/ForumDB/new_postDB.dart';
import 'package:fitlife/Forum/comment_screen.dart';
import 'package:fitlife/Forum/forum_home.dart';
import 'package:fitlife/Model/forum_post.dart';
import 'package:flutter/material.dart';

class ForumPostCard extends StatefulWidget {
  final ForumPost post;

  const ForumPostCard({Key? key, required this.post}) : super(key: key);

  @override
  _ForumPostCardState createState() => _ForumPostCardState();
}class _ForumPostCardState extends State<ForumPostCard> {
  late bool _isLiked; // Variable to store like status

  @override
  void initState() {
    super.initState();
    _isLiked = widget.post.isLike; // Initialize _isLiked with the post's current like status
  }

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
                  widget.post.username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange[700],
                  ),
                ),
                Text(
                  DateTime.now().toString().substring(0, 10),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              widget.post.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(widget.post.content),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        _isLiked ? Icons.favorite : Icons.favorite_border,
                        color: _isLiked
                            ? Colors.red
                            : Colors.grey, // Change color based on _isLiked
                      ),
                      onPressed: () async {
                        setState(() {
                          _isLiked = !_isLiked;
                          if (_isLiked) {
                            widget.post.likes++; // Increment like count locally
                          } else {
                            widget.post.likes--; // Decrement like count locally
                          }
                        });

                        // Update the like status in Firestore
                        await NewPostdb().likePost(widget.post.id);

                        // After updating the like in Firestore, reload the post data
                        List<ForumPost> posts = await NewPostdb().getNewPostData();
                        ForumPost updatedPost = posts.firstWhere((post) => post.id == widget.post.id);
                        setState(() {
                          _isLiked = updatedPost.isLike; // Sync local state with Firestore
                        });
                      },
                    ),
                    Text('${widget.post.likes} likes'),
                  ],
                ),

                // Real-time Comment Count using StreamBuilder
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Forum")
                      .doc(widget.post.id)
                      .snapshots(), // Listen to the post document
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
                                builder: (context) =>
                                    CommentScreen(post: widget.post),
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
