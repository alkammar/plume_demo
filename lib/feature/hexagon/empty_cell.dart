import 'package:flutter/material.dart';
import 'package:morkam/draw/component.dart';
import 'package:plume_demo/feature/hexagon/hexagon.dart';

enum Components {
  hexagon,
}

class Empty extends Component {

  @override
  List<Widget> addComponents(BuildContext context, Orientation orientation) => [
    LayoutId(
      id: Components.hexagon,
      child: Hexagon(),
    ),
  ];

  @override
  void performLayout(Size size, Orientation orientation, MultiChildLayoutDelegate layoutDelegate) {
    _layoutCable(layoutDelegate, size);
  }

  _layoutCable(MultiChildLayoutDelegate layoutDelegate, Size size) {
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
