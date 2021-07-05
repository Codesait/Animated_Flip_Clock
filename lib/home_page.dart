import 'package:flip_clock/clock_animation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static DateTime _currentDateTime = DateTime.now();
  bool _isListening = false;

  // stream
  Stream _timer = Stream.periodic(Duration(seconds: 1),(i){
    _currentDateTime = _currentDateTime.add(Duration(seconds: 1));
    return _currentDateTime;
  });


  _listenToTime(){
    _timer.listen((event) {
      print(event);
      _currentDateTime = DateTime.parse(event.toString());
    });
    _isListening = true;
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    _isListening ? print('listening') : _listenToTime();

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: OrientationBuilder(
          builder: (context,layout){
            if(layout == Orientation.landscape)
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClockAnimation(
                    onTime: _currentDateTime.hour,
                    timerDuration: Duration(hours: 60-_currentDateTime.minute),
                    limit: 24,
                    start: 00,
                  ),
                  ClockAnimation(
                    onTime: _currentDateTime.minute,
                    timerDuration: Duration(seconds: 60-_currentDateTime.second),
                    limit: 59,
                    start: 00,
                  ),
                  ClockAnimation(
                    onTime: _currentDateTime.second,
                    timerDuration: Duration(seconds: 1),
                    limit: 59,
                    start: 00,
                  ),
                ],
              );
            else return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClockAnimation(
                  onTime: _currentDateTime.hour,
                  timerDuration: Duration(minutes: 60 -_currentDateTime.minute),
                  limit: 24,
                  start: 00,
                ),
                ClockAnimation(
                  onTime: _currentDateTime.minute,
                  timerDuration: Duration(seconds: 60 -_currentDateTime.second),
                  limit: 59,
                  start: 00,
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
