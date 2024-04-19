import 'dart:math';

import 'package:flutter/material.dart';
import 'package:morkam/draw/drawable_widget.dart';

class PulseHexagon extends DrawableWidget {

  final Paint _pulseGlowPaint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.fill
    ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20)
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 3;

  final Offset _position;
  final double _value;

  PulseHexagon(this._position, this._value);

  @override
  void paint(Size size, Orientation orientation, Canvas canvas, BuildContext context) {
    final side = size.width / 2;

    path.moveTo(side * sin(1 * pi / 6), side * cos(1 * pi / 6));
    path.lineTo(side * sin(3 * pi / 6), side * cos(3 * pi / 6));
    path.lineTo(side * sin(5 * pi / 6), side * cos(5 * pi / 6));
    path.lineTo(side * sin(7 * pi / 6), side * cos(7 * pi / 6));
    path.lineTo(side * sin(9 * pi / 6), side * cos(9 * pi / 6));
    path.lineTo(side * sin(11 * pi / 6), side * cos(11 * pi / 6));
    path.close();

    // canvas.drawCircle(Offset(size.width / 2, size.height / 2 - 70), size.width * 0.3 * _value, _pulseGlowPaint);
    // canvas.drawCircle(_position + Offset(size.width / 2, size.height / 2), size.width * 0.3 * _value, _pulseGlowPaint);
    canvas.drawCircle(_position, size.width * 0.3 * _value, _pulseGlowPaint);
  }

  @override
  List<Object> repaintTriggers(BuildContext context) {
    return [_value];
  }
}
