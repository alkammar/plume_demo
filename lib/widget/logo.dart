import 'package:flutter/material.dart';
import 'package:morkam/draw/component.dart';
import 'package:plume_demo/feature/component/logo_swirl.dart';

enum Components {
  logoSwirl,
}

class Logo extends StatefulComponent {
  @override
  State<StatefulWidget> createState() => _LogoState();
}

class _LogoState extends ComponentState<Logo> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late AnimationController _rotationAnimationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      curve: Curves.linear,
      parent: _animationController,
    ));

    _rotationAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _rotationAnimation = Tween(
      begin: 0.0,
      end: -360.0,
    ).animate(CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _rotationAnimationController,
    ));

    _animationController.forward();
    _rotationAnimationController.forward();
  }

  @override
  List<Widget> addComponents(BuildContext context, Orientation orientation) => [
    LayoutId(
      id: Components.logoSwirl,
      child: AnimatedBuilder(
        builder: (BuildContext context, Widget? _) => LogoSwirl(Colors.blue, _animation.value, _rotationAnimation.value),
        animation: _animation,
      ),
    ),
  ];

  @override
  void performLayout(Size size, Orientation orientation, MultiChildLayoutDelegate layoutDelegate) {
    _layoutCable(layoutDelegate, size);
  }

  _layoutCable(MultiChildLayoutDelegate layoutDelegate, Size size) {
    layoutDelegate.layoutChild(
      Components.logoSwirl,
      BoxConstraints(
        maxWidth: size.width,
        maxHeight: size.height,
      ),
    );

    layoutDelegate.positionChild(
      Components.logoSwirl,
      Offset.zero,
    );
  }
}
