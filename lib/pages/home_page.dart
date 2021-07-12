import 'package:flip_clock/widgets/flip_widget.dart';
import 'package:flip_clock/widgets/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 // static DateTime _currentDateTime = DateTime.now();



  final minutesFormat = DateFormat('m');
  final secondsFormat = DateFormat('ss');

 late bool sidebarVisible = true;

  @override
  void initState() {
    super.initState();
   // var date = DateTime.fromMillisecondsSinceEpoch(300000);
     _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }



  @override
  Widget build(BuildContext context, ) {

    Size size = MediaQuery.of(context).size;

    _stopWatchTimer.onExecute.add(StopWatchExecute.start);



    return Scaffold(
      body: GestureDetector(
        onTap: (){
          setState(() {
            if(sidebarVisible)
              sidebarVisible = false;
            else sidebarVisible = true;
          });
        },
        child: Container(
          width: size.width,
          height: size.height,
          child:  Stack(
                children: [

                  Container(
                    height: size.height,
                    width: sidebarVisible ? size.width - 60 : size.width,
                    child: OrientationBuilder(builder: (context, layout) {
                      if (layout == Orientation.landscape)
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: size.height / 2 - 120),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(child: timeStream("h")),
                              Expanded(child: timeStream("m")),
                              Expanded(child: timeStream("s"))
                            ],
                          ),
                        );
                      else
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          // hour box
                          timeStream("h"),

                          //minute box
                          timeStream("m"),
                          Container(
                            width: 210,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(width: 130,),
                                Flexible(
                                  child: timeStream(
                                    's',
                                    prefFont: 50,
                                    prefHeight: 40,
                                    prefWeight: 65,
                                  ),
                                )
                              ],
                            ),
                          )
                          ],
                        );
                    }),
                  ),

                  Positioned(
                    right: 10,
                    height: size.height,
                    child: Center(
                      child: Visibility(
                        child: SideBar(size: size,),
                        visible: sidebarVisible,
                      ),
                    ),
                  ),

                ],
              ),
          ),
      ),
    );
  }

  final bool _isHour = true;

  // timer package constructor --------------------
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromHour(2),
   // onChange: (value) => print('onChange $value'),
    // onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    // onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    onEnded: () {
      print('onEnded');
    },
  );


  // stream widget -------------------------
  Widget timeStream(String type,{double? prefFont,double? prefHeight, double? prefWeight}) {
    return  // seconds box
      StreamBuilder<int>(
        stream: _stopWatchTimer.rawTime,
        initialData: _stopWatchTimer.rawTime.value,
        builder: (context, snap) {

          final value = snap.data;
          final displayTime =
          StopWatchTimer.getDisplayTime(value!, hours: _isHour);

          String newHr = displayTime.toString();

          //--------------- using time raw milliseconds
          var time = DateTime.fromMillisecondsSinceEpoch(value);


          //--------------- check time type and then format
         late int currentTime;
          if(type == "h"){
            // if hour i will use get charAt to get hour from entire dateTime
            String hour = newHr[0] + newHr[1];
            currentTime = int.parse(hour);
            

          }else if(type == "m"){
            currentTime = int.parse(minutesFormat.format(time));
          }else{
            currentTime = int.parse(secondsFormat.format(time));
          }


          return Padding(
              padding: const EdgeInsets.all(2.0),
              child: ClockFlipWidget(
                currentTime: currentTime,
                prefFont: prefFont,
                prefHeight: prefHeight,
                prefWeight: prefWeight,
              )
          );
        },
      );
  }
}
