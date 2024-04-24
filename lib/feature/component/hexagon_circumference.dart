import 'dart:math';

import 'package:flutter/material.dart';
import 'package:morkam/draw/drawable_widget.dart';
import 'package:plume_demo/feature/component/hexagon.dart';

class HexagonCircumference extends DrawableWidget {
  final Paint _paint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  final Color _color;
  final double _progress;

  HexagonCircumference(this._progress, [this._color = Colors.orange]) {
    _paint.color = _color;
  }

  @override
  void paint(Size size, Orientation orientation, Canvas canvas, BuildContext context) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);

    drawHexagonCircumference(size, canvas, _paint, _progress, false);

    canvas.restore();
  }

  @override
  List<Object> repaintTriggers(BuildContext context) => [_progress, _color];
}

void drawHexagonCircumference(Size size, Canvas canvas, Paint paint, double progress, bool zeroRadiusStart) {
  Path path = Path();

  paint.strokeWidth = size.width * 0.05;

  const center = Offset.zero;
  final side = size.width * 0.45;
  final cornerRadius = side * 0.3;

  path.reset();

  canvas.save();
  canvas.translate(center.dx, center.dy);

  final List<Vertex> vertices = [];

  for (int i = 1; i <= 6; i++) {
    double radius = zeroRadiusStart && i == 1 ? 0 : cornerRadius;
    vertices.add(Vertex(angle: (-60 * i).rad(), side: side, cornerRadius: radius));
  }

  final double sidesProgress = progress * 6;
  final int sidesCount = sidesProgress.toInt();
  for (int i = 0; i < sidesCount; i++) {
    final vertex = vertices[i];
    final nextVertex = vertices[(i + 1) % 6];

    path.arcTo(vertex.cornerRect, vertex.arcStart, vertex.arcSweep, false);
    path.lineTo(nextVertex.arcRightPoint.dx, nextVertex.arcRightPoint.dy);
  }

  if (sidesCount < 6) {
    final int sideIndex = sidesProgress ~/ 1;
    final double sideProgress = sidesProgress % 1;

    final vertex = vertices[sideIndex];
    final nextVertex = vertices[(sideIndex + 1) % 6];

    final arcProgress = max(0.0, min(0.3, sideProgress - 0.0)) / 0.3;
    final lineProgress = max(0.0, min(0.7, sideProgress - 0.3)) / 0.7;

    path.arcTo(vertex.cornerRect, vertex.arcStart, vertex.arcSweep * arcProgress, false);

    Offset diff = (nextVertex.arcRightPoint - vertex.arcLeftPoint) * lineProgress;

    path.relativeLineTo(diff.dx, diff.dy);
  }

  canvas.drawPath(path, paint);

  canvas.restore();
}

class Vertex {
  final double angle;
  final double cornerRadius;
  final Offset offset;
  final double _cornerSideLength;
  final double _cornerCircleDistanceFromVertex;

  Vertex({
    required this.angle,
    required double side,
    required this.cornerRadius,
  })  : offset = Offset(side * cos(angle), side * sin(angle)),
        _cornerSideLength = cornerRadius * tan(30.rad()),
        _cornerCircleDistanceFromVertex = cornerRadius / cos(30.rad());

  Offset get arcRightPoint => offset + Offset(_cornerSideLength * cos(angle + 120.rad()), _cornerSideLength * sin(angle + 120.rad()));
  Offset get arcLeftPoint => offset + Offset(_cornerSideLength * cos(angle - 120.rad()), _cornerSideLength * sin(angle - 120.rad()));
  Offset get cornerCenter => offset - Offset(_cornerCircleDistanceFromVertex * cos(angle), _cornerCircleDistanceFromVertex * sin(angle));
  Rect get cornerRect => Rect.fromCenter(center: cornerCenter, width: cornerRadius * 2, height: cornerRadius * 2);
  double get arcStart => angle + 30.rad();
  double get arcSweep => -60.rad();
}
