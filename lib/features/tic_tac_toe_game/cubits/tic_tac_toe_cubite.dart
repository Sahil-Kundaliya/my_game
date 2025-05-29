import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_game/features/tic_tac_toe_game/cubits/tic_tac_toe_state.dart';

class TicTacToeCubite extends Cubit<TicTacToeState> {
  TicTacToeCubite(BuildContext context) : super(TicTacToeInitialState()) {
    board = initGameBoard() ?? [];
    controllerCenter = ConfettiController();
  }
  late ConfettiController controllerCenter;

  String lastValue = "X";
  bool gameOver = false;
  int turn = 0;

  String result = "";
  List<int> scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
  int boardlenth = 9; // we will creare a board of 3*3 blocks;
  double blocSize = 100.0;
  List<String> board = [];
  //the score are for the different combination of the game [Row1,2,3, Col1,2,3, Diagonal1,2];

  List<String>? initGameBoard() => List.generate(boardlenth, (index) => '');

  //Creating the empty board

  //now we need to build the winner check algorithm
  //for this we need first to declare a scoreboard in our main file
  bool winnerCheck(
      String player, int index, List<int> scoreboard, int gridSize) {
    //first let's declare the row   and col
    int row = index ~/ 3;
    int col = index % 3;
    int score = player == "X" ? 1 : -1;

    scoreboard[row] += score;
    scoreboard[gridSize + col] += score;
    if (row == col) scoreboard[2 * gridSize] += score;
    if (gridSize - 1 - col == row) scoreboard[2 * gridSize + 1] += score;

    //checking if we have 3 or -3 in the score board
    if (scoreboard.contains(3) || scoreboard.contains(-3)) {
      return true;
    }

    //by default it will return false
    return false;
  }

  void onTap(int index) {
    if (board![index] == "") {
      board![index] = lastValue;
      turn++;
      gameOver = winnerCheck(lastValue, index, scoreboard, 3);

      if (gameOver) {
        result = "$lastValue is the Winner";
        controllerCenter.play();
      } else if (!gameOver && turn == 9) {
        result = "It's a Draw!";
        gameOver = true;
      }
      if (lastValue == "X") {
        lastValue = "O";
      } else {
        lastValue = "X";
      }
    }
    emit(TicTacToeUpdateState());
  }

  void restartGame() {
    board = initGameBoard() ?? [];
    lastValue = "X";
    gameOver = false;
    turn = 0;
    result = "";
    scoreboard = [0, 0, 0, 0, 0, 0, 0, 0];
    controllerCenter.stop();
    emit(TicTacToeUpdateState());
  }
}
