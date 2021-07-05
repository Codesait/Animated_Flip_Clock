import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static DateTime currentDateTime = DateTime.now();

  // stream
  Stream _timer = Stream.periodic(Duration(seconds: 1),(i){
    currentDateTime = currentDateTime.add(Duration(seconds: 1));
  });


  listToTime(){
    _timer.listen((event) {
      print(event);
      currentDateTime = DateTime.parse(event.toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: OrientationBuilder(
          builder: (context,layout){
            if(layout == Orientation.landscape)
              return Row();
            else return Column();
          }
        ),
      ),
    );
  }
}
