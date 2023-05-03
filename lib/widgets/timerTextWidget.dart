import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerTextWidget extends StatefulWidget {
  final int? clockCount;
  final double? prefFont;
  const TimerTextWidget({Key? key, this.clockCount, this.prefFont}) : super(key: key);

  @override
  _TimerTextWidgetState createState() => _TimerTextWidgetState();
}

class _TimerTextWidgetState extends State<TimerTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
        widget.clockCount.toString().padLeft(2,'0'),
      style: GoogleFonts.poppins(
          color: Colors.white70,
          fontSize: widget.prefFont == null ? 130.0 : widget.prefFont),
    );
  }
}
