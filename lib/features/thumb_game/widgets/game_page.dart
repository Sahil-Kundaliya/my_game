import 'package:flutter/material.dart';
import 'package:my_game/constants/app_colors.dart';
import 'package:my_game/features/thumb_game/widgets/player_widget.dart';

class GamePage extends StatelessWidget {
  const GamePage(
      {super.key,
      required this.player1Score,
      required this.player2Score,
      required this.winner,
      required this.player1Tap,
      required this.player2Tap});
  final double player1Score, player2Score;
  final String winner;
  final VoidCallback player1Tap, player2Tap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlayerWidget(
          playerTitle: "Blue Win",
          playerWon: winner == 'Blue',
          playerHeight: player2Score,
          playerColor: AppColors.blueColor,
          onTap: player2Tap,
        ),
        PlayerWidget(
          playerTitle: "Red Win",
          playerWon: winner == 'Red',
          playerHeight: player1Score,
          playerColor: AppColors.redColor,
          onTap: player1Tap,
        ),
      ],
    );
  }
}
