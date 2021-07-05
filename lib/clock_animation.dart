import 'dart:async';

import 'package:flip_clock/widgets/timerTextWidget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ClockAnimation extends StatefulWidget {
  final int onTime;
  final Duration timerDuration;
  final int limit;
  final int start;

  ClockAnimation({
    Key? key,
    required this.onTime,
    required this.timerDuration,
    required this.start,
    required this.limit
  }) : super(key: key);

  @override
  _ClockAnimationState createState() => _ClockAnimationState();
}



class _ClockAnimationState extends State<ClockAnimation>
    with SingleTickerProviderStateMixin{

 late AnimationController _controller;
 late Animation _animation;

  Timer? _timer;
  late int _clockCount;

  BoxDecoration _decoration(bool topRadius){
    return BoxDecoration(
      color: Color.fromRGBO(20,20,20,1),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topRadius ? 10:0),
        topRight: Radius.circular(topRadius ? 10:0),
        bottomLeft: Radius.circular(topRadius ? 0:10),
        bottomRight: Radius.circular(topRadius ? 0:10)
      )
    );
  }

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
    //_animation.isDismissed;
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
                  decoration: _decoration(true),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 45,
                          child: TimerTextWidget(clockCount: _clockCount,
                          ))
                    ],
                  ),
                ),

                Divider(height: 2,color: Colors.transparent,),

                // bottom fraction of stack container
                Stack(
                  children: [
                    Container(
                        height: 99,
                        width: 200,
                        decoration: _decoration(false),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                                bottom: 40,
                                child: TimerTextWidget(clockCount: _clockCount)
                            )
                          ],
                        )
                    ),
                    AnimatedBuilder(
                      animation: _animation,
                      child: Container(
                        height: 100,
                        width: 200,
                        decoration: _decoration(false),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              bottom: 40,
                                child: TimerTextWidget(clockCount: _clockCount)
                            )
                          ],
                        )
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
