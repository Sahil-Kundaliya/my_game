import 'dart:developer';

import 'package:dazll_demo/features/number_game/cubits/number_game_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NumberGameCubit extends Cubit<NumberGameState> {
  NumberGameCubit() : super(NumberGameInitialState()) {
    loadInitialData();
  }
  List<int> randomNumber = [1, 2, 3, 4, 5, 6];
  List<int> answerNumber = [-1, -1, -1, -1, -1, -1];
  List<int> pickNumber = [1, 2, 3, 4, 5, 6];
  bool trueAnswer = false;
  int selectedItem = -1;

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
}
