import 'package:fitlife/Firebase/ForumDB/commentDB.dart';
import 'package:fitlife/Forum/forum_home.dart';
import 'package:fitlife/Model/comment.dart';
import 'package:fitlife/widget/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  final String postId; // Pass postId to the CommentCard

  const CommentCard({Key? key, required this.comment, required this.postId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) async {
        if (direction == DismissDirection.endToStart) {
          // Delete the comment by its ID
          await Commentdb().deleteComment(postId, comment.id);

          // Show success message
          CustomSnackBar.customSnackBar(
              context: context,
              message: "Comment deleted successfully",
              color: Colors.green);
        }
      },
      background: Container(
        height: 50,
        color: Colors.red,
        child: Icon(Icons.delete),
      ),
      key: Key(comment.id), // Use comment.id as the key
      child: Card(
        elevation: 3,
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
                DateFormat('hh:mm a')
                    .format(comment.timestamp), // Format timestamp
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
