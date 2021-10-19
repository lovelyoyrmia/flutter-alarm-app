import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  final double? size;
  const ClockView({Key? key, this.size}) : super(key: key);

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  Timer? timer;
  @override
  void initState() {
    this.timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    this.timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(context),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();
  final BuildContext context;

  ClockPainter(this.context);

  //60 sec - 360, 1 sec - 6 degree
  @override
  void paint(Canvas canvas, Size size) {
    // Declare variable of center and radius
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);
    // Declare variable of circle brush
    var fillBrush = Paint()..color = Color(0xff628de0).withOpacity(0.3);
    var outlineBrush = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 20;

    var centerFillBrush = Paint()..color = Colors.white;

    // Declare variable of line clock design

    // Seconds variable
    var secHandBrush = Paint()
      ..shader = RadialGradient(
        colors: [Colors.lightBlueAccent, Color(0xff334756)],
      ).createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 60;

    // Minutes variable
    var minHandBrush = Paint()
      ..shader = RadialGradient(
        colors: [Colors.blue, Color(0xffdff9fb)],
      ).createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 40;

    // Hour variable
    var hourHandBrush = Paint()
      ..shader = RadialGradient(
        colors: [Colors.blue, Color(0xffdff9fb)],
      ).createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 25;
    // Declare variable of outliner and inliner
    var dashBrush = Paint()
      ..color = Theme.of(context).colorScheme.primaryVariant
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    // it's gonna fill the color for the circle
    canvas.drawCircle(center, radius * 0.75, fillBrush);
    canvas.drawCircle(center, radius * 0.75, outlineBrush);

    // Declare variable to draw a line clock (HOUR LINE)
    var hourHandsX = centerX +
        radius *
            0.4 *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandsY = centerX +
        radius *
            0.4 *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandsX, hourHandsY), hourHandBrush);

    // Declare variable to draw a line clock (MINUTE LINE)
    var minHandsX =
        centerX + radius * 0.5 * cos(dateTime.minute * 6 * pi / 180);
    var minHandsY =
        centerX + radius * 0.5 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandsX, minHandsY), minHandBrush);

    // Declare variable to draw a line clock (SECOND LINE)
    var secHandsX =
        centerX + radius * 0.6 * cos(dateTime.second * 6 * pi / 180);
    var secHandsY =
        centerX + radius * 0.6 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandsX, secHandsY), secHandBrush);
    canvas.drawCircle(center, radius * 0.12, centerFillBrush);

    // Declare variable to make outLiner and inLiner clock
    var outerCircleRadius = radius - 10;
    var innerCircleRadius = radius - 20;

    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerY + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerY + innerCircleRadius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
