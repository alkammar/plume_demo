import 'dart:math';

import 'package:flutter/material.dart';
import 'package:morkam/draw/drawable_widget.dart';

class Hexagon extends DrawableWidget {
  final Paint _paint = Paint()..color = Colors.white;

  final Color _color;

  Hexagon([this._color = Colors.white]) {
    _paint.color = _color;
  }

  @override
  void paint(Size size, Orientation orientation, Canvas canvas, BuildContext context) {
    final center = Offset(size.width / 2, size.height / 2);

    canvas.drawPath(
      hexagonPath(
        side: size.width * 0.5,
        cornerRadius: size.width * 0.1,
      ).shift(center),
      _paint,
    );
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
