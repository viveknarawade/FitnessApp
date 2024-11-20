import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Comment {
  final String username;
  final String content;
  final DateTime timestamp;

  Comment({
    required this.username,
    required this.content,
    required this.timestamp,
  });

  factory Comment.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Comment(
      username: data['userName'] ?? '',
      content: data['content'] ?? '',
      timestamp: DateFormat('hh:mm a').parse(data['timestamp']),
    );
  }
}
