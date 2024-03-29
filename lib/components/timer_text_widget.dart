import 'package:flip_clock/utils/screen_utils.dart';
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
    return Container(
      height: fullHeight(context),
      width: fullWidth(context) / 3,
      padding: const EdgeInsets.all(10),
      child: FittedBox(
        fit: BoxFit.cover,
        child: Text(
          widget.clockCount.toString().padLeft(2, '0'),
          style: GoogleFonts.poppins(
            color: Colors.white70,
            //fontSize: 140,
          ),
        ),
      ),
    );
  }
}
