import 'package:flip_clock/clock_animation.dart';
import 'package:flip_clock/widgets/flip_widget.dart';
import 'package:flip_clock/widgets/timerTextWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static DateTime _currentDateTime = DateTime.now();
  bool _isListening = false;

  // stream
  Stream _timer = Stream.periodic(Duration(seconds: 1), (i) {
    _currentDateTime = _currentDateTime.add(Duration(seconds: 1));
    return _currentDateTime;
  });

  final hourFormat = DateFormat('hh');
  final minutesFormat = DateFormat('mm');
  final secondsFormat = DateFormat('ss');

  @override
  void initState() {
    super.initState();
    var date = DateTime.fromMillisecondsSinceEpoch(300000);
    _stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  _listenToTime() {
    _timer.listen((event) {
      print(event);
      _currentDateTime = DateTime.parse(event.toString());
    });
    _isListening = true;
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    _stopWatchTimer.onExecute.add(StopWatchExecute.start);

    // _isListening ? print('listening') : _listenToTime();

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: OrientationBuilder(builder: (context, layout) {
          if (layout == Orientation.landscape)
            return Padding(
              padding: EdgeInsets.symmetric(vertical: size.height / 2 - 120),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClockAnimation(
                    onTime: int.parse(
                        DateFormat("h").format(_currentDateTime).toString()),
                    timerDuration:
                        Duration(minutes: 60 - _currentDateTime.minute),
                    limit: 23,
                    start: 00,
                  ),
                  ClockAnimation(
                    onTime: _currentDateTime.minute,
                    timerDuration:
                        Duration(seconds: 60 - _currentDateTime.second),
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
              ),
            );
          else
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // minutes box
                ClockFlipWidget(
                  currentTime: 1,
                ),

               secondsStream()
              ],
            );
        }),
      ),
    );
  }

  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromSecond(300),
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    onEnded: () {
      print('onEnded');
    },
  );

  final _scrollController = ScrollController();

  Widget secondsStream() {
    return  // seconds box
      StreamBuilder<int>(
        stream: _stopWatchTimer.rawTime,
        initialData: _stopWatchTimer.rawTime.value,
        builder: (context, snap) {
          final value = snap.data;
          print('Listen every raw time. $value');
          
          var time = DateTime.fromMillisecondsSinceEpoch(value!);
          return Padding(
              padding: const EdgeInsets.all(2.0),
              child: ClockFlipWidget(
                currentTime: int.parse(secondsFormat.format(time)),
              )
          );
        },
      );
  }
}
