import 'package:fitness_app/Authentication/signUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 70,
            left: 35,
            right: 35,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Ensure full width
            children: [
              Text(
                "Hey there",
                style: GoogleFonts.poppins(
                    fontSize: 17, fontWeight: FontWeight.w500),
              ),
             // const SizedBox(height: 7),
              Text(
                "Welcome Back",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SvgPicture.asset("assets/authentication/loginScr.svg"),
              const SizedBox(height: 45),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  hintText: "Email",
                  filled: true,
                  fillColor: const Color.fromRGBO(247, 248, 248, 1),
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 17, fontWeight: FontWeight.w300),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(11),
                    child: SvgPicture.asset("assets/icon/email.svg"),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  hintText: "Password",
                  filled: true,
                  fillColor: const Color.fromRGBO(247, 248, 248, 1),
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 17, fontWeight: FontWeight.w300),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(11),
                    child: SvgPicture.asset("assets/icon/Lock.svg"),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(150, 179, 254, 1)),
                  ),
                  onPressed: () {
                    // Handle login logic here
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icon/Login.svg",
                        width: 30,
                        height: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Login",
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account yet?",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: (){
                              Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Signup()),
                    );
                    },
                      child: Text(
                    "Register",
                    style: GoogleFonts.poppins(
                        fontSize: 17, color: Color.fromRGBO(150, 179, 254, 1)),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}