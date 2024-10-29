import 'package:fitness_app/Authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Onbording extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(150, 179, 254, 1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 350),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("FitLife",
                  style: GoogleFonts.poppins(
                      fontSize: 30, fontWeight: FontWeight.bold)),
              Text(
                "Everbody Can Train",
                style: GoogleFonts.poppins(
                    fontSize: 23, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              SizedBox(
                width: 370,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: Text(
                    "Get Started",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
