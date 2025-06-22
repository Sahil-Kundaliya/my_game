import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_game/features/brain_tap/cubits/brain_tap_state.dart';
import 'package:my_game/features/brain_tap/models/number_model.dart';
import 'package:my_game/utils/global_helper.dart';

class BrainTabCubit extends Cubit<BrainTabState> {
  BrainTabCubit() : super(BrainTapInitialState()) {
    emit(BrainTapGameIndexState());
  }
  List<NumberModel> allNumber = [];
  List<int> selectedNumber = [];
  int selectedGameIndex = 0;
  List<int> allGameIndex = [12, 16, 25];
  int gridviewCrossAxisCount = 5;
  Timer? _ticker;
  int timerCount = 0;
  bool playerWin = false;

  loadingGames() {
    allNumber.clear();
    for (var i = 0; i < selectedGameIndex; i++) {
      allNumber.add(NumberModel(
          number: i + 1, numberColor: GlobalHelper.getRandomColor()));
    }
    allNumber.shuffle();
    _onStartTimer();
    emit(BrainTapLoadingState());
  }

  double getTimerPercentage() {
    double percentage;

    percentage = ((timerCount * 100) / selectedGameIndex) / 100;

    if (percentage <= 0) {
      percentage = 0;
    } else if (percentage >= 1) {
      percentage = 1;
    }
    return percentage;
  }

  void changeGameIndex(int nextIndex) {
    selectedGameIndex = nextIndex;
    if (selectedGameIndex == 25) {
      gridviewCrossAxisCount = 5;
    } else {
      gridviewCrossAxisCount = 4;
    }
    loadingGames();
    emit(BrainTapGamesState());
  }

  void _onStartTimer() {
    _ticker?.cancel(); // cancel any existing timer
    timerCount = 0;

    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      timerCount++;
      if (timerCount <= selectedGameIndex) {
        emit(BrainTapGamesState());
      } else {
        emit(BrainTapGameOverState());

        timer.cancel();
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
      playerWin = true;
      _ticker?.cancel();
      emit(BrainTapGameOverState());

      //win
    }
  }

  void restartGame() {
    playerWin = false;
    selectedNumber.clear();
    emit(BrainTapGameIndexState());
  }
}
