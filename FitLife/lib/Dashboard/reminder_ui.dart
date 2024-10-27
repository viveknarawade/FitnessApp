import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ReminderUi extends StatefulWidget {
  const ReminderUi({super.key});
  State createState() => _RemainderUi();
}

class _RemainderUi extends State {
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(234, 240, 255,1)
                      ),
                      width: 70,
                      height: 70,
                    ),
                    SvgPicture.asset(
                      "assets/img/lunch.svg",width: 30,height: 30,
                    ),
                  ]),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hey, it’s time for lunch"),
                      Text("About 1 minutes ago")
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 13,top: 10,bottom: 10),
                child: Divider(),
              ),

            ],
          ),
        );
      }),
    );
  }
}
