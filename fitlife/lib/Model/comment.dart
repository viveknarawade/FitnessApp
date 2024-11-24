import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Comment {
  final String id; // commentId
  final String username;
  final String content;
  final DateTime timestamp;

  Comment({
    required this.id,
    required this.username,
    required this.content,
    required this.timestamp,
  });

  // Update the factory constructor to get the document ID as well
  factory Comment.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Comment(
      id: doc.id, // Capture the Firestore document ID
      username: data['userName'] ?? '',
      content: data['content'] ?? '',
      timestamp: DateFormat('hh:mm a').parse(data['timestamp']),
    );
  }
}
