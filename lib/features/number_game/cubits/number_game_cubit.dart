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

  loadInitialData() {
    randomNumber.shuffle();
  }

  void cardPickked() {
    emit(CardPickkedState());
  }

  void restart() {
    answerNumber = [-1, -1, -1, -1, -1, -1];
    pickNumber = [1, 2, 3, 4, 5, 6];
  }
}
