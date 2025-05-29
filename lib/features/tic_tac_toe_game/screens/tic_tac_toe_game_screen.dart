import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_game/constants/app_colors.dart';
import 'package:my_game/features/tic_tac_toe_game/cubits/tic_tac_toe_cubite.dart';
import 'package:my_game/features/tic_tac_toe_game/cubits/tic_tac_toe_state.dart';

class TicTacToeGameScreen extends StatelessWidget {
  const TicTacToeGameScreen({super.key});
  static const String ticTacToeGameScreen = '/TicTacToeGameScreen';

  @override
  Widget build(BuildContext context) {
    double boardWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => TicTacToeCubite(context),
      child: BlocBuilder<TicTacToeCubite, TicTacToeState>(
          builder: (context, state) {
        final ticTacToeCubite = context.read<TicTacToeCubite>();
        return SafeArea(
          child: Stack(
            children: [
              Scaffold(
                  backgroundColor: AppColors.primaryColor,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: ConfettiWidget(
                          confettiController: ticTacToeCubite.controllerCenter,
                          blastDirectionality: BlastDirectionality.explosive,
                          blastDirection: pi / 2,

                          emissionFrequency: 0.1,
                          numberOfParticles: 10, // a lot of particles at once
                          gravity:
                              0.1, // don't specify a direction, blast randomly
                          shouldLoop: true,
                          // start again as soon as the animation is finished
                        ),
                      ),
                      const SizedBox(
                        height: 40.00,
                      ),
                      Text(
                        "It's ${ticTacToeCubite.lastValue} turn".toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      //now we will make the game board
                      //but first we will create a Game class that will contains all the data and method that we will need
                      SizedBox(
                        width: boardWidth,
                        height: boardWidth,
                        child: GridView.count(
                          crossAxisCount: ticTacToeCubite.boardlenth ~/
                              3, // the ~/ operator allows you to evide to integer and return an Int as a result
                          padding: const EdgeInsets.all(16.0),
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                          children: List.generate(ticTacToeCubite.boardlenth,
                              (index) {
                            return InkWell(
                              onTap: ticTacToeCubite.gameOver
                                  ? null
                                  : () {
                                      //when we click we need to add the new value to the board and refrech the screen
                                      //we need also to toggle the player
                                      //now we need to apply the click only if the field is empty
                                      //now let's create a button to repeat the game

                                      ticTacToeCubite.onTap(index);
                                    },
                              child: Container(
                                width: ticTacToeCubite.blocSize,
                                height: ticTacToeCubite.blocSize,
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    ticTacToeCubite.board[index],
                                    style: TextStyle(
                                      color:
                                          ticTacToeCubite.board![index] == "X"
                                              ? Colors.blue
                                              : Colors.pink,
                                      fontSize: 54.0,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        ticTacToeCubite.result,
                        style: const TextStyle(
                            color: Colors.cyanAccent, fontSize: 40.0),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      ElevatedButton.icon(
                        onPressed: () {
                          ticTacToeCubite.restartGame();
                        },
                        icon: const Icon(Icons.replay),
                        label: const Text("Play New Game"),
                      ),
                    ],
                  )),
            ],
          ),
        );
      }),
    );
    //the first step is organise our project folder structure
  }
}
