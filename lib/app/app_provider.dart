import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class AppProvider extends MultiProvider {
  AppProvider({
    super.key,
    required List<SingleChildWidget> sourceProviders,
    required List<SingleChildWidget> repositoryProviders,
    required Widget child,
  }) : super(
          providers: sourceProviders + repositoryProviders + _blocProviders(),
          child: child,
        );

  static List<SingleChildWidget> _blocProviders() => [];
}
