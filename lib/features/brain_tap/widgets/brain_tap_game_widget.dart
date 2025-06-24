import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_game/constants/app_colors.dart';
import 'package:my_game/features/brain_tap/cubits/brain_tap_cubit.dart';
import 'package:my_game/features/brain_tap/cubits/brain_tap_state.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class BrainTapGameWidget extends StatelessWidget {
  const BrainTapGameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrainTabCubit, BrainTabState>(
        listener: (context, state) {},
        builder: (context, state) {
          var brainTabCubit = context.read<BrainTabCubit>();

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: CircularPercentIndicator(
                  radius: 30.0,
                  lineWidth: 3.0,
                  percent: brainTabCubit.getTimerPercentage() ?? 0.4,
                  center: Text(
                    (brainTabCubit.selectedGameIndex - brainTabCubit.timerCount)
                        .toString(),
                    style: const TextStyle(color: AppColors.whiteColor),
                  ),
                  progressColor: Colors.red,
                  backgroundColor: AppColors.greyColor,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GridView.count(
                    crossAxisCount: brainTabCubit.gridviewCrossAxisCount,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    shrinkWrap: true,
                    children: List.generate(
                      brainTabCubit.allNumber.length,
                      (index) {
                        var numberIndex = brainTabCubit.allNumber[index];
                        bool isClicked =
                            brainTabCubit.isIndexClicked(numberIndex.number);
                        return GestureDetector(
                          onTap: () {
                            brainTabCubit.tapNumber(numberIndex.number);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: EdgeInsets.all(isClicked ? 2 : 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: isClicked
                                      ? Colors.grey.shade100
                                      : Colors.white,
                                  border:
                                      Border.all(color: AppColors.blackColor),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  numberIndex.number.toString(),
                                  style: TextStyle(
                                      // decoration: isClicked
                                      //     ? TextDecoration.lineThrough
                                      //     : TextDecoration.none,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: numberIndex.numberColor),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ))
            ],
          );
        });
  }
}
