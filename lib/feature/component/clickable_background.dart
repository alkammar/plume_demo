import 'package:flutter/material.dart';
import 'package:morkam/draw/component.dart';
import 'package:plume_demo/feature/component/pulse_hexagon.dart';
import 'package:plume_demo/feature/home/home_screen.dart';

enum Components {
  hexagon,
}

class ClickableBackground extends Component {
  final Offset _position;
  final double _value;

  ClickableBackground(this._position, this._value);

  @override
  List<Widget> addComponents(BuildContext context, Orientation orientation) => [
    LayoutId(
      id: Components.hexagon,
      child: PulseHexagon(_position, _value),
    ),
  ];

  @override
  void performLayout(Size size, Orientation orientation, MultiChildLayoutDelegate layoutDelegate) {
    _layoutHexagon(layoutDelegate, size);
  }

  _layoutHexagon(MultiChildLayoutDelegate layoutDelegate, Size size) {
    layoutDelegate.layoutChild(
      Components.hexagon,
      BoxConstraints(
        maxWidth: size.width,
        maxHeight: size.height,
      ),
    );

    layoutDelegate.positionChild(
      Components.hexagon,
      Offset.zero,
    );
  }
}
