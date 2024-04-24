import 'dart:math';

import 'package:flutter/material.dart';
import 'package:morkam/draw/drawable_widget.dart';
import 'package:plume_demo/feature/component/hexagon.dart';
import 'package:plume_demo/feature/component/hexagon_circumference.dart';

class LogoSwirl extends DrawableWidget {
  final Paint _paint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  final Color _color;
  final double _progress;
  final double _rotation;

  LogoSwirl([this._color = Colors.orange, this._progress = 0, this._rotation = 0]) {
    _paint.color = _color;
  }

  @override
  void paint(Size size, Orientation orientation, Canvas canvas, BuildContext context) {
    _paint.strokeWidth = size.width * 0.023;

    final center = Offset(size.width / 2, size.height / 2);
    final outerSide = size.width * 0.31;
    final innerSide = size.width * 0.23;
    final sideDiff = outerSide - innerSide;
    final innerSideOffset = Offset(sideDiff * cos(60.rad()), -sideDiff * sin(60.rad()));
    final cornerRadius = innerSide * 0.3;


    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(_rotation.rad());

    canvas.save();

    for (int i = 0; i < 6; i++) {
      canvas.save();

      canvas.rotate((-60 * i).rad());
      canvas.translate(innerSideOffset.dx, innerSideOffset.dy);

      Path clipPath = Path();

      // canvas.drawRect(Rect.fromCenter(center: Offset(size.width * -0.07, size.width * -0.04), width: size.width * 0.47, height: size.width * 0.43), _paint..color = _paint.color.withAlpha(0xFF));
      clipPath.addRect(Rect.fromCenter(center: Offset(size.width * -0.07, size.width * -0.04), width: size.width * 0.47, height: size.width * 0.43));

      canvas.clipPath(clipPath);

      drawHexagonCircumference(size * 0.6, canvas, _paint..color = _paint.color.withAlpha(0xFF), 0.50 * _progress, true);

      canvas.restore();
    }

    canvas.restore();
    canvas.restore();
  }

  @override
  List<Object> repaintTriggers(BuildContext context) {
    return [_progress ,_color];
  }
}
