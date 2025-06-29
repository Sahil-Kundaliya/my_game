import 'dart:async';
import 'dart:developer';

import 'package:my_game/features/home/screens/game_menu.dart';
import 'package:my_game/features/thumb_game/cubits/thumb_state.dart';
import 'package:my_game/utils/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThumbCubit extends Cubit<ThumbState> {
  ThumbCubit({required BuildContext context}) : super(ThumbStateInitialState());
  double player_1Score = 0.0;
  double player_2Score = 0.0;
  String winner = ''; // Red / Blue
  bool dataSet = false;

  loadPlayerData({required BuildContext context}) {
    winner = '';
    player_1Score = Dimenstions.instance.screenHeight / 2;
    player_2Score = Dimenstions.instance.screenHeight / 2;
    final size = MediaQuery.sizeOf(context);
    print(size.toString());
    dataSet = true;
    // player_1Score = size.height / 2;
    // player_2Score = size.height / 2;

    updateState();
  }

  updateScore({required bool player1, required BuildContext context}) {
    double deviceHeight = Dimenstions.instance.screenHeight;
    if (winner.isEmpty) {
      if (player1) {
        player_1Score += 20;
        player_2Score -= 20;
        if (player_1Score > deviceHeight) {
          player_1Score = deviceHeight;
        }
        if (player_2Score < 0) {
          player_2Score = 0;
        }
      } else {
        player_2Score += 20;
        player_1Score -= 20;
        if (player_2Score > deviceHeight) {
          player_2Score = deviceHeight;
        }
        if (player_1Score < 0) {
          player_1Score = 0;
        }
      }
      if (player_1Score >= deviceHeight) {
        winner = 'Red';
        restartGame(context: context);
      } else if (player_2Score >= deviceHeight) {
        winner = 'Blue';
        restartGame(context: context);
      }

      updateState();
    }
  }

  restartGame({required BuildContext context}) {
    Future.delayed(const Duration(seconds: 5), () {
      if (context.mounted) {
        loadPlayerData(context: context);
        Navigator.pushNamedAndRemoveUntil(
            context, GameMenuScreen.gameMenuScreen, (route) => false);
      }
    });
  }

  updateState() {
    emit(ThumbStateUpdateState());
  }
}
