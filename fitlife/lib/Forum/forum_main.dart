import 'package:fitlife/Firebase/Firestore/Forum/create_new_topicDB.dart';
import 'package:fitlife/Forum/create_topic.dart';
import 'package:fitlife/Forum/forum_topic.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForumMainScreen extends StatefulWidget {
  const ForumMainScreen({super.key});

  @override
  _ForumMainScreenState createState() => _ForumMainScreenState();
}

class _ForumMainScreenState extends State<ForumMainScreen> {
  final List<ForumTopic> _topics = [];

  @override
  void initState() {
    super.initState();
    _fetchTopics();
  }

  Future<void> _fetchTopics() async {
    List<Map<String, dynamic>> topicsData =
        await CreateNewTopicdb().getTopicData();
    setState(() {
      _topics.addAll(
          topicsData.map((data) => ForumTopic.fromFirestore(data)).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fitness Forum',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: _topics.isEmpty
          ? Center(
              child: Text("No topics available", style: GoogleFonts.poppins()))
          : ListView.builder(
              itemCount: _topics.length,
              itemBuilder: (context, index) {
                return _buildForumTopicCard(_topics[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateTopicScreen(),
            ),
          );
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildForumTopicCard(ForumTopic topic) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      child: ListTile(
        title: Text(
          topic.title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topic.description,
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.message, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '${topic.postCount} Posts',
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
                const Spacer(),
                Text(
                  topic.lastPostTime,
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          // Navigate to topic detail screen (not implemented in this example)
        },
      ),
    );
  }
}
