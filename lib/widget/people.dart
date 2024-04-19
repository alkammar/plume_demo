import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morkam/draw/component.dart';
import 'package:plume_demo/feature/component/hexagon.dart';
import 'package:plume_demo/feature/component/sector.dart';
import 'dart:ui' as ui;

enum Components {
  hexagon,
  icon,
  person1,
  person2,
  person3,
  person4,
}

class People extends StatefulComponent {
  @override
  State<StatefulWidget> createState() => _PeopleState();
}

class _PeopleState extends ComponentState<People> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  late ui.Image? _dad;
  late ui.Image? _mom;
  late ui.Image? _son;
  late ui.Image? _daughter;

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

    _animationController.forward();

    setState(() {

    });

    loadUiImage('assets/images/man.png').then((value) => setState(() => _dad = value));
    loadUiImage('assets/images/woman.png').then((value) => setState(() => _mom = value));
    loadUiImage('assets/images/boy.png').then((value) => setState(() => _son = value));
    loadUiImage('assets/images/girl.png').then((value) => setState(() => _daughter = value));
  }

  Future<ui.Image> loadUiImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
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
          Icons.people,
          color: Color.fromARGB(0xFF, 0x33, 0x33, 0x33),
          size: 24,
        ),
        animation: _animation,
      ),
    ),
    LayoutId(
      id: Components.person1,
      child: AnimatedBuilder(
        builder: (BuildContext context, Widget? _) => _dad == null ? const SizedBox.shrink() : Sector(0, _dad!),
        animation: _animation,
      ),
    ),
    LayoutId(
      id: Components.person2,
      child: AnimatedBuilder(
        builder: (BuildContext context, Widget? _) => _mom == null ? const SizedBox.shrink() : Sector(1, _mom!),
        animation: _animation,
      ),
    ),
    LayoutId(
      id: Components.person3,
      child: AnimatedBuilder(
        builder: (BuildContext context, Widget? _) => _dad == null ? const SizedBox.shrink() : Sector(2, _son!),
        animation: _animation,
      ),
    ),
    LayoutId(
      id: Components.person4,
      child: AnimatedBuilder(
        builder: (BuildContext context, Widget? _) => _dad == null ? const SizedBox.shrink() : Sector(3, _daughter!),
        animation: _animation,
      ),
    ),
  ];

  @override
  void performLayout(Size size, Orientation orientation, MultiChildLayoutDelegate layoutDelegate) {
    _layoutCable(layoutDelegate, size);
    _layoutIcon(layoutDelegate, size);
    _layoutPerson(layoutDelegate, size, Components.person1);
    _layoutPerson(layoutDelegate, size, Components.person2);
    _layoutPerson(layoutDelegate, size, Components.person3);
    _layoutPerson(layoutDelegate, size, Components.person4);
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
        size.width / 2 - 12 - 15,
        18 + 10,
      ),
    );
  }

  _layoutPerson(MultiChildLayoutDelegate layoutDelegate, Size size, id) {
    Size widgetSize = layoutDelegate.layoutChild(
      id,
      BoxConstraints(
        maxWidth: size.width,
        maxHeight: size.height,
      ),
    );

    layoutDelegate.positionChild(
      id,
      Offset(
        (size.width - widgetSize.width) / 2,
        (size.height - widgetSize.height) / 2,
      ),
    );
  }
}
