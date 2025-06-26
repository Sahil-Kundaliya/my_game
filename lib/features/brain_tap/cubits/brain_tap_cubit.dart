import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_game/constants/app_colors.dart';
import 'package:my_game/features/brain_tap/cubits/brain_tap_state.dart';
import 'package:my_game/features/brain_tap/models/number_model.dart';
import 'package:my_game/features/brain_tap/models/timer_text_model.dart';
import 'package:my_game/utils/global_helper.dart';

class BrainTabCubit extends Cubit<BrainTabState> {
  BrainTabCubit() : super(BrainTapInitialState());

  List<NumberModel> allNumber = [];
  List<int> selectedNumber = [];
  int selectedGameIndex = -1;

  List<int> allGameIndex = [4, 6, 12, 16, 25, 30, 40];
  List<String> allGameLevel = [
    "Newbie", // 4
    "Beginner", // 6
    "Rookie", // 12
    "Intermediate", // 16
    "Advanced", // 25
    "Expert", // 30
    "Master" // 40
  ];
  int gridviewCrossAxisCount = 5;
  Timer? _ticker;
  Timer? _breakTicker;
  int timerCount = 0;
  int breakTimerCount = 0;
  bool playerWin = false;

  loadingGame() {
    allNumber.clear();

    var gameIndex = allGameIndex[selectedGameIndex];

    for (var i = 0; i < gameIndex; i++) {
      allNumber.add(NumberModel(
          number: i + 1, numberColor: GlobalHelper.getRandomColor()));
    }
    allNumber.shuffle();
    _onStartTimer();
    emit(BrainTapLoadingState());
  }

  double getTimerPercentage() {
    double percentage;
    var gameIndex = allGameIndex[selectedGameIndex];
    double timerInSec = gameIndex - (timerCount / 1000);
    percentage = ((timerInSec * 100) / gameIndex) / 100;

    if (percentage <= 0) {
      percentage = 0;
    } else if (percentage >= 1) {
      percentage = 1;
    }
    return percentage;
  }

  void nextLevel() {
    selectedGameIndex++;
    selectedNumber.clear();

    var gameIndex = allGameIndex[selectedGameIndex];
    if (gameIndex > 25) {
      gridviewCrossAxisCount = 6;
    }
    if (gameIndex == 25) {
      gridviewCrossAxisCount = 5;
    } else {
      gridviewCrossAxisCount = 4;
    }
    loadingGame();
    emit(BrainTapGameState());
  }

  void _onStartTimer() {
    _ticker?.cancel(); // cancel any existing timer
    var gameIndex = allGameIndex[selectedGameIndex];

    timerCount = gameIndex * 1000; //sec into milliseconds

    _ticker = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      timerCount -= 16;
      var timerIndex = timerCount / 1000; // milliseconds into sec

      if (timerIndex >= 0) {
        emit(BrainTapGameState());
      } else {
        emit(BrainTapGameOverState());

        timer.cancel();
      }
    });
  }

  void _onBreakTimer() {
    _breakTicker?.cancel(); // cancel any existing timer
    breakTimerCount = 4;

    emit(BrainTapBreakState());

    _breakTicker = Timer.periodic(const Duration(seconds: 1), (breakTimer) {
      breakTimerCount--;

      if (breakTimerCount <= 0) {
        nextLevel();
        breakTimer.cancel();
      } else {
        emit(BrainTapBreakState());
      }
    });
  }

  void tapNumber(int tap) {
    if (selectedNumber.isEmpty && tap == 1) {
      selectedNumber.add(tap);
      return;
    } else if (selectedNumber.isNotEmpty && (selectedNumber.last + 1) == tap) {
      selectedNumber.add(tap);
    }

    if (allNumber.length == selectedNumber.length) {
      if (selectedGameIndex == (allGameIndex.length - 1)) {
        playerWin = true;
        emit(BrainTapGameOverState());
        _ticker?.cancel();
        return;
      }
      _ticker?.cancel();
      _onBreakTimer();

      //win
    }
    emit(BrainTapGameState());
  }

  bool isIndexClicked(int gameIndex) {
    if (selectedNumber.contains(gameIndex)) {
      return true;
    }
    return false;
  }

  void restartGame() {
    selectedGameIndex = -1;
    playerWin = false;
    selectedNumber.clear();
    emit(BrainTapInitialState());
  }

  TimerTextModel get formattedTime {
    int seconds = timerCount ~/ 1000;
    int millis =
        ((timerCount % 1000) / (1000 / 60)).floor(); // convert ms to 0–59 scale
    String time = '$seconds:${millis.toString().padLeft(2, '0')}';
    Color timerColor = seconds <= 5 ? AppColors.redColor : AppColors.whiteColor;
    return TimerTextModel(timerValue: time, timerColor: timerColor);
  }
}
