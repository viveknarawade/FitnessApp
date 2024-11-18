class ForumTopic {
  final String title;
  final String description;
  final int postCount;
  final String lastPostTime;

  ForumTopic({
    required this.title,
    required this.description,
    required this.postCount,
    required this.lastPostTime,
  });

  factory ForumTopic.fromFirestore(Map<String, dynamic> data) {
    return ForumTopic(
      title: data['title'],
      description: data['description'],
      postCount: data['postCount'] ?? 0,
      lastPostTime: data['lastPostTime']?.toDate().toString() ?? '',
    );
  }
}
