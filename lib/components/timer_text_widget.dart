import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerTextWidget extends StatefulWidget {
  const TimerTextWidget({super.key, this.clockCount, this.prefFont});
  final int? clockCount;
  final double? prefFont;

  @override
  TimerTextWidgetState createState() => TimerTextWidgetState();
}

class TimerTextWidgetState extends State<TimerTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.clockCount.toString().padLeft(2, '0'),
      style: GoogleFonts.poppins(
        color: Colors.white70,
        fontSize: widget.prefFont ?? 130.0,
      ),
    );
  }
}
