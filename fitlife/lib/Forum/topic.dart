import 'package:fitlife/Forum/forum_comment.dart';
import 'package:fitlife/Forum/forum_main.dart';
import 'package:fitlife/Forum/forum_topic.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopicDetailScreen extends StatefulWidget {
  final ForumTopic topic;

  const TopicDetailScreen({super.key, required this.topic});

  @override
  _TopicDetailScreenState createState() => _TopicDetailScreenState();
}

class _TopicDetailScreenState extends State<TopicDetailScreen> {
  final _commentController = TextEditingController();
  final List<ForumComment> _comments = [
    ForumComment(
      username: 'FitnessGuru',
      comment: 'Great topic! Always looking for motivation.',
      timestamp: '1h ago',
    ),
    ForumComment(
      username: 'WorkoutWarrior',
      comment: 'Some days are tough, but consistency is key!',
      timestamp: '2h ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.topic.title,
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                return _buildCommentCard(_comments[index]);
              },
            ),
          ),
          _buildCommentInput(),
        ],
      ),
    );
  }

  Widget _buildCommentCard(ForumComment comment) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          comment.username,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.comment,
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(height: 8),
            Text(
              comment.timestamp,
              style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentInput() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Write a comment...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Colors.deepPurpleAccent,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                // Implement send comment logic
              },
            ),
          ),
        ],
      ),
    );
  }
}
