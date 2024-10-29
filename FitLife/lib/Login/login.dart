import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 70,horizontal: 40),
        child: Column(
          children: [
            Text("Hey there",
            style: GoogleFonts.poppins(
                    fontSize: 17, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 15,
            ),
            Text("Welcome Back",
            style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 70,
            ),
            TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Email",
              prefixIcon:  SvgPicture.asset("assets/icon/email.svg",width: 10,height: 40,),
              ),
            )
          ],
        ),
      ),
    );
  }
}
