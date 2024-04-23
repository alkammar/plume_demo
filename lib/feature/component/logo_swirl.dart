import 'dart:math';

import 'package:flutter/material.dart';
import 'package:morkam/draw/drawable_widget.dart';
import 'package:plume_demo/feature/component/hexagon.dart';

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

    canvas.save();

    canvas.rotate(_rotation.rad());

    for (int i = 0; i < 6; i++) {

      canvas.save();

      canvas.rotate((-60 * i).rad());

      _drawLine(outerSide, innerSide, cornerRadius, innerSideOffset, canvas, size, _progress);

      canvas.restore();
    }

    canvas.restore();

    canvas.restore();
  }

  void _drawLine(double outerSide, double innerSide, double cornerRadius, Offset innerSideOffset, Canvas canvas, Size size, double progress) {

    Offset p1 = Offset(innerSide * cos(-60.rad()), innerSide * sin(-60.rad())) + innerSideOffset;
    Offset p2 = Offset(innerSide * cos(-120.rad()), innerSide * sin(-120.rad())) + innerSideOffset;
    Offset p3 = Offset(innerSide * cos(-180.rad()), innerSide * sin(-180.rad())) + innerSideOffset;
    Offset p4 = Offset(innerSide * cos(-240.rad()), innerSide * sin(-240.rad())) + innerSideOffset;

    Path path = Path();
    
    final cornerCircleDistanceFromVertex = cornerRadius / cos(30.rad());

    path.moveTo(p1.dx, p1.dy);

    //----------------------------------------------------------------------------------------

    var prg = (min(0.33, progress) - 0.0) / 0.33;
    var hexagonAngle = -120;
    var lineAngle = 0;
    _lineSegment(path, p1, p2, cornerRadius, lineAngle, cornerCircleDistanceFromVertex, hexagonAngle, prg);

    //----------------------------------------------------------------------------------------

    if (progress > 0.33) {
      prg = (min(0.67, progress) - 0.33) / 0.33;
      hexagonAngle = -180;
      lineAngle = -60;
      _lineSegment(path, p2 + Offset(cornerCircleDistanceFromVertex * cos(120.rad()), cornerCircleDistanceFromVertex * sin(120.rad())), p3, cornerRadius, lineAngle, cornerCircleDistanceFromVertex, hexagonAngle, prg);
    }

    //----------------------------------------------------------------------------------------

    if (progress > 0.67) {
      hexagonAngle = -240;
      lineAngle = -120;
      _lineSegment(path, p3 + Offset(cornerCircleDistanceFromVertex * cos(60.rad()), cornerCircleDistanceFromVertex * sin(60.rad())), p4, cornerRadius, lineAngle, cornerCircleDistanceFromVertex, hexagonAngle, (max(min(1.0, progress), 0.67) - 0.67) / 0.33);
      path.lineTo(p4.dx + cornerRadius * cos(lineAngle.rad()), p4.dy + cornerRadius * sin(lineAngle.rad()));
    }

    //----------------------------------------------------------------------------------------

    Path clipPath = Path();

    clipPath.addRect(Rect.fromCenter(center: Offset(size.width * -0.02, size.width * -0.11), width: size.width * 0.37, height: size.width * 0.37));

    canvas.clipPath(clipPath);

    canvas.drawPath(path, _paint);
  }

  void _lineSegment(Path path, Offset p1, Offset p2, double cornerRadius, int lineAngle, double cornerCircleDistanceFromVertex, int hexagonAngle, double progress) {
    final diff = p2 - p1;
    final p12 = p1 + diff * min(1.0, progress / 0.7);

    path.lineTo(p12.dx + cornerRadius * cos(lineAngle.rad()), p12.dy + cornerRadius * sin(lineAngle.rad()));

    final cornerCircleCenter = p2 -
        Offset(
          cornerCircleDistanceFromVertex * cos(hexagonAngle.rad()),
          cornerCircleDistanceFromVertex * sin(hexagonAngle.rad()),
        );

    if (progress > 0.7) {
      path.arcTo(
        Rect.fromCenter(center: cornerCircleCenter, width: cornerRadius * 2, height: cornerRadius * 2),
        hexagonAngle.rad() + 30.rad(),
        -60.rad() * (progress - 0.7) / 0.3,
        false,
      );
    }
  }

  @override
  List<Object> repaintTriggers(BuildContext context) {
    return [_progress ,_color];
  }
}
