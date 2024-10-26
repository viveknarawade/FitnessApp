import 'package:flutter/material.dart';

class ProfileUi extends StatefulWidget {
  State createState() => _ProfileUiState();
}

class _ProfileUiState extends State {
  Widget build(context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: ContainerClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 270,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class  ContainerClipper  extends CustomClipper<Path> {
  getClip(Size size) {
    Path path = Path();
    path.lineTo(0,0);
    path.lineTo(0,size.height);
    path.lineTo(size.width,size.height);
    path.lineTo(size.width,0);
    return path;
  }

  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
