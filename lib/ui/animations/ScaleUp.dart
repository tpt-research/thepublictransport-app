import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sprung/sprung.dart';

class ScaleUp extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final int delay;
  final bool repeat;

  ScaleUp({@required this.child, @required this.duration, this.delay, this.repeat});

  _ArrowScaledState createState() => _ArrowScaledState();
}

class _ArrowScaledState extends State<ScaleUp> with TickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _animation;

  initState() {
    super.initState();
    _controller = AnimationController(
        duration: widget.duration, vsync: this, value: 0.0);
    _animation = CurvedAnimation(parent: _controller, curve: Sprung(damped: Damped.under));

    if (widget.delay == null) {
      _controller.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _controller.forward();
      });
    }
    if (widget.repeat == true) {
      Timer(Duration(seconds: 3), () {
        _controller.repeat();
      });
    }
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
        child: ScaleTransition(
          scale: _animation,
          alignment: Alignment.center,
          child: widget.child
        )
    );
  }
}