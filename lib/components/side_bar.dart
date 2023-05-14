import 'package:flip_clock/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    required this.size,
    required this.stopWatchTimer,
    Key? key,
    }) : super(key: key);

 final Size size;
 final StopWatchTimer stopWatchTimer;

  @override
  SideBarState createState() => SideBarState();
}

class SideBarState extends State<SideBar> {
  bool _isTimerRunning = false;

  @override
  Widget build(BuildContext context) {
    final appThemeStateProvider  = Provider.of<AppThemeNotifier>(context);


    return  Container(
        width: 50,
        height: 180,
        decoration: BoxDecoration(
         // color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            button(
              iconData: appThemeStateProvider.darkTheme ?  Icons.wb_sunny :Icons.nights_stay_outlined,
              iconColor:  appThemeStateProvider.darkTheme ? Colors.white : Colors.black54,
              clickEvent: () {
                appThemeStateProvider.darkTheme == false
                ? appThemeStateProvider.darkTheme = true
                : appThemeStateProvider.darkTheme = false;
              },
            ),
            button(
                iconData:  Icons.screen_rotation,
                iconColor:  appThemeStateProvider.darkTheme ? Colors.white : Colors.black54,
                clickEvent: (){
                  switchOrientation(context);
                },
            ),
            button(
                iconData: _isTimerRunning ? Icons.pause : Icons.play_arrow_outlined,
                iconColor:  appThemeStateProvider.darkTheme ? Colors.white : Colors.black54,
                clickEvent: (){
                  if(!_isTimerRunning){
                    widget.stopWatchTimer.onExecute
                        .add(StopWatchExecute.start);
                    setState(() {
                      _isTimerRunning = true;
                    });

                  }else {
                    widget.stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                    setState(() {
                      _isTimerRunning = false;
                    });
                  }
                },
            )
          ],
        ),
    );
  }

  Widget button({required IconData iconData,required VoidCallback clickEvent, Color? iconColor}){
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(2),
      ),
      child: IconButton(
        splashRadius: 22,
          icon: Icon(
            iconData,
            color: iconColor,
          ),
          onPressed: clickEvent,
      ),
    );
  }

  void switchOrientation(BuildContext context){
    SystemChrome.setPreferredOrientations([
      if (MediaQuery.of(context).orientation == Orientation.landscape) DeviceOrientation.portraitUp else DeviceOrientation.landscapeLeft,
    ]);
    setState((){});
  }
}
