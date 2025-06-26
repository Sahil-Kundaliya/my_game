import 'package:flutter/material.dart';
import 'package:my_game/constants/app_colors.dart';

class BrainTapGameOverWidget extends StatelessWidget {
  const BrainTapGameOverWidget(
      {super.key,
      required this.onRestart,
      required this.isGameWin,
      required this.lastLevelName});
  final VoidCallback onRestart;
  final bool isGameWin;
  final String lastLevelName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isGameWin ? "Congratulations" : "Game over",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: AppColors.customYellowColor),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: isGameWin
                    ? RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          const TextSpan(
                            text: "You are ",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.greyColor),
                          ),
                          TextSpan(
                            // text: lastLevelName.toUpperCase(),
                            text: "winner".toUpperCase(),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.customYellowColor),
                          ),
                          const TextSpan(
                            text: "\nPlay one more time",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.greyColor),
                          ),
                        ]))
                    : const Text(
                        "Better luck next time",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.greyColor),
                      ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 45),
          child: ElevatedButton(
            onPressed: onRestart,
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.black, // Shadow color
              elevation: 5, // Elevation
              backgroundColor: AppColors.amberColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor),
            ),
            child: const Text('Try again',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor)),
          ),
        )
      ],
    );
  }
}
