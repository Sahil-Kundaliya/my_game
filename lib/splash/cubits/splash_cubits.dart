import 'package:my_game/features/home/screens/game_menu.dart';
import 'package:my_game/splash/cubits/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(BuildContext context) : super(SplashPageState()) {
    showSplashPage(context);
  }

  void showSplashPage(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        return Navigator.of(context)
            .pushReplacementNamed(GameMenuScreen.gameMenuScreen);
      },
    );
  }
}
