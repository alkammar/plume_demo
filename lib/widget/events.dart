import 'package:flutter/material.dart';
import 'package:morkam/draw/component.dart';
import 'package:plume_demo/feature/component/hexagon.dart';

enum Components {
  hexagon,
  icon,
  count,
  label,
}

class Events extends StatefulComponent {
  @override
  State<StatefulWidget> createState() => _EventsState();
}

class _EventsState extends ComponentState<Events> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: _animationController,
    ));

    Future.delayed(const Duration(seconds: 2)).then((value) => _animationController.forward());
  }

  @override
  List<Widget> addComponents(BuildContext context, Orientation orientation) => [
    LayoutId(
      id: Components.hexagon,
      child: AnimatedBuilder(
        builder: (BuildContext context, Widget? _) => Hexagon(),
        animation: _animation,
      ),
    ),
    LayoutId(
      id: Components.icon,
      child: AnimatedBuilder(
        builder: (BuildContext context, Widget? _) => const Icon(
          Icons.shield_outlined,
          color: Color.fromARGB(0xFF, 0x33, 0x33, 0x33),
          size: 24,
        ),
        animation: _animation,
      ),
    ),
    LayoutId(
      id: Components.count,
      child: AnimatedBuilder(
        builder: (BuildContext context, Widget? _) => Text(
          (53438 * _animation.value).toInt().priceString,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color.fromARGB(0xFF, 0x33, 0x33, 0x33),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        animation: _animation,
      ),
    ),
    LayoutId(
      id: Components.label,
      child: AnimatedBuilder(
        builder: (BuildContext context, Widget? _) => const Text(
          'events',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(0xFF, 0x33, 0x33, 0x33),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        animation: _animation,
      ),
    ),
  ];

  @override
  void performLayout(Size size, Orientation orientation, MultiChildLayoutDelegate layoutDelegate) {
    _layoutCable(layoutDelegate, size);
    _layoutIcon(layoutDelegate, size);
    _layoutCount(layoutDelegate, size);
    _layoutLabel(layoutDelegate, size);
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

extension on int {
  String get priceString {
    final numberString = toString();
    final numberDigits = List.from(numberString.split(''));
    int index = numberDigits.length - 3;
    while (index > 0) {
      numberDigits.insert(index, ',');
      index -= 3;
    }
    return numberDigits.join();
  }
}
