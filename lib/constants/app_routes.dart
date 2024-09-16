import 'package:flutter/material.dart';

import '../features/home/screens/game_menu.dart';
import '../features/number_game/screens/number_game.dart';
import '../features/thumb_game/screens/thumb_page.dart';
import '../splash/splash_page.dart';

class AppRoutes {
  static final AppRoutes _appRoutes = AppRoutes();
  static AppRoutes get instance => _appRoutes;

  static String splashScreen = '/';

  Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const SplashScreen(),
    NumberGameScreen.numberGameScreen: (context) => const NumberGameScreen(),
    GameMenuScreen.gameMenuScreen: (context) => const GameMenuScreen(),
    ThumbGameScreen.thumbGameScreen: (context) => const ThumbGameScreen(),
  };
}
