import 'package:flutter/material.dart';
import 'package:my_game/constants/app_colors.dart';
import 'package:my_game/features/brain_tap/models/number_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class BrainTapGameWidget extends StatelessWidget {
  const BrainTapGameWidget(
      {super.key,
      required this.allNumber,
      required this.timerCounter,
      required this.gridviewCrossAxisCount,
      required this.timerPercentage,
      required this.onTap});
  final int timerCounter, gridviewCrossAxisCount;
  final List<NumberModel> allNumber;
  final double timerPercentage;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: CircularPercentIndicator(
            radius: 30.0,
            lineWidth: 3.0,
            percent: timerPercentage ?? 0.4,
            center: Text(timerCounter.toString()),
            progressColor: Colors.red,
            backgroundColor: AppColors.greyColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: GridView.count(
            crossAxisCount: gridviewCrossAxisCount,
            shrinkWrap: true,
            children: List.generate(
              allNumber.length,
              (index) {
                var numberIndex = allNumber[index];
                return GestureDetector(
                  onTap: () {
                    onTap(numberIndex.number);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blackColor)),
                    child: Center(
                      child: Text(
                        numberIndex.number.toString(),
                        style: TextStyle(
                            // decoration: TextDecoration.lineThrough,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: numberIndex.numberColor),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
