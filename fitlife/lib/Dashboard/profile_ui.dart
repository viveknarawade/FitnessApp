import 'dart:developer';
import 'dart:typed_data';
import 'package:fitlife/Authentication/login.dart';
import 'package:fitlife/Dashboard/editProfile.dart';
import 'package:fitlife/Firebase/Firestore/User/auth.dart';
import 'package:fitlife/Model/session_data.dart';
import 'package:fitlife/main.dart';
import 'package:fitlife/widget/customAlertDemo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileUi extends StatefulWidget {
  @override
  State createState() => _ProfileUiState();
}

Uint8List? profilePic;

class _ProfileUiState extends State<ProfileUi> {
  List displayData = [];

  addDataToList() async {
    displayData = await MainApp().sqfliteObj?.getData();
    log("DISPLAY : $displayData");
    setState(() {});
  }

  fetchPic() async {
    profilePic = await MainApp().sqfliteObj?.getPic();
    log("FECTED BYTES $profilePic");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addDataToList();
    fetchPic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFE),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              _buildProfileHeader(),

              SizedBox(height: 30),

              // Stats Cards
              _buildStatsRow(),

              SizedBox(height: 50),

              // Account Section
              _buildAccountSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Profile Picture
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blue.shade200,
                width: 3,
              ),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: profilePic == null
                    ? SvgPicture.asset(
                        "assets/icon/profile.svg",
                        width: 100,
                        height: 100,
                      )
                    : Image.memory(
                        profilePic ?? Uint8List(0),
                        fit: BoxFit.cover,
                      )),
          ),

          SizedBox(width: 20),

          // Profile Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${SessionData.userName}",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "${SessionData.goal} Program",
                  style: GoogleFonts.poppins(
                    color: Colors.grey[600],
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          // Edit Button
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Editprofile()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: Text(
              'Edit',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard(
          value: "${SessionData.height} Cm",
          label: "Height",
          color: Colors.white,
        ),
        _buildStatCard(
          value: "${SessionData.weight} Kg",
          label: "Weight",
          color: Colors.white,
        ),
        _buildStatCard(
          value: "${SessionData.age!.toInt()} Year",
          label: "Age",
          color: Colors.white,
        ),
      ],
    );
  }

  Widget _buildStatCard(
      {required String value, required String label, required Color color}) {
    return Container(
      width: 110,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade800,
            ),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 20),

          // Goal Section
          _buildAccountRow(
            label: 'My Goal',
            value: '${SessionData.coloriesGoal!.toInt()}',
          ),

          Divider(height: 30, color: Colors.grey.shade300),

          // Delete Account
          _buildAccountAction(
            icon: Icons.delete_outline,
            label: 'Delete Account',
            onTap: () {
              MainApp().sqfliteObj?.deleteData(displayData[0]["ID"]);
              db.collection("User").doc(userData[0].id).delete();
              CustomAlertBoxDemo().showMyDialog(context, "Account Deleted");
              Future.delayed(Duration(seconds: 3), () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Login()),
                  (route) => false,
                );
              });
            },
          ),

          Divider(height: 30, color: Colors.grey.shade300),

          // Logout
          _buildAccountAction(
            icon: Icons.logout,
            label: 'Log Out',
            onTap: () {
              MainApp().sqfliteObj?.deleteData(displayData[0]["ID"]);
              SessionData.clearSessionData();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Login()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAccountRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.grey[700],
            fontSize: 18,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            color: Colors.blue.shade700,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildAccountAction(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.grey[700],
              ),
              SizedBox(width: 10),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: Colors.grey[700],
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.grey[700],
          ),
        ],
      ),
    );
  }
}
