import 'dart:async';

import 'package:flip_clock/widgets/timerTextWidget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ClockFlipWidget extends StatefulWidget {
  final int? currentTime;


  ClockFlipWidget({
    Key? key,
     this.currentTime,

  }) : super(key: key);

  @override
  _ClockFlipWidgetState createState() => _ClockFlipWidgetState();
}



class _ClockFlipWidgetState extends State<ClockFlipWidget>
    with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation _animation;

  late  Timer _timer;
  late int? _clockCount;

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
    _onTimeChange();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _animation = Tween<double>(end: math.pi, begin: math.pi * 2).animate(_controller);
    _animation.addListener(() {
      setState(() {});
    });
    //_startTimer();
    super.initState();
  }



  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                        child: TimerTextWidget(clockCount: widget.currentTime,
                        ))
                  ],
                ),
              ),

              Divider(height: 3,color: Colors.transparent,),

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
                              child: TimerTextWidget(clockCount: widget.currentTime)
                          )
                        ],
                      )
                  ),
                  AnimatedBuilder(
                    animation: _animation,
                    child: Container(
                        height: 99,
                        width: 200,
                        decoration: _decoration(false),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            _animation.value > 4.71 ?
                            Positioned(
                                bottom: 40,
                                child: TimerTextWidget(clockCount: widget.currentTime)
                            ):
                            Positioned(
                                top: 59,
                                child: Transform(
                                    transform: Matrix4.rotationX(math.pi),
                                    child: TimerTextWidget(clockCount: widget.currentTime)
                                )
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
              ),
            ],
          ),
          Padding(
            padding:  EdgeInsets.only(top: 100),
            child: Container(
              color: Colors.transparent,
              height: 2.0,
              width: 200,
            ),
          )
        ],
      ),
    );
  }


  _onTimeChange(){
    setState(() {
      _clockCount = widget.currentTime;
    });
  }

  // _startTimer(){
  //   Duration _flipDuration = widget.timerDuration ;
  //   _timer = Timer.periodic(_flipDuration, (timer) {
  //     if(_clockCount != widget.limit){
  //       _controller.reset();
  //       setState(() {
  //         _clockCount ++;
  //       });
  //       _controller.forward();
  //     }else {
  //       setState(() {
  //         _clockCount = widget.start;
  //       });
  //     }
  //   });
  // }
}
