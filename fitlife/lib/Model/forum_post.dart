class ForumPost {
  final String id; // Add this field
  final String username;
  final String title;
  final String content;
  final String timestamp;
  bool? isLike;
  int likes;
  int comments;

  ForumPost({
    required this.id, // Include the ID in the constructor
    required this.username,
    required this.title,
    required this.content,
    required this.timestamp,
    required this.likes,
    this.isLike,
    required this.comments,
  });
}
