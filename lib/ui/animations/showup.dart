import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sprung/sprung.dart';

class ShowUp extends StatefulWidget {
  final Widget child;
  final int delay;
  final Duration duration;

  ShowUp({@required this.child, this.delay, this.duration});

  @override
  _ShowUpState createState() => _ShowUpState();
}

class _ShowUpState extends State<ShowUp> with TickerProviderStateMixin {
  AnimationController _animController;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    if (widget.duration == null) {
      _animController = AnimationController(
          vsync: this, duration: Duration(milliseconds: 500));
    } else {
      _animController =
          AnimationController(vsync: this, duration: widget.duration);
    }

    final curve = CurvedAnimation(
        curve: Sprung(damped: Damped.under), parent: _animController);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
            .animate(curve);

    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }
}
