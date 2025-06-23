import 'package:flutter/material.dart';
import 'package:my_game/constants/app_colors.dart';
import 'package:my_game/constants/app_images.dart';

class SelectGameIndex extends StatelessWidget {
  const SelectGameIndex(
      {super.key, required this.allGameIndex, required this.onTap});
  final List<int> allGameIndex;
  final Function(int) onTap;

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
          "Just pick",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.greyColor),
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: List.generate(
            allGameIndex.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  onTap(allGameIndex[index]);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.amberColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Text(
                      allGameIndex[index].toString(),
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
