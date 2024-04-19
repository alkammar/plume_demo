import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plume_demo/feature/home/home_bloc.dart';
import 'package:provider/provider.dart';

class HomeProvider extends MultiProvider {
  HomeProvider({super.key,
    required Widget child,
  }) : super(
    child: child,
    providers: [
      BlocProvider(
        create: (context) =>
            HomeBloc(
                deviceRepository: context.read(),
            ),
      ),
    ],
  );
}
