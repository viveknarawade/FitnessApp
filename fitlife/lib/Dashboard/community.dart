import 'package:fitlife/Dashboard/feed.dart';
import 'package:fitlife/Dashboard/groups.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Community extends StatefulWidget {
  Community({super.key});

  @override
  State createState() => _CommunityState();
}

class _CommunityState extends State {
  String whichTab = "Feed";
ChagingNavigationtan(){
  if(whichTab=="Feed"){
        Feed();
      }else if(whichTab=="Groups"){
        Groups();
      } else{
        print("Invalid Tab"); 
      }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community"),
      ),
      body: Feed(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const Groups();
                    },
                  ),
                );
                whichTab="Feed";
                setState(() {
                  
                });
              },
              child: Text(
                "feed",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const Groups();
                    },
                  ),
                );
                whichTab="Groups";
                setState(() {
                  
                });
              },

              child: Text(
                "Groups",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const Groups();
                    },
                  ),
                );
                whichTab="";
setState(() {
  
});              },

              child: Text(
                "Workout Partner",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
