import 'package:flip_clock/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class SideBar extends ConsumerStatefulWidget {
  const SideBar({
    required this.size,
    required this.stopWatchTimer,
    super.key,
    });

 final Size size;
 final StopWatchTimer stopWatchTimer;

  @override
  SideBarState createState() => SideBarState();
}

class SideBarState extends ConsumerState<SideBar> {
  bool _isTimerRunning = false;

  @override
  Widget build(BuildContext context) {
    final themeState  = ref.watch(themeProvider.notifier);


    return  Container(
        width: 50,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            button(
              iconData: themeState.isLightTheme() ?  Icons.wb_sunny :Icons.nights_stay_outlined,
              clickEvent: () {
                ref.read(themeProvider.notifier).changeTheme();
              },
            ),
            button(
                iconData:  Icons.screen_rotation,
                clickEvent: (){
                  switchOrientation(context);
                },
            ),
            button(
                iconData: _isTimerRunning ? Icons.pause : Icons.play_arrow_outlined,
                clickEvent: (){
                  if(!_isTimerRunning){
                    widget.stopWatchTimer.onStartTimer();
                    setState(() {
                      _isTimerRunning = true;
                    });

                  }else {
                    widget.stopWatchTimer.onStopTimer();
                    setState(() {
                      _isTimerRunning = false;
                    });
                  }
                },
            ),
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
