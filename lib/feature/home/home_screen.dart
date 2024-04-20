import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plume_demo/feature/component/clickable_background.dart';
import 'package:plume_demo/feature/home/home_bloc.dart';
import 'package:plume_demo/widget/devices.dart';
import 'package:plume_demo/widget/empty.dart';
import 'package:plume_demo/widget/events.dart';
import 'package:plume_demo/widget/internet_speed.dart';
import 'package:plume_demo/widget/motion.dart';
import 'package:plume_demo/widget/nodes.dart';
import 'package:plume_demo/widget/people.dart';
import 'package:plume_demo/widget/timeout.dart';

const cellWidthScale = 0.385;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver, TickerProviderStateMixin {
  Pair<double, double>? _clickedPosition;

  late AnimationController _clickAnimationController;
  late Animation<double> _clickAnimation;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<HomeBloc>().add(Initialize());

    _clickAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _clickAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      curve: Curves.easeOutCubic,
      parent: _clickAnimationController,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        context.read<HomeBloc>().add(Foreground());
        break;
      case AppLifecycleState.paused:
        context.read<HomeBloc>().add(Background());
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.purple,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                    AnimatedBuilder(
                      builder: (context, child) {
                        return ClickableBackground(
                            Offset(_clickedPosition?.a ?? 0, _clickedPosition?.b ?? 0), _clickAnimation.value);
                      },
                      animation: _clickAnimation,
                    ),
                  ] +
                  honeyCombFill() +
                  [
                    Positioned(
                      top: MediaQuery.of(context).size.width * cellWidthScale * 0.92 - 80,
                      child: ImageIcon(
                        const AssetImage('assets/images/logo.png'),
                        color: Colors.blue,
                        size: MediaQuery.of(context).size.width * cellWidthScale,
                      ),
                    ),
                    const Positioned(
                      right: 20,
                      top: 20,
                      child: Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 24,
                      ),
                    ),
                    const Positioned(
                      left: 20,
                      top: 20,
                      child: Text(
                        'Sun City',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
            ),
          ),
        ),
      );

  List<Widget> honeyCombFill() {
    final List<Widget> list = [];

    final double size = MediaQuery.of(context).size.width * cellWidthScale;

    final cells = {
      const Pair(1, 2): InternetSpeed(),
      const Pair(0, 2): Devices(),
      const Pair(1, 3): Motion(),
      const Pair(0, 3): People(),
      const Pair(1, 4): Nodes(),
      const Pair(2, 3): Timeout(),
      const Pair(2, 2): Events(),
    };

    for (int i = -1; i < 5; i++) {
      for (int j = 2; j < 10; j++) {
        final k = i % 2 == 0 ? 0 : -1;
        list.add(
          Positioned(
            left: i * size * 0.8,
            top: j * size * 0.92 + k * size * 0.46 - 80,
            child: SizedBox(
              width: size,
              height: size,
              child: GestureDetector(
                child: cells[Pair(i, j)] ?? Empty(),
                onTap: () {
                  _clickedPosition = Pair(
                    i * size * 0.8 + size * 0.5,
                    j * size * 0.92 + k * size * 0.46 - 80 + size * 0.5,
                  );
                  _clickAnimationController.forward().then((value) => _clickAnimationController.reverse());
                },
              ),
            ),
          ),
        );
      }
    }

    return list;
  }
}

class Cell {
  final int row;
  final int column;
  final Widget widget;

  Cell(this.row, this.column, this.widget);
}

class Pair<T1, T2> extends Equatable {
  final T1 a;
  final T2 b;

  const Pair(this.a, this.b);

  @override
  List<Object?> get props => [a, b];
}
