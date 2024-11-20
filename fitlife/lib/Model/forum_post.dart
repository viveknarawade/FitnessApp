import 'package:cloud_firestore/cloud_firestore.dart';

class ForumPost {
  final String id; // Post ID from Firestore
  final String username;
  final String title;
  final String content;
  final String timestamp;
  bool isLike; // Changed to bool to indicate if the post is liked or not
  int likes;
  int comments;

  ForumPost({
    required this.id,
    required this.username,
    required this.title,
    required this.content,
    required this.timestamp,
    required this.likes,
    required this.isLike, // Initialize the isLike field here
    required this.comments,
  });

  // Factory constructor to create a ForumPost object from Firestore data
  factory ForumPost.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return ForumPost(
      id: doc.id,
      username: data['userName'] ?? '',
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      timestamp: data['timestamp'] ?? '',
      likes: data['likes'] ?? 0,
      isLike: false, // Initialize isLike here to false by default
      comments: data['comments'] ?? 0,
    );
  }
}
