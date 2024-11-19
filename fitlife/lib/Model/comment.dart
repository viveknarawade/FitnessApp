import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String userId;
  final String content;
  final DateTime createdAt;

  Comment({
    required this.userId,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      userId: map['userId'],
      content: map['content'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'content': content,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}