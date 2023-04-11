import 'package:flutter/material.dart';
import 'package:machine_test/model/game_screen_args.dart';
import 'package:machine_test/view/screens/game_screen.dart';
import 'package:machine_test/view/screens/home_screen.dart';
import 'package:machine_test/view/screens/splash_screen.dart';

class CustomRouter {
  static const splashScreen = "/splashScreen";
  static const homeScreen = "/homeScreen";
  static const gameScreen = "/gameScreen";

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SplashScreen(),
        );
      case homeScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomeScreen(),
        );

      case gameScreen:
        final args = settings.arguments as GameScreenArgs;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => GameScreen(
            args: args,
          ),
        );

      default:
        return null;
    }
  }
}
