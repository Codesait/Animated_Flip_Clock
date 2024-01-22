import 'dart:math' as math;

import 'package:flip_clock/components/timer_text_widget.dart';
import 'package:flutter/material.dart';

class ClockFlipWidget extends StatefulWidget {
  const ClockFlipWidget({
    required this.currentTime,
    this.prefHeight = 100,
    this.prefWeight = 200,
    this.prefFont,
    super.key,
  });

  final int currentTime;
  final double prefHeight;
  final double prefWeight;
  final double? prefFont;

  @override
  ClockFlipWidgetState createState() => ClockFlipWidgetState();
}

class ClockFlipWidgetState extends State<ClockFlipWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<dynamic> _animation;
  late int _clockCount;

  BoxDecoration _decoration(bool topRadius) {
    return BoxDecoration(
      color: const Color.fromRGBO(20, 20, 20, 1),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topRadius ? 10 : 0),
        topRight: Radius.circular(topRadius ? 10 : 0),
        bottomLeft: Radius.circular(topRadius ? 0 : 10),
        bottomRight: Radius.circular(topRadius ? 0 : 10),
      ),
    );
  }

  @override
  void initState() {
    _clockCount = widget.currentTime;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation =
        Tween<double>(end: math.pi, begin: math.pi * 2).animate(_controller);
    _animation.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _onTimeChange();

    return Container(
      height: widget.prefHeight / 2,
      width: widget.prefWeight,
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // top fraction of stack container
          Expanded(
            child: Container(
              height: widget.prefHeight,
              width: widget.prefWeight,
              decoration: _decoration(true),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 5,
                    child: TimerTextWidget(
                      clockCount: widget.currentTime,
                      prefFont: widget.prefFont,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Divider(
            height: 4,
            color: Colors.transparent,
          ),

          // bottom fraction of stack container
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: widget.prefHeight,
                  width: widget.prefWeight,
                  decoration: _decoration(false),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        bottom: 10,
                        child: TimerTextWidget(
                          clockCount: widget.currentTime,
                          prefFont: widget.prefFont,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedBuilder(
                  animation: _animation,
                  child: Container(
                    height: widget.prefHeight,
                    width: widget.prefWeight,
                    decoration: _decoration(false),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Visibility(
                          visible: (_animation.value as double) < 4.71,
                          child: const Align(
                            alignment: Alignment.topCenter,
                            child: Divider(
                              height: 6,
                              thickness: 3,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if ((_animation.value as double) > 4.71)
                          Positioned(
                            bottom: 5,
                            child: TimerTextWidget(
                              clockCount: widget.currentTime,
                              prefFont: widget.prefFont,
                            ),
                          )
                        else
                          Positioned(
                            top: widget.prefHeight != null ? 40 : 106,
                            child: Transform(
                              transform: Matrix4.rotationX(math.pi),
                              child: TimerTextWidget(
                                clockCount: widget.currentTime,
                                prefFont: widget.prefFont,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.003)
                        ..rotateX(double.parse(_animation.value.toString())),
                      child: child,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onTimeChange() {
    if (widget.currentTime != _clockCount) {
      setState(() {
        _clockCount = widget.currentTime;
      });
      _controller
        ..reset()
        ..forward();
    }
  }
}
