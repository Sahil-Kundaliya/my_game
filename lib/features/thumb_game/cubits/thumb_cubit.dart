import 'dart:developer';

import 'package:my_game/features/number_game/screens/number_game.dart';
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

  updateScore({required bool player1}) {
    double deviceHeight = Dimenstions.instance.screenHeight;
    if (winner.isEmpty) {
      log('SSS player_2Score $player_2Score');
      log('SSS player_1Score $player_1Score');
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
      } else if (player_2Score >= deviceHeight) {
        winner = 'Blue';
      }
      log('SSS player_2Score $player_2Score');
      log('SSS player_1Score $player_1Score');
      updateState();
    }
  }

  updateState() {
    emit(ThumbStateUpdateState());
  }
}
