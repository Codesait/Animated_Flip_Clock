import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key,required this.size}) : super(key: key);

 final Size size;

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
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
            buttons(
              iconData: Icons.nights_stay_outlined,
              clickEvent: (){}
            ),
            buttons(
                iconData: Icons.screen_rotation,
                clickEvent: (){}
            ),
            buttons(
                iconData: Icons.font_download_outlined,
                clickEvent: (){}
            )
          ],
        ),
    );
  }

  Widget buttons({required IconData iconData,required VoidCallback clickEvent}){
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
            color: Colors.white,
          ),
          onPressed: clickEvent
      ),
    );
  }
}
