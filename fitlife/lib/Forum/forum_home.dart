import 'package:fitlife/Firebase/ForumDB/postDB.dart';
import 'package:fitlife/Forum/post_card.dart';
import 'package:fitlife/Model/forum_post.dart';
import 'package:flutter/material.dart';

class FitnessNutritionForum extends StatefulWidget {
  @override
  _FitnessNutritionForumState createState() => _FitnessNutritionForumState();
}

class _FitnessNutritionForumState extends State<FitnessNutritionForum> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _createNewPost() async {
    final result = await showModalBottomSheet<bool>(
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
                if (_titleController.text.isNotEmpty &&
                    _contentController.text.isNotEmpty) {
                  Postdb().addNewPost(
                      _titleController.text, _contentController.text);

                  _titleController.clear();
                  _contentController.clear();

                  Navigator.pop(context, true); // Close the modal
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
      body: StreamBuilder<List<ForumPost>>(
        stream: Postdb().getPostData(), // Use getPostData stream here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No posts available.'));
          } else {
            List<ForumPost> posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ForumPostCard(post: posts[index]);
              },
            );
          }
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
