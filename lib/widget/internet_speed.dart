import 'package:flutter/material.dart';
import 'package:morkam/draw/component.dart';
import 'package:plume_demo/feature/component/hexagon.dart';

enum Components {
  hexagon,
  icon,
  download,
  upload,
}

class InternetSpeed extends StatefulComponent {
  @override
  State<StatefulWidget> createState() => _InternetSpeedState();
}

class _InternetSpeedState extends ComponentState<InternetSpeed> with TickerProviderStateMixin {
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
      curve: Curves.easeOutCubic,
      parent: _animationController,
    ));

    _animationController.forward();
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
              Icons.speed,
              color: Color.fromARGB(0xFF, 0x33, 0x33, 0x33),
              size: 24,
            ),
            animation: _animation,
          ),
        ),
        LayoutId(
          id: Components.download,
          child: AnimatedBuilder(
            builder: (BuildContext context, Widget? _) => Row(
              children: [
                const Icon(
                  Icons.arrow_downward,
                  color: Color.fromARGB(0xFF, 0x33, 0x33, 0x33),
                  size: 24,
                ),
                Text(
                  (127 * _animation.value).toStringAsFixed(0),
                  style: const TextStyle(
                    color: Color.fromARGB(0xFF, 0x33, 0x33, 0x33),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Mbps',
                  style: TextStyle(
                    color: Color.fromARGB(0xFF, 0x33, 0x33, 0x33),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            animation: _animation,
          ),
        ),
        LayoutId(
          id: Components.upload,
          child: AnimatedBuilder(
            builder: (BuildContext context, Widget? _) => Row(
              children: [
                const Icon(
                  Icons.arrow_upward,
                  color: Color.fromARGB(0xFF, 0x33, 0x33, 0x33),
                  size: 24,
                ),
                Text(
                  (33 * _animation.value).toStringAsFixed(0),
                  style: const TextStyle(
                    color: Color.fromARGB(0xFF, 0x33, 0x33, 0x33),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Mbps',
                  style: TextStyle(
                    color: Color.fromARGB(0xFF, 0x33, 0x33, 0x33),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            animation: _animation,
          ),
        ),
      ];

  @override
  void performLayout(Size size, Orientation orientation, MultiChildLayoutDelegate layoutDelegate) {
    _layoutCable(layoutDelegate, size);
    _layoutIcon(layoutDelegate, size);
    _layoutDownload(layoutDelegate, size);
    _layoutUpload(layoutDelegate, size);
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

  _layoutDownload(MultiChildLayoutDelegate layoutDelegate, Size size) {
    Size widgetSize = layoutDelegate.layoutChild(
      Components.download,
      BoxConstraints(
        maxWidth: size.width,
        maxHeight: size.height,
      ),
    );

    layoutDelegate.positionChild(
      Components.download,
      Offset(
        (size.width - widgetSize.width) / 2 + 15,
        (size.height - widgetSize.height) / 2 - 10,
      ),
    );
  }

  _layoutUpload(MultiChildLayoutDelegate layoutDelegate, Size size) {
    Size widgetSize = layoutDelegate.layoutChild(
      Components.upload,
      BoxConstraints(
        maxWidth: size.width,
        maxHeight: size.height,
      ),
    );

    layoutDelegate.positionChild(
      Components.upload,
      Offset(
        (size.width - widgetSize.width) / 2 + 31,
        (size.height - widgetSize.height) / 2 + 20,
      ),
    );
  }
}
