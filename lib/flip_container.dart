import 'package:flutter/material.dart';
import 'dart:math' as math;

class ClockAnimation extends StatefulWidget {
  ClockAnimation({Key key}) : super(key: key);

  @override
  _ClockAnimationState createState() => _ClockAnimationState();
}

class _ClockAnimationState extends State<ClockAnimation>
    with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _animation = Tween<double>(end: math.pi, begin: math.pi * 2).animate(_controller);
    _animation.addListener(() {
      setState(() {
        //
      });
    });
    _controller.forward();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // top fraction of stack container
                Container(
                  height: 99,
                  width: 200,
                  color: Colors.yellow,
                  child: Text('12'),
                ),

                SizedBox(height: 2),

                // bottom fraction of stack container
                Stack(
                  children: [
                    Container(
                      height: 99,
                      width: 200,
                      color: Colors.purple,
                      child: AnimatedBuilder(
                        animation: _animation,
                        child: Container(
                          color: Colors.green,
                          height: 100,
                          width: 200,
                          child: Text('13'),
                        ),
                        builder: (context, child){
                          return Transform(
                            alignment: Alignment.topCenter,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.003)
                              ..rotateX(_animation.value),
                            child: child,
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      );
  }
}
