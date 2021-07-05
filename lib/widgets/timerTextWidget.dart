import 'package:flutter/material.dart';

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
      style: TextStyle(
        color: Colors.white70,
        fontSize: 100
      ),
    );
  }
}
