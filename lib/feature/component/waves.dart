import 'dart:math';

import 'package:flutter/material.dart';
import 'package:morkam/draw/drawable_widget.dart';
import 'package:plume_demo/feature/component/hexagon.dart';

class Waves extends DrawableWidget {

  final Paint _pulseGlowPaint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.fill
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 3
    ..shader = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.blue, Colors.purple],
    ).createShader(const Rect.fromLTWH(0, 0, 20, 150));

  final double _phaseShift;
  final double _level;

  Waves(this._phaseShift, this._level);

  @override
  void paint(Size size, Orientation orientation, Canvas canvas, BuildContext context) {
    final margin = size.width * 0.04;
    final side = size.width / 2 - margin;

    final double level = 1 - _level;
    const double amplitude = 0.02;
    const double frequency = 50;
    final double phaseShift = 2 * pi * _phaseShift;

    Path wavePath = Path();
    wavePath.moveTo(0, level * size.height);
    double x = 0;
    while (x <= size.width) {
      wavePath.lineTo(
          x += size.width / 80, (level + amplitude * sin(phaseShift + 2 * pi * x / frequency)) * size.height);
    }
    wavePath.lineTo(size.width, size.height);
    wavePath.lineTo(0, size.height);
    wavePath.close();

    canvas.save();

    canvas.clipPath(hexagonPath(
      side: side,
      cornerRadius: size.width * 0.1,
    ).shift(Offset(side + margin, side + margin)));

    canvas.drawPath(wavePath, _pulseGlowPaint);

    canvas.restore();
  }

  @override
  List<Object> repaintTriggers(BuildContext context) => [_phaseShift];
}
