import 'package:flip_clock/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key,required this.size}) : super(key: key);

 final Size size;

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    final _appThemeStateProvider  = Provider.of<AppThemeNotifier>(context);


    return  Container(
        width: 50,
        height: 180,
        decoration: BoxDecoration(
         // color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            button(
              iconData: _appThemeStateProvider.darkTheme ?  Icons.wb_sunny :Icons.nights_stay_outlined,
              iconColor:  _appThemeStateProvider.darkTheme ? Colors.white : Colors.black54,
              clickEvent: () {
                _appThemeStateProvider.darkTheme == false
                ? _appThemeStateProvider.darkTheme = true
                : _appThemeStateProvider.darkTheme = false;
              }
            ),
            button(
                iconData:  Icons.screen_rotation,
                clickEvent: (){
                  switchOrientation(context);
                }
            ),
            button(
                iconData: Icons.font_download_outlined,
                clickEvent: (){}
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
        borderRadius: BorderRadius.circular(2.0)
      ),
      child: IconButton(
        splashRadius: 22,
          icon: Icon(
            iconData,
            color: iconColor,
          ),
          onPressed: clickEvent
      ),
    );
  }

  void switchOrientation(context){
    SystemChrome.setPreferredOrientations([
      MediaQuery.of(context).orientation == Orientation.landscape
          ? DeviceOrientation.portraitUp
          : DeviceOrientation.landscapeLeft,
    ]);
    setState((){});
  }
}
