import 'package:flutter/material.dart';

class FitnessNutritionForum extends StatefulWidget {
  @override
  _FitnessNutritionForumState createState() => _FitnessNutritionForumState();
}

class _FitnessNutritionForumState extends State<FitnessNutritionForum> {
  final List<ForumPost> _posts = [
    ForumPost(
      username: 'FitnessPro',
      title: 'Best Protein Shakes for Muscle Gain',
      content: 'Looking for recommendations on high-protein shakes that really help with muscle building.',
      likes: 42,
      comments: 15,
    ),
    ForumPost(
      username: 'NutritionGuru',
      title: 'Vegan Meal Prep Strategies',
      content: 'Share your favorite vegan meal prep techniques that keep you energized throughout the week.',
      likes: 38,
      comments: 22,
    ),
  ];

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _createNewPost() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Post Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Post Content',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
                  setState(() {
                    _posts.insert(0, ForumPost(
                      username: 'CurrentUser',
                      title: _titleController.text,
                      content: _contentController.text,
                      likes: 0,
                      comments: 0,
                    ));
                    _titleController.clear();
                    _contentController.clear();
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness & Nutrition Forum'),
        backgroundColor: Colors.deepOrange[400],
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          return ForumPostCard(post: _posts[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewPost,
        backgroundColor: Colors.deepOrange[400],
        child: Icon(Icons.add),
      ),
    );
  }
}

class ForumPost {
  final String username;
  final String title;
  final String content;
  int likes;
  int comments;

  ForumPost({
    required this.username,
    required this.title,
    required this.content,
    this.likes = 0,
    this.comments = 0,
  });
}

class ForumPostCard extends StatefulWidget {
  final ForumPost post;

  const ForumPostCard({Key? key, required this.post}) : super(key: key);

  @override
  _ForumPostCardState createState() => _ForumPostCardState();
}

class _ForumPostCardState extends State<ForumPostCard> {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.post.username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange[700],
                  ),
                ),
                Text(
                  DateTime.now().toString().substring(0, 10),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              widget.post.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(widget.post.content),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        _isLiked ? Icons.favorite : Icons.favorite_border,
                        color: Colors.deepOrange[400],
                      ),
                      onPressed: () {
                        setState(() {
                          _isLiked = !_isLiked;
                          _isLiked 
                            ? widget.post.likes++ 
                            : widget.post.likes--;
                        });
                      },
                    ),
                    Text('${widget.post.likes} Likes'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.comment, color: Colors.deepOrange[400]),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentSection(post: widget.post)
                          )
                        );
                      },
                    ),
                    Text('${widget.post.comments} Comments'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CommentSection extends StatefulWidget {
  final ForumPost post;

  const CommentSection({Key? key, required this.post}) : super(key: key);

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController _commentController = TextEditingController();
  final List<Comment> _comments = [];

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        _comments.add(Comment(
          username: 'CurrentUser',
          content: _commentController.text,
          timestamp: DateTime.now(),
        ));
        widget.post.comments++;
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        backgroundColor: Colors.deepOrange[400],
      ),
      body: Column(
        children: [
          // Original Post Preview
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(widget.post.content),
                ],
              ),
            ),
          ),
          
          // Comments List
          Expanded(
            child: ListView.builder(
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                return CommentCard(comment: _comments[index]);
              },
            ),
          ),
          
          // Comment Input Section
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Colors.deepOrange[400],
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: _addComment,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Comment {
  final String username;
  final String content;
  final DateTime timestamp;

  Comment({
    required this.username,
    required this.content,
    required this.timestamp,
  });
}

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
              '${comment.timestamp.hour}:${comment.timestamp.minute}',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}