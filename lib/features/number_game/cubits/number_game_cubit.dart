import 'dart:developer';

import 'package:dazll_demo/constants/app_enums.dart';
import 'package:dazll_demo/features/number_game/cubits/number_game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberGameCubit extends Cubit<NumberGameState> {
  NumberGameCubit() : super(NumberGameInitialState()) {
    // loadInitialData();
    changeLevel();
    loadLevelData();
  }
  List<int> randomNumber = [];
  List<int> answerNumber = [];
  List<int> pickNumber = [];
  bool answerPicked = false;
  int selectedItem = -1;
  int attemptedCount = 0;
  int totalRightAnswer = 0;
  List<int> checkedAnswerList = [];
  GameLevel? currentLevel;
  bool winnerTime = false;

  loadLevelData() {
    switch (currentLevel) {
      case GameLevel.level_1:
        loadLevel_1Data();
        break;
      case GameLevel.level_2:
        loadLevel_2Data();
        break;
      case GameLevel.level_3:
        loadLevel_3Data();
        break;
      default:
        loadLevel_1Data();
    }
  }

  loadLevel_1Data() {
    randomNumber = [1, 2, 3, 4, 5, 6];
    answerNumber = [-1, -1, -1, -1, -1, -1];
    pickNumber = [1, 2, 3, 4, 5, 6];
    loadInitialData();
  }

  loadLevel_2Data() {
    randomNumber = [1, 2, 3, 4, 5, 6, 7, 8];
    answerNumber = [-1, -1, -1, -1, -1, -1, -1, -1];
    pickNumber = [1, 2, 3, 4, 5, 6, 7, 8];
    loadInitialData();
  }

  loadLevel_3Data() {
    randomNumber = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    answerNumber = [-1, -1, -1, -1, -1, -1, -1, -1, -1];
    pickNumber = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    loadInitialData();
  }

  changeLevel() {
    if (currentLevel == GameLevel.level_1) {
      currentLevel = GameLevel.level_2;
    } else if (currentLevel == GameLevel.level_2) {
      currentLevel = GameLevel.level_3;
    } else {
      currentLevel = GameLevel.level_1;
    }
    updateState();
  }

  loadInitialData() {
    answerPicked = false;
    randomNumber.shuffle();
    log('SSS answer $answerNumber');
    // log('SSS answer $answerNumber');
    log('SSS pick $pickNumber');
    updateState();
  }

  void updateState() {
    emit(UpDateState());
  }

  changeSelctedItemIndex({required int index}) {
    selectedItem = index;
    updateState();
  }

  // void restart() {
  //   answerNumber = [-1, -1, -1, -1, -1, -1];
  //   pickNumber = [1, 2, 3, 4, 5, 6];
  // }

  checkAnswer({required BuildContext context}) async {
    bool checkedAnswer = true;
    if (answerPicked) {
      if (checkedAnswerList.isNotEmpty) {
        for (var i = 0; i < answerNumber.length; i++) {
          if (answerNumber[i] != checkedAnswerList[i]) {
            checkedAnswer = false;
            break;
          }
        }
      }
      if ((!checkedAnswer) || checkedAnswerList.isEmpty) {
        checkedAnswerList = List.from(answerNumber);
        totalRightAnswer = 0;
        if (!answerNumber.contains(-1)) {
          for (var i = 0; i < randomNumber.length; i++) {
            if (randomNumber[i] == answerNumber[i]) {
              totalRightAnswer += 1;
            }
          }
          if (totalRightAnswer == answerNumber.length) {
            winnerTime = true;
            updateState();
            await Future.delayed(const Duration(seconds: 3));
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('You Win'),
            ));
            winnerTime = false;

            changeLevel();
            loadLevelData();
          } else {
            attemptedCount++;
          }
          updateState();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please shuffle cards to win'),
        ));
      }
    }
  }

  selectedAnswer(
      {required BuildContext context,
      required DragTargetDetails<Object?> details,
      required int index}) {
    if (answerNumber[index] == -1) {
      pickNumber.removeWhere(
        (element) {
          return element == int.parse(details.data.toString()) ? true : false;
        },
      );

      for (var i = 0; i < answerNumber.length; i++) {
        if (i == selectedItem) {
          answerNumber[i] = -1;
        }
      }
      answerNumber[index] = int.parse(details.data.toString());
    } else {
      answerNumber[selectedItem] = answerNumber[index];
      answerNumber[index] = int.parse(details.data.toString());
    }
    if (!answerNumber.contains(-1)) {
      answerPicked = true;
    }
    updateState();
  }

  selecteRandomAnswer() {
    answerNumber = pickNumber;
    answerNumber.shuffle();
    answerPicked = true;
    log('SSS answer list is =- $answerNumber');
    updateState();
  }
}
