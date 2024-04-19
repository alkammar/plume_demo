import 'package:flutter/material.dart';
import 'package:morkam/generated/morkam_localizations.dart';
import 'package:morkam/theme/theme.dart';
import 'package:plume_demo/app/repository_provider.dart';
import 'package:plume_demo/app/source_provider.dart';
import 'package:plume_demo/app/app_provider.dart';
import 'package:plume_demo/feature/home/home_provider.dart';
import 'package:plume_demo/feature/home/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => AppProvider(
        sourceProviders: sourceProviders(),
        repositoryProviders: repositoryProviders(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeProvider(
            child: const HomeScreen(),
          ),
          theme: morkamDarkTheme(context),
          localizationsDelegates: const [
            MorkamLocalizations.delegate,
          ],
          routes: const {},
        ),
      );
}
