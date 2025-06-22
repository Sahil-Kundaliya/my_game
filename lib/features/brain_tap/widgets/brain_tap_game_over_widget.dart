import 'package:flutter/material.dart';
import 'package:my_game/constants/app_colors.dart';

class BrainTapGameOverWidget extends StatelessWidget {
  const BrainTapGameOverWidget(
      {super.key, required this.onRestart, required this.isGameWin});
  final VoidCallback onRestart;
  final bool isGameWin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          isGameWin ? "Your WIn" : "Game over",
          style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 45),
          child: Text(
            isGameWin
                ? "Congratulations, you win!\nPlay one more time"
                : "Better luck next time",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.greyColor),
          ),
        ),
        Flexible(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 45),
                  child: ElevatedButton(
                    onPressed: onRestart,
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.black, // Shadow color
                      elevation: 5, // Elevation
                      backgroundColor: AppColors.amberColor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12), // Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor),
                    ),
                    child: const Text('Restart',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor)),
                  ),
                )))
      ],
    );
  }
}
