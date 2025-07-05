import 'package:flutter/material.dart';
import 'package:my_game/constants/app_colors.dart';
import 'package:my_game/constants/app_images.dart';
import 'package:my_game/constants/app_text_styles.dart';

class GameIntroPage extends StatelessWidget {
  const GameIntroPage({super.key, required this.onStart});
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 280,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(AppImages.numberFun))),
          ),
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Thumb Game",
              style: AppTextStyles.poppinStyle(
                  fontSize: 25,
                  weight: FontWeight.bold,
                  color: AppColors.whiteColor),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Click all the numbers in sequential order — starting from 1, 2, 3... and so on.",
                textAlign: TextAlign.center,
                style: AppTextStyles.poppinStyle(
                    fontSize: 18,
                    weight: FontWeight.bold,
                    color: AppColors.greyColor),
              ),
            ),
          ],
        )),
        GestureDetector(
          onTap: () {
            onStart();
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.amberColor,
                  borderRadius: BorderRadius.circular(10)),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  "Start",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
