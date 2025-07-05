import 'package:flutter/material.dart';
import 'package:my_game/constants/app_colors.dart';
import 'package:my_game/utils/dimens.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget(
      {super.key,
      required this.playerTitle,
      required this.playerHeight,
      required this.playerColor,
      required this.playerWon,
      required this.onTap});
  final VoidCallback onTap;
  final double playerHeight;
  final Color playerColor;
  final bool playerWon;
  final String playerTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Dimenstions.instance.screenWidth,
        height: playerHeight,
        decoration: BoxDecoration(color: playerColor),
        child: playerWon
            ? const Center(
                child: Text(
                  'Blue Win',
                  style: TextStyle(fontSize: 25, color: AppColors.blackColor),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
