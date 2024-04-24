import 'dart:math';

import 'package:flutter/material.dart';
import 'package:morkam/draw/drawable_widget.dart';

class ProgressHexagon extends DrawableWidget {
  final Paint _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..color = Colors.white;

  final Paint _paint2 = Paint()
    ..style = PaintingStyle.fill
    ..strokeWidth = 10
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..color = Colors.white;

  final Color _color;

  ProgressHexagon([this._color = Colors.white]) {
    _paint.color = _color;
    _paint2.color = _color;
  }

  @override
  void paint(Size size, Orientation orientation, Canvas canvas, BuildContext context) {
    final center = Offset(size.width / 2, size.height / 2);

    canvas.drawPath(
      hexagonPath(
        side: size.width * 0.45,
        cornerRadius: size.width * 0.1,
      ).shift(center),
      _paint..color = _color..strokeWidth = 10,
    );

    canvas.drawLine(
      Offset(size.width * 0.45 * cos(-60.rad()), size.width * 0.45 * sin(-60.rad())) + center,
      Offset(size.width * 0.45 * cos(0.rad()), size.width * 0.45 * sin(0.rad())) + center,
      _paint..color = Colors.white..strokeWidth = 12,
    );

    canvas.drawLine(
      Offset(size.width * 0.45 * cos(0.rad()), size.width * 0.45 * sin(0.rad())) + center,
      Offset(size.width * 0.45 * cos(60.rad()), size.width * 0.45 * sin(60.rad())) + center,
      _paint..color = Colors.white,
    );

    canvas.drawLine(
      Offset(size.width * 0.45 * cos(60.rad()), size.width * 0.45 * sin(60.rad())) + center,
      Offset(size.width * 0.45 * cos(90.rad()), size.width * 0.45 * sin(60.rad())) + center,
      _paint..color = Colors.white,
    );

    canvas.drawCircle(Offset(size.width * 0.45 * cos(-63.rad()), size.width * 0.45 * sin(-59.5.rad())) + center, 5, _paint2);
    canvas.drawCircle(Offset(size.width * 0.45 * cos(92.rad()), size.width * 0.45 * sin(60.rad())) + center, 5, _paint2);
  }

  @override
  List<Object> repaintTriggers(BuildContext context) {
    return [_color, _paint.color, _paint, _paint.style];
  }
}

Path hexagonPath({required double side, required double cornerRadius}) {
  Path path = Path();

  var angle = -60.rad();
  final cornerCircleDistanceFromVertex = cornerRadius / cos(30.rad());

  for (int v = 1; v <= 6; v++) {
    final vertex = Offset(side * cos(angle), side * sin(angle));

    final cornerCircleCenter = vertex -
        Offset(
          cornerCircleDistanceFromVertex * cos(angle),
          cornerCircleDistanceFromVertex * sin(angle),
        );

    path.arcTo(
      Rect.fromCenter(center: cornerCircleCenter, width: cornerRadius * 2, height: cornerRadius * 2),
      angle - 30.rad(),
      60.rad(),
      false,
    );

    angle += 60.rad();
  }

  path.close();

  return path;
}

extension Radians on num {
  double rad() => this * pi / 180;
}
