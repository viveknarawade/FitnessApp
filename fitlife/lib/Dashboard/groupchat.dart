import 'package:flutter/material.dart';

class Groupchat extends StatefulWidget {
  const Groupchat({super.key});

  @override
  State<Groupchat> createState() => _GroupchatState();
}

class _GroupchatState extends State<Groupchat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yoga"),
      ),
      body: Container(
        width: 270,
      
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade400,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      "assets/Feed/post.jpg",
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10,)
,                  Column(
  children: [
    Text("Yash Narawade"),
  ],
),
                ],
              ),
              Row(
                
                children: [
                  SizedBox(width: 51,),
                  Text("How to  Charkrasan"),
                ],
              ),
            ],
          )),
    );
  }
}
