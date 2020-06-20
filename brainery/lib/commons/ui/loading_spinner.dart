import "package:flutter/material.dart";
import 'dart:math';

class LoadingSpinner extends StatefulWidget {
  final double radius;
  final double dotRadius;

  LoadingSpinner({this.radius = 30.0, this.dotRadius = 3.0});

  @override
  _LoadingSpinnerState createState() => _LoadingSpinnerState();
}

class _LoadingSpinnerState extends State<LoadingSpinner>
    with SingleTickerProviderStateMixin {
  Animation<double> _animationRotation;
  Animation<double> _animationRadiusIn;
  Animation<double> _animationRadiusOut;
  AnimationController controller;

  double radius;
  double dotRadius;

  @override
  void initState() {
    super.initState();

    radius = widget.radius;
    dotRadius = widget.dotRadius;

    controller = AnimationController(
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(milliseconds: 3000),
        vsync: this);

    _animationRotation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    _animationRadiusIn = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.75, 1.0, curve: Curves.elasticIn),
      ),
    );

    _animationRadiusOut = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.25, curve: Curves.elasticOut),
      ),
    );

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1.0)
          radius = widget.radius * _animationRadiusIn.value;
        else if (controller.value >= 0.0 && controller.value <= 0.25)
          radius = widget.radius * _animationRadiusOut.value;
      });
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> dots =
        [0, 1, 2, 3, 4, 5, 6, 7].map((e) => createDot(e)).toList();

    return Container(
      width: 100.0,
      height: 100.0,
      //color: Colors.black12,
      child: new Center(
        child: new RotationTransition(
          turns: _animationRotation,
          child: new Container(
            //color: Colors.limeAccent,
            child: new Center(
              child: Stack(children: dots),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget createDot(int e) {
    Color color =
        (e % 2 == 0) ? Theme.of(context).primaryColor : Colors.lightBlue;
    return Transform.translate(
      child: Dot(
        radius: dotRadius,
        color: color,
      ),
      offset: Offset(
        radius * cos(0.0 + e * pi / 4),
        radius * sin(0.0 + e * pi / 4),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  Dot({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
