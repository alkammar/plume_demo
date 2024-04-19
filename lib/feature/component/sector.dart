import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:morkam/draw/drawable_widget.dart';
import 'package:plume_demo/feature/component/hexagon.dart';

class Sector extends DrawableWidget {
  final Paint _paint = Paint()..color = Colors.white
  ..strokeWidth = 3;

  final int _number;
  final ui.Image _image;

  Sector(this._number, this._image);

  @override
  Future<void> paint(Size size, Orientation orientation, Canvas canvas, BuildContext context) async {
    final center = Offset(size.width / 2, size.height / 2);

    final margin = size.width * 0.04;
    final side = size.width / 2 - margin;

    canvas.save();

    canvas.clipPath(hexagonPath(
      side: side,
      cornerRadius: size.width * 0.1,
    ).shift(Offset(side + margin, side + margin)));

    Path sectorPath = Path();

    var angle = -60.rad() + 60.rad() * _number;
    final vertex1 = Offset(side * cos(angle), side * sin(angle)) + center;
    final vertex2 = Offset(side * cos(angle + 60.rad()), side * sin(angle + 60.rad())) + center;

    sectorPath.moveTo(vertex1.dx, vertex1.dy);
    sectorPath.lineTo(vertex2.dx, vertex2.dy);
    sectorPath.lineTo(center.dx, center.dy);
    sectorPath.close();

    canvas.clipPath(sectorPath);

    const scale = 0.3;

    Offset imageCenter = Offset(_image.width * scale / 2, _image.height * scale / 2);
    Offset sectorCenter = (vertex1 + vertex2 + center) / 3;

    canvas.save();
    canvas.scale(scale, scale);

    canvas.drawImage(_image, (sectorCenter - imageCenter) / scale, _paint);

    canvas.restore();

    canvas.drawLine(vertex1, center, _paint);
    canvas.drawLine(vertex2, center, _paint);

    if (_number == 3)
    canvas.drawCircle(center, size.width / 2, _paint..color = _paint.color.withAlpha(0x77));

    canvas.restore();
  }
}
