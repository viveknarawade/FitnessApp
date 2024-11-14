import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
          margin: EdgeInsets.all(20    ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade400,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipOval(
                      child: Image.asset(
                    "assets/Feed/post.jpg",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  )),
                  SizedBox(
                    width: 24,
                  ),
                  Text(
                    "Yash | Today",
                    style: GoogleFonts.poppins(
                      fontSize: 16,fontWeight:FontWeight.w500 
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 17,
              ),
              Image.asset(
                "assets/Feed/post.jpg",
                width: 400,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 17,
              ),
              Text(
                "Hitting the gym after a month",
                style: GoogleFonts.poppins(
                  fontSize: 16,fontWeight:FontWeight.w400 
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "4",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Icon(
                    Icons.comment_rounded,
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
