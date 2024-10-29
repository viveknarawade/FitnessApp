import 'package:fitness_app/Dashboard/home_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Userinfo extends StatefulWidget {
  const Userinfo({super.key});

  @override
  State<Userinfo> createState() => _UserinfoState();
}

class _UserinfoState extends State<Userinfo> {
  String? selectedValue; // To store the selected dropdown value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 90,
            left: 35,
            right: 35,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Ensure full width
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  hintText: "Choose Gender",
                  filled: true,
                  fillColor: const Color.fromRGBO(247, 248, 248, 1),
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 17, fontWeight: FontWeight.w300),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(11),
                    child: SvgPicture.asset(
                      "assets/icon/profile.svg",
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  hintText: "Your Weight",
                  filled: true,
                  fillColor: const Color.fromRGBO(247, 248, 248, 1),
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 17, fontWeight: FontWeight.w300),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(11),
                    child: SvgPicture.asset("assets/icon/profile.svg",
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  hintText: "Your Height",
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
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(247, 248, 248, 1),
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(width: 1)),
                child: DropdownButton<String>(
                  isExpanded: true, // Make dropdown occupy full width
                  value: selectedValue,
                  hint: Text("Choose Goal"),
                  items: <String>["gain", "loss", "maintain"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue; // Update the selected value
                    });
                  },
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
                      MaterialPageRoute(builder: (context) => const HomeUi()),
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
                        "Next",
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
