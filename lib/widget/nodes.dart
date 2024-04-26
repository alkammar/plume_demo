import 'dart:math';

import 'package:flutter/material.dart';
import 'package:morkam/draw/component.dart';
import 'package:plume_demo/feature/component/hexagon.dart';

enum Components {
  hexagon,
  node,
}

class Nodes extends StatefulComponent {
  @override
  State<StatefulWidget> createState() => _NodesState();
}

class _NodesState extends ComponentState<Nodes> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _animation = Tween(
      begin: 0.0,
      end: _nodeCount.toDouble(),
    ).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: _animationController,
    ));

    Future.delayed(const Duration(seconds: 2)).then((value) => _animationController.forward());
  }

  @override
  List<Widget> addComponents(BuildContext context, Orientation orientation) =>
      [
        LayoutId(
          id: Components.hexagon,
          child: AnimatedBuilder(
            builder: (BuildContext context, Widget? _) => Hexagon(),
            animation: _animation,
          ),
        ),
      ] +
      _nodesComponents(_nodeCount);

  List<LayoutId> _nodesComponents(int count) {
    List<LayoutId> list = [];

    for (int i = 0; i < count; i++) {
      list.add(
        LayoutId(
          id: '${Components.node}_$i',
          child: AnimatedBuilder(
            builder: (BuildContext context, Widget? _) => Hexagon(i == 30 ? Colors.red : Colors.purple),
            animation: _animation,
          ),
        ),
      );
    }

    return list;
  }

  final int _nodeCount = 7;

  @override
  void performLayout(Size size, Orientation orientation, MultiChildLayoutDelegate layoutDelegate) {
    _layoutCable(layoutDelegate, size);
    _layoutNodes(layoutDelegate, size, _nodeCount);
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

  _layoutNodes(MultiChildLayoutDelegate layoutDelegate, Size size, int count) {
    const nodeScale = 0.25;

    for (int i = 0; i < _animation.value.toInt(); i++) {
      Size widgetSize = layoutDelegate.layoutChild(
        '${Components.node}_$i',
        BoxConstraints(
          maxWidth: size.width * nodeScale,
          maxHeight: size.height * nodeScale,
        ),
      );

      Offset offset = Offset.zero;
      if (i >= 1 && i <= 6) {
        offset += Offset(
            widgetSize.width * 1 * cos(30.rad() + 60.rad() * i), widgetSize.height * 1 * sin(30.rad() + 60.rad() * i));
      } else if (i >= 7 && i <= 30 && i % 2 == 0) {
        offset += Offset(
            widgetSize.width * 2 * cos(30.rad() + 30.rad() * i), widgetSize.height * 2 * sin(30.rad() + 30.rad() * i));
      } else if (i >= 7 && i <= 30 && i % 2 == 1) {
        offset += Offset(widgetSize.width * 1.75 * cos(30.rad() + 30.rad() * i),
            widgetSize.height * 1.75 * sin(30.rad() + 30.rad() * i));
      }
      layoutDelegate.positionChild(
        '${Components.node}_$i',
        Offset(
              (size.width - widgetSize.width) / 2,
              (size.height - widgetSize.height) / 2,
            ) +
            offset,
      );
    }

    for (int i = _animation.value.toInt(); i < _nodeCount; i++) {
      layoutDelegate.layoutChild(
        '${Components.node}_$i',
        const BoxConstraints(
          maxWidth: 0,
          maxHeight: 0,
        ),
      );
      layoutDelegate.positionChild('${Components.node}_$i', Offset.zero);
    }
  }
}
