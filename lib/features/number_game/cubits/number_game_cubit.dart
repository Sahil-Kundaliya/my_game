import 'dart:developer';

import 'package:dazll_demo/features/number_game/cubits/number_game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberGameCubit extends Cubit<NumberGameState> {
  NumberGameCubit() : super(NumberGameInitialState()) {
    loadInitialData();
  }
  List<int> randomNumber = [1, 2, 3, 4, 5, 6];
  List<int> answerNumber = [-1, -1, -1, -1, -1, -1];
  List<int> pickNumber = [1, 2, 3, 4, 5, 6];
  bool answerPicked = false;
  int selectedItem = -1;
  int attemptedCount = 0;
  int totalRightAnswer = 0;

  loadInitialData() {
    randomNumber.shuffle();
  }

  void updateState() {
    emit(UpDateState());
  }

  changeSelctedItemIndex({required int index}) {
    selectedItem = index;
    updateState();
  }

  void restart() {
    answerNumber = [-1, -1, -1, -1, -1, -1];
    pickNumber = [1, 2, 3, 4, 5, 6];
  }

  checkAnswer({required BuildContext context}) {
    totalRightAnswer = 0;
    if (!answerNumber.contains(-1)) {
      for (var i = 0; i < randomNumber.length; i++) {
        if (randomNumber[i] == answerNumber[i]) {
          totalRightAnswer += 1;
        }
      }
      if (totalRightAnswer == answerNumber.length) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('You Win'),
        ));
      } else {
        attemptedCount++;
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text(
        //       'You Loss, ${totalRightAnswer == -1 ? 0 : totalRightAnswer} Correct Answer'),
        // ));
        // restart();
      }
      emit(UpDateState());
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
}
