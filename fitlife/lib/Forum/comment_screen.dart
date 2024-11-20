import 'package:fitlife/Forum/comment_card.dart';
import 'package:fitlife/Forum/forum_home.dart';
import 'package:fitlife/Model/comment.dart';
import 'package:fitlife/Model/forum_post.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  final ForumPost post;

  const CommentScreen({Key? key, required this.post}) : super(key: key);

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  final List<Comment> _comments = [];

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        _comments.add(Comment(
          username: 'CurrentUser',
          content: _commentController.text,
          timestamp: DateTime.now(),
        ));
        widget.post.comments++;
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        backgroundColor: Colors.deepOrange[400],
      ),
      body: Column(
        children: [
          // Original Post Preview
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(widget.post.content),
                ],
              ),
            ),
          ),

          // Comments List
          Expanded(
            child: ListView.builder(
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                return CommentCard(comment: _comments[index]);
              },
            ),
          ),

          // Comment Input Section
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.deepOrange[400],
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: _addComment,
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
