import 'package:fitlife/Firebase/ForumDB/new_postDB.dart';
import 'package:fitlife/Forum/post_card.dart';
import 'package:fitlife/Model/forum_post.dart';
import 'package:flutter/material.dart';

class FitnessNutritionForum extends StatefulWidget {
  @override
  _FitnessNutritionForumState createState() => _FitnessNutritionForumState();
}

class _FitnessNutritionForumState extends State<FitnessNutritionForum> {
  final List<ForumPost> _posts = [];

  @override
  void initState() {
    super.initState();
    getNewPostData();
  }

  // Fetch new post data from the database
  getNewPostData() async {
    List<ForumPost> post = await NewPostdb().getNewPostData();
    setState(() {
      _posts.addAll(post); // Add the post to the list
    });
  }

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
                  NewPostdb().addNewPost(
                      _titleController.text, _contentController.text,false);

                  _titleController.clear();
                  _contentController.clear();

                  // Return true to indicate a new post was added
                  Navigator.pop(context, true);
                }
              },
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );

    // Check if a new post was added, and refresh the data
    if (result == true) {
      _posts.clear();
      await getNewPostData();
    }
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
          return ForumPostCard(
            post: _posts[index],
          );
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
