import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Mytimeline extends StatefulWidget {
  const Mytimeline({super.key});

  @override
  State<Mytimeline> createState() => _MytimelineState();
}

class _MytimelineState extends State<Mytimeline> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        
        TimelineTile(
          isFirst: true,

        ),
        TimelineTile(),
        TimelineTile(
          isLast: true,
        ),
      ],
    );
  }
}
