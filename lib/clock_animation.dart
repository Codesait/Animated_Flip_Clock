import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class ClockAnimation extends StatefulWidget {
  final int onTime;
  final Duration timerDuration;
  final int limit;
  final int start;

  ClockAnimation({
    Key key,
    this.onTime,
    this.timerDuration,
    this.start,
    this.limit
  }) : super(key: key);

  @override
  _ClockAnimationState createState() => _ClockAnimationState();
}



class _ClockAnimationState extends State<ClockAnimation>
    with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation _animation;

  Timer _timer;
  int _clockCount;

  @override
  void initState() {
    _clockCount = widget.onTime;
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _animation = Tween<double>(end: math.pi, begin: math.pi * 2).animate(_controller);
    _animation.addListener(() {
      setState(() {});
    });
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(

        child: Stack(
          children: [
            Column(
              children: [

                // top fraction of stack container
                Container(
                  height: 99,
                  width: 200,
                  color: Colors.yellow,
                  child: Text(_clockCount.toString()),
                ),

                Divider(height: 2,color: Colors.transparent,),

                // bottom fraction of stack container
                Stack(
                  children: [
                    Container(
                      height: 99,
                      width: 200,
                      color: Colors.purple,
                      child: Text(_clockCount.toString())
                    ),
                    AnimatedBuilder(
                      animation: _animation,
                      child: Container(
                        color: Colors.green,
                        height: 100,
                        width: 200,
                        child: Text(_clockCount.toString()),
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
                  ],
                )
              ],
            )
          ],
        ),
      );
  }



  _startTimer(){
    Duration _flipDuration = widget.timerDuration;
    _timer = Timer.periodic(_flipDuration, (timer) {
     if(_clockCount != widget.limit){
       _controller.reset();
       setState(() {
         _clockCount++;
       });
       _controller.forward();
     }else {
       setState(() {
         _clockCount = widget.start;
       });
     }
    });
  }
}
