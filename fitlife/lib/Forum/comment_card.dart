

import 'package:fitlife/Forum/forum_home.dart';
import 'package:fitlife/Model/comment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class CommentCard extends StatelessWidget {
  final Comment comment;

  const CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(
          comment.username,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange[700],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(comment.content),
            SizedBox(height: 5),
            Text(
              DateFormat('hh:mm a').format(comment.timestamp), // Format timestamp
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
