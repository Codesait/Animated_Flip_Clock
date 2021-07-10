import 'package:flip_clock/widgets/timerTextWidget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ClockFlipWidget extends StatefulWidget {
  final int currentTime;
  final double? prefHeight;
  final double? prefWeight;
  final double? prefFont;

  ClockFlipWidget(
      {Key? key,
      required this.currentTime,
      this.prefHeight,
      this.prefWeight,
      this.prefFont})
      : super(key: key);

  @override
  _ClockFlipWidgetState createState() => _ClockFlipWidgetState();
}

class _ClockFlipWidgetState extends State<ClockFlipWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  late int _clockCount;

  BoxDecoration _decoration(bool topRadius) {
    return BoxDecoration(
        color: Color.fromRGBO(20, 20, 20, 1),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topRadius ? 10 : 0),
            topRight: Radius.circular(topRadius ? 10 : 0),
            bottomLeft: Radius.circular(topRadius ? 0 : 10),
            bottomRight: Radius.circular(topRadius ? 0 : 10)));
  }

  @override
  void initState() {
    _clockCount = widget.currentTime;
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _animation =
        Tween<double>(end: math.pi, begin: math.pi * 2).animate(_controller);
    _animation.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _onTimeChange();
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // top fraction of stack container
              Container(
                height: widget.prefHeight == null ? 99 : widget.prefHeight,
                width: widget.prefWeight == null ? 200 : widget.prefWeight,
                decoration: _decoration(true),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        top: 10,
                        child: TimerTextWidget(
                          clockCount: widget.currentTime,
                          prefFont: widget.prefFont,
                        ))
                  ],
                ),
              ),

              Divider(
                height: 4.0,
                color: Colors.transparent,
              ),

              // bottom fraction of stack container
              Stack(
                children: [
                  Container(
                      height:
                          widget.prefHeight == null ? 99 : widget.prefHeight,
                      width:
                          widget.prefWeight == null ? 200 : widget.prefWeight,
                      decoration: _decoration(false),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                              bottom: 10,
                              child: TimerTextWidget(
                                clockCount: widget.currentTime,
                                prefFont: widget.prefFont,
                              ))
                        ],
                      )),
                  AnimatedBuilder(
                    animation: _animation,
                    child: Container(
                        height:
                            widget.prefHeight == null ? 99 : widget.prefHeight,
                        width:
                            widget.prefWeight == null ? 200 : widget.prefWeight,
                        decoration: _decoration(false),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            _animation.value > 4.71
                                ? Positioned(
                                    bottom:widget.prefHeight != null? 8:10,
                                    child: TimerTextWidget(
                                      clockCount: widget.currentTime,
                                      prefFont: widget.prefFont,

                                    ))
                                : Positioned(
                                    top: widget.prefHeight != null ? 40: 99,
                                    child: Transform(
                                        transform: Matrix4.rotationX(math.pi),
                                        child: TimerTextWidget(
                                          clockCount: widget.currentTime,
                                          prefFont: widget.prefFont,
                                        )))
                          ],
                        )),
                    builder: (context, child) {
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
            padding: EdgeInsets.only(top: 99),
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

  _onTimeChange() {
    if (widget.currentTime != _clockCount) {
      setState(() {
        _clockCount = widget.currentTime;
      });
      _controller.reset();
      _controller.forward();
    }
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
