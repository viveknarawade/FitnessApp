import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[300],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Image.network(
                          "https://tse2.mm.bing.net/th?id=OIP.8kdDYRZyn8HElQ40Npuv1wHaLH&pid=Api&P=0&h=180",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      Text(
                        "Yash |",
                        style: GoogleFonts.poppins(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        "Today",
                        style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.network(
                      "https://ifbb-academy.com/wp-content/uploads/2020/05/master-bb.jpg"),
                  SizedBox(height: 10),
                  Text(
                    "Hitting the gym after a month",
                    style: GoogleFonts.poppins(
                        fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text("4"),
                      SizedBox(
                        width: 50,
                      ),
                      Icon(
                        Icons.message,
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
