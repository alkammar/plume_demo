import 'package:flutter/material.dart';
import 'package:morkam/draw/component.dart';
import 'package:plume_demo/feature/hexagon/hexagon.dart';
import 'package:plume_demo/feature/hexagon/waves.dart';

enum Components {
  hexagon,
  waves,
  icon,
  count,
  label,
}

class Motion extends StatefulComponent {
  @override
  State<StatefulWidget> createState() => _DevicesState();
}

class _DevicesState extends ComponentState<Motion> with TickerProviderStateMixin {
  late AnimationController _tickAnimationController;
  late Animation<double> _tickAnimation;
  late AnimationController _levelAnimationController;
  late Animation<double> _levelAnimation;

  @override
  void initState() {
    super.initState();

    _tickAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _tickAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: _tickAnimationController,
    ));

    _levelAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _levelAnimation = Tween(
      begin: 0.0,
      end: 0.7,
    ).animate(CurvedAnimation(
      curve: Curves.easeOut,
      parent: _levelAnimationController,
    ));

    _tickAnimationController.forward();
    _tickAnimationController.repeat();

    _levelAnimationController.forward();
  }

  @override
  List<Widget> addComponents(BuildContext context, Orientation orientation) => [
    LayoutId(
      id: Components.hexagon,
      child: AnimatedBuilder(
        builder: (BuildContext context, Widget? _) => Hexagon(),
        animation: _tickAnimation,
      ),
    ),
    LayoutId(
      id: Components.waves,
      child: AnimatedBuilder(
        builder: (BuildContext context, Widget? _) => Waves(_tickAnimation.value, _levelAnimation.value),
        animation: _tickAnimation,
      ),
    ),
    LayoutId(
      id: Components.icon,
      child: AnimatedBuilder(
        builder: (BuildContext context, Widget? _) => const Icon(
          Icons.sensors_sharp,
          color: Color.fromARGB(0xFF, 0x33, 0x33, 0x33),
          size: 24,
        ),
        animation: _tickAnimation,
      ),
    ),
    LayoutId(
      id: Components.count,
      child: AnimatedBuilder(
        builder: (BuildContext context, Widget? _) => const Text(
          '',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(0xFF, 0x33, 0x33, 0x33),
            fontWeight: FontWeight.bold,
            fontSize: 48,
          ),
        ),
        animation: _tickAnimation,
      ),
    ),
    LayoutId(
      id: Components.label,
      child: AnimatedBuilder(
        builder: (BuildContext context, Widget? _) => const Text(
          'TV',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(0xFF, 0x33, 0x33, 0x33),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        animation: _tickAnimation,
      ),
    ),
  ];

  @override
  void performLayout(Size size, Orientation orientation, MultiChildLayoutDelegate layoutDelegate) {
    _layoutHexagon(layoutDelegate, size);
    _layoutWaves(layoutDelegate, size);
    _layoutIcon(layoutDelegate, size);
    _layoutCount(layoutDelegate, size);
    _layoutLabel(layoutDelegate, size);
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

  _layoutWaves(MultiChildLayoutDelegate layoutDelegate, Size size) {
    layoutDelegate.layoutChild(
      Components.waves,
      BoxConstraints(
        maxWidth: size.width,
        maxHeight: size.height,
      ),
    );

    layoutDelegate.positionChild(
      Components.waves,
      Offset.zero,
    );
  }

  _layoutIcon(MultiChildLayoutDelegate layoutDelegate, Size size) {
    layoutDelegate.layoutChild(
      Components.icon,
      BoxConstraints(
        maxWidth: size.width,
        maxHeight: size.height,
      ),
    );

    layoutDelegate.positionChild(
      Components.icon,
      Offset(
        size.width / 2 - 12,
        18,
      ),
    );
  }

  _layoutCount(MultiChildLayoutDelegate layoutDelegate, Size size) {
    Size widgetSize = layoutDelegate.layoutChild(
      Components.count,
      BoxConstraints(
        maxWidth: size.width,
        maxHeight: size.height,
      ),
    );

    layoutDelegate.positionChild(
      Components.count,
      Offset(
        (size.width - widgetSize.width) / 2,
        (size.height - widgetSize.height) / 2,
      ),
    );
  }

  _layoutLabel(MultiChildLayoutDelegate layoutDelegate, Size size) {
    Size widgetSize = layoutDelegate.layoutChild(
      Components.label,
      BoxConstraints(
        maxWidth: size.width,
        maxHeight: size.height,
      ),
    );

    layoutDelegate.positionChild(
      Components.label,
      Offset(
        (size.width - widgetSize.width) / 2,
        (size.height - widgetSize.height) / 2 + 35,
      ),
    );
  }
}
