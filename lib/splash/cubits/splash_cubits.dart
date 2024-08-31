import 'package:dazll_demo/features/home/screens/game_menu.dart';
import 'package:dazll_demo/splash/cubits/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(BuildContext context) : super(SplashPageState()) {
    showSlpashPage(context);
  }

  void showSlpashPage(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        return Navigator.of(context)
            .pushReplacementNamed(GameMenuScreen.gameMenuScreen);
      },
    );
  }
}
