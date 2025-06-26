import 'package:flutter/material.dart';
import 'package:my_game/constants/app_colors.dart';
import 'package:my_game/constants/app_text_styles.dart';

class BrainTapGameBreakWidget extends StatelessWidget {
  const BrainTapGameBreakWidget(
      {super.key, required this.nextLevel, required this.breakTime});
  final String nextLevel;
  final String breakTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              const TextSpan(
                text: "Next level is for\n",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor),
              ),
              TextSpan(
                text: "$nextLevel players",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColors.customYellowColor),
              )
            ],
          ),
        ),
        Text(
          breakTime,
          style: AppTextStyles.robotoStyle(
              fontSize: 130, color: AppColors.redColor),
        ),
      ],
    );
  }
}
