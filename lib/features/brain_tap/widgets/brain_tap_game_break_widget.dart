import 'package:flutter/material.dart';
import 'package:my_game/constants/app_colors.dart';
import 'package:my_game/constants/app_text_styles.dart';

class BrainTapGameBreakWidget extends StatelessWidget {
  const BrainTapGameBreakWidget(
      {super.key,
      required this.nextLevel,
      required this.onTap,
      required this.nextLevelCounter});
  final String nextLevel;
  final int nextLevelCounter;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.2),
          child: RichText(
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
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Text(
            "Next Level: Tap all $nextLevelCounter numbers in order to complete the challenge!",
            textAlign: TextAlign.center,
            style: AppTextStyles.poppinStyle(
                fontSize: 14,
                weight: FontWeight.bold,
                color: AppColors.greyColor),
          ),
        ),
        Flexible(
          flex: 1,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 45),
              child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black, // Shadow color
                  elevation: 5, // Elevation
                  backgroundColor: AppColors.amberColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor),
                ),
                child: const Text('Next',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor)),
              ),
            ),
          ),
        )
      ],
    );
  }
}
