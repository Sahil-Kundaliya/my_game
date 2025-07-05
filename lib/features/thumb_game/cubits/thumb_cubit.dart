import 'dart:async';

import 'package:my_game/features/home/screens/game_menu.dart';
import 'package:my_game/features/thumb_game/cubits/thumb_state.dart';
import 'package:my_game/utils/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThumbCubit extends Cubit<ThumbState> {
  ThumbCubit({required BuildContext context}) : super(ThumbStateInitialState());
  double player1Score = 0.0;
  double player2Score = 0.0;
  String winner = ''; // Red / Blue
  bool dataSet = false;

  loadPlayerData({required BuildContext context}) {
    winner = '';
    player1Score = Dimenstions.instance.screenHeight / 2;
    player2Score = Dimenstions.instance.screenHeight / 2;
    final size = MediaQuery.sizeOf(context);
    dataSet = true;
    // player_1Score = size.height / 2;
    // player_2Score = size.height / 2;
    emit(ThumbGameInfoState());
  }

  void startGame() {
    emit(ThumbGameState());
  }

  updateScore({required bool player1, required BuildContext context}) {
    double deviceHeight = Dimenstions.instance.screenHeight;
    if (winner.isEmpty) {
      if (player1) {
        player1Score += 20;
        player2Score -= 20;
        if (player1Score > deviceHeight) {
          player1Score = deviceHeight;
        }
        if (player2Score < 0) {
          player2Score = 0;
        }
      } else {
        player2Score += 20;
        player1Score -= 20;
        if (player2Score > deviceHeight) {
          player2Score = deviceHeight;
        }
        if (player1Score < 0) {
          player1Score = 0;
        }
      }
      if (player1Score >= deviceHeight) {
        winner = 'Red';
      } else if (player2Score >= deviceHeight) {
        winner = 'Blue';
      }
      if (winner.isNotEmpty) {
        restartGame(context: context);
      }

      emit(ThumbGameState());
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
