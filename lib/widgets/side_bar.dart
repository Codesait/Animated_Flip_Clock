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
          color: Colors.purple,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            SizedBox(height: 20,)
          ],
        ),
    );
  }
}
