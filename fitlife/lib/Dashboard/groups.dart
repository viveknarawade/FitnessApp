import 'package:fitlife/Dashboard/groupchat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    return   ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Column(
                children: [
                  GestureDetector(
                       onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return  Groupchat();
                    },
                  ),
                );
              },
                    child: Row(
                      children: [
                        Stack(alignment: Alignment.center, children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(234, 240, 255, 1)),
                            width: 70,
                            height: 70,
                          ),
                          SvgPicture.asset(
                            "assets/img/lunch.svg",
                            width: 30,
                            height: 30,
                          ),
                        ]),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Cycling Community",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "22 member",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 13, top: 10, bottom: 10),
                    child: Divider(),
                  ),
                ],
              ),
            );
          });
  }
}