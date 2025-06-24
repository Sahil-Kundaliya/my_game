import 'package:flutter/material.dart';
import 'package:my_game/constants/app_colors.dart';
import 'package:my_game/constants/app_images.dart';

class SelectGameIndex extends StatelessWidget {
  const SelectGameIndex({super.key, required this.onStart});
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
                    fit: BoxFit.cover,
                    image: AssetImage(AppImages.brainTapGameImage))),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Brain Tap",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor),
        ),
        const Text(
          "Start a Game",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.greyColor),
        ),
        const SizedBox(
          height: 40,
        ),
        GestureDetector(
          onTap: () {
            onStart();
          },
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
        )
      ],
    );
  }
}
