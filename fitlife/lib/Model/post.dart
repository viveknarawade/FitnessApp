import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitlife/Model/comment.dart';

class ForumPost {
  final String id;
  final String userId;
  final String title;
  final String content;
  final String category;
  final DateTime createdAt;
  final int likes;
  final List<Comment> comments;

  ForumPost({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.category,
    required this.createdAt,
    this.likes = 0,
    this.comments = const [],
  });

  factory ForumPost.fromMap(Map<String, dynamic> map, String id) {
    return ForumPost(
      id: id,
      userId: map['userId'],
      title: map['title'],
      content: map['content'],
      category: map['category'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      likes: map['likes'] ?? 0,
      comments: (map['comments'] as List<dynamic>?)
              ?.map((c) => Comment.fromMap(c))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'content': content,
      'category': category,
      'createdAt': Timestamp.fromDate(createdAt),
      'likes': likes,
      'comments': comments.map((c) => c.toMap()).toList(),
    };
  }
}
