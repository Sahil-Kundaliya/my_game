import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_game/constants/app_colors.dart';
import 'package:my_game/constants/app_text_styles.dart';
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12, left: 12, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          brainTabCubit
                              .allGameLevel[brainTabCubit.selectedGameIndex],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor),
                        ),
                        Text(
                          brainTabCubit.formattedTime.timerValue,
                          style: AppTextStyles.poppinStyle(
                              fontSize: 40,
                              color: brainTabCubit.formattedTime.timerColor),
                        ),
                      ],
                    ),
                    CircularPercentIndicator(
                      radius: 30.0,
                      lineWidth: 3.0,
                      percent: brainTabCubit.getTimerPercentage() ?? 0.4,
                      progressColor: Colors.red,
                      backgroundColor: AppColors.greyColor,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: GridView.count(
                        crossAxisCount: brainTabCubit.gridviewCrossAxisCount,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(
                          brainTabCubit.allNumber.length,
                          (index) {
                            var numberIndex = brainTabCubit.allNumber[index];
                            bool isClicked = brainTabCubit
                                .isIndexClicked(numberIndex.number);
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
                                      border: Border.all(
                                          color: AppColors.blackColor),
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
                      )),
                ),
              )
            ],
          );
        });
  }
}
