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
}
class _ForumPostCardState extends State<ForumPostCard> {
  late bool _isLiked; // Define _isLiked variable

  @override
  void initState() {
    super.initState();
    _isLiked = false; // Initialize _isLiked with the current post's like state
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
                        color: _isLiked ? Colors.red : Colors.grey, // Change color based on _isLiked
                      ),
                      onPressed: () {
                        setState(() {
                          _isLiked = !_isLiked;

                          if (_isLiked) {
                            widget.post.likes++;
                            NewPostdb().incrementLike(widget.post.id);
                            NewPostdb().addIsLike(true, widget.post.id);
                          } else {
                            widget.post.likes--;
                            NewPostdb().decrementLike(widget.post.id);
                            NewPostdb().addUnLike(false, widget.post.id);
                          }
                        });
                      },
                    ),
                    Text('${widget.post.likes} Likes'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.comment, color: Colors.deepOrange[400]),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentScreen(post: widget.post),
                          ),
                        );
                      },
                    ),
                    Text('${widget.post.comments} Comments'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
