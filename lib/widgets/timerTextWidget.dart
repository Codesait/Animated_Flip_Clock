import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerTextWidget extends StatefulWidget {
  final int? clockCount;
  const TimerTextWidget({Key? key, this.clockCount}) : super(key: key);

  @override
  _TimerTextWidgetState createState() => _TimerTextWidgetState();
}

class _TimerTextWidgetState extends State<TimerTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
        widget.clockCount.toString().padLeft(2,'0'),
      style: GoogleFonts.permanentMarker(color: Colors.white70,fontSize: 130.0),
    );
  }
}
