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
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Create New Post',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF5D7AEA),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Post Title',
                  labelStyle: TextStyle(color: const Color(0xFF5D7AEA)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: const Color(0xFF5D7AEA)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: const Color(0xFF5D7AEA), width: 2),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _contentController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Post Content',
                  labelStyle: TextStyle(color: const Color(0xFF5D7AEA)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: const Color(0xFF5D7AEA)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: const Color(0xFF5D7AEA), width: 2),
                  ),
                ),
              ),
              SizedBox(height: 15),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5D7AEA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text(
                  'Post',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fitness & Nutrition Forum',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF5D7AEA),
        elevation: 0,
      ),
      body: StreamBuilder<List<ForumPost>>(
        stream: Postdb().getPostData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: const Color(0xFF5D7AEA),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Color(0xFF5D7AEA)),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.forum_outlined,
                    size: 80,
                    color: const Color(0xFF5D7AEA).withOpacity(0.5),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'No posts available.',
                    style: TextStyle(
                      color: const Color(0xFF5D7AEA),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
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
        backgroundColor: const Color(0xFF5D7AEA),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
