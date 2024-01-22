import 'package:flip_clock/components/flip_widget.dart';
import 'package:flip_clock/components/side_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // static DateTime _currentDateTime = DateTime.now();
  final minutesFormat = DateFormat('m');
  final secondsFormat = DateFormat('ss');

  late bool sidebarVisible = true;

  @override
  void initState() {
    super.initState();
    // var date = DateTime.fromMillisecondsSinceEpoch(300000);
    _stopWatchTimer.secondTime
        .listen((value) => debugPrint('secondTime $value'));
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            if (sidebarVisible) {
              sidebarVisible = false;
            } else {
              sidebarVisible = true;
            }
          });
        },
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              SizedBox(
                height: size.height,
                width: sidebarVisible ? size.width - 60 : size.width,
                child: OrientationBuilder(
                  builder: (context, layout) {
                    if (layout == Orientation.landscape) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: size.height / 2 - 120,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: _TimeStream(
                                type:'h',
                                prefHeight: 100,
                                prefWidth: 150,
                                stopWatchTimer: _stopWatchTimer,
                              ),
                            ),
                            Expanded(
                              child: _TimeStream(
                                type: 'm',
                                prefHeight: 100,
                                prefWidth: 150,
                                stopWatchTimer: _stopWatchTimer,
                              ),
                            ),
                            Expanded(
                              child: _TimeStream(
                                type: 's',
                                stopWatchTimer: _stopWatchTimer,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // hour box
                          _TimeStream(
                            type: 'h',
                            stopWatchTimer: _stopWatchTimer,
                          ),

                          //minute box
                          _TimeStream(
                            type: 'm',
                            stopWatchTimer: _stopWatchTimer,
                          ),
                          SizedBox(
                            width: 210,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const SizedBox(
                                  width: 130,
                                ),
                                Flexible(
                                  child: _TimeStream(
                                    type: 's',
                                    fontSize: 50,
                                    prefHeight: 40,
                                    prefWidth: 65,
                                    stopWatchTimer: _stopWatchTimer,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
              Positioned(
                right: 10,
                height: size.height,
                child: Center(
                  child: Visibility(
                    visible: sidebarVisible,
                    child: SideBar(
                      size: size,
                      stopWatchTimer: _stopWatchTimer,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // timer package constructor --------------------
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromMinute(30),
    // onChange: (value) => print('onChange $value'),
    // onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    // onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    onEnded: () {
      if (kDebugMode) {
        print('onEnded');
      }
    },
  );
}

class _TimeStream extends StatelessWidget {
  const _TimeStream({
    required this.type,
    required this.stopWatchTimer,
    this.fontSize,
    this.prefHeight,
    this.prefWidth,
    super.key,
  });

  final String type;
  final double? fontSize;
  final double? prefHeight;
  final double? prefWidth;
  final StopWatchTimer stopWatchTimer;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: stopWatchTimer.rawTime,
      initialData: stopWatchTimer.rawTime.value,
      builder: (context, snap) {
        final value = snap.data;
        final displayTime = StopWatchTimer.getDisplayTime(value!);

        final newHr = displayTime;

        //--------------- using time raw milliseconds
        final time = DateTime.fromMillisecondsSinceEpoch(value);

        //--------------- check time type and then format
        late int currentTime;
        if (type == 'h') {
          // if hour i will use get charAt to get hour from entire dateTime
          final hour = newHr[0] + newHr[1];
          currentTime = int.parse(hour);
        } else if (type == 'm') {
          currentTime = int.parse(DateFormat('m').format(time));
        } else {
          currentTime = int.parse(DateFormat('ss').format(time));
        }

        return Padding(
          padding: const EdgeInsets.all(2),
          child: ClockFlipWidget(
            currentTime: currentTime,
            prefFont: fontSize,
            prefHeight: prefHeight!,
            prefWeight: prefWidth!,
          ),
        );
      },
    );
  }
}
