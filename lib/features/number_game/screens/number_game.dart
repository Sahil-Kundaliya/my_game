import 'package:my_game/constants/app_colors.dart';
import 'package:my_game/constants/app_enums.dart';
import 'package:my_game/features/number_game/cubits/number_game_cubit.dart';
import 'package:my_game/features/number_game/cubits/number_game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../resposinve.dart';

class NumberGameScreen extends StatelessWidget {
  const NumberGameScreen({super.key});
  static const String numberGameScreen = '/NumberGameScreen';

  Widget getScreen({required BuildContext context, NumberGameState? state}) {
    final size = MediaQuery.sizeOf(context);
    NumberGameCubit numberGameCubit = context.read<NumberGameCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Game'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: size.height * 0.15,
                decoration: const BoxDecoration(),
                child: Center(
                    child: Text(
                  getLevelTitle(context: context),
                  style: const TextStyle(
                      fontSize: 30,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold),
                )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'You tried  ',
                      style:
                          TextStyle(fontSize: 14, color: AppColors.blackColor),
                    ),
                    Text(
                      numberGameCubit.attemptedCount.toString(),
                      style: const TextStyle(
                          fontSize: 14, color: AppColors.redColor),
                    ),
                    const Text(
                      ' Times',
                      style:
                          TextStyle(fontSize: 14, color: AppColors.blackColor),
                    )
                  ],
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  SizedBox(
                    width: size.width,
                    // height: 65,
                    child: Wrap(
                      alignment: numberGameCubit.currentLevel == GameLevel.level_3
                          ? WrapAlignment.start
                          : WrapAlignment.center,
                      runSpacing: 2,
                      children: List.generate(
                        numberGameCubit.randomNumber.length,
                        (index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              height: 60,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                  child: numberGameCubit.winnerTime || true
                                      ? Text(numberGameCubit.randomNumber[index]
                                          .toString())
                                      : const SizedBox()),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  width: size.width,
                  // height: 65,
                  child: Wrap(
                    runSpacing: 2,
                    alignment: numberGameCubit.currentLevel == GameLevel.level_3
                        ? WrapAlignment.start
                        : WrapAlignment.center,
                    children: List.generate(
                      numberGameCubit.randomNumber.length,
                      (index) {
                        bool answered = true;
                        if (numberGameCubit.answerNumber[index] == -1) {
                          answered = true;
                        } else if (numberGameCubit.selectedItem != -1) {
                          if (index == numberGameCubit.selectedItem) {
                            answered = false;
                          } else {
                            answered = true;
                          }
                        } else {
                          answered = false;
                        }
                        return answered
                            ? DragTarget(
                                builder:
                                    (context, candidateData, rejectedData) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Container(
                                      height: 60,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Center(
                                          child: numberGameCubit
                                                      .answerNumber[index] !=
                                                  -1
                                              ? Text(numberGameCubit
                                                  .answerNumber[index]
                                                  .toString())
                                              : const SizedBox(
                                                  child: Text(''),
                                                )),
                                    ),
                                  );
                                },
                                onAcceptWithDetails: (details) {
                                  numberGameCubit.selectedAnswer(
                                      details: details,
                                      context: context,
                                      index: index);
                                },
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  height: 60,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                      child: Draggable(
                                    data: numberGameCubit.answerNumber[index],
                                    onDragStarted: () {
                                      numberGameCubit.changeSelctedItemIndex(
                                          index: index);
                                    },
                                    onDragEnd: (details) {
                                      numberGameCubit.changeSelctedItemIndex(
                                          index: -1);
                                    },
                                    feedback: Container(
                                      height: 60,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Center(
                                          child: Text(
                                        numberGameCubit.answerNumber[index]
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            decoration: TextDecoration.none),
                                      )),
                                    ),
                                    childWhenDragging: const SizedBox(),
                                    child: Container(
                                      height: 60,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Center(
                                          child: Text(
                                        numberGameCubit.answerNumber[index]
                                            .toString(),
                                        style: const TextStyle(fontSize: 20),
                                      )),
                                    ),
                                  )),
                                ),
                              );
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: GestureDetector(
                  onTap: () {
                    numberGameCubit.checkAnswer(context: context);
                  },
                  child: Container(
                    height: 60,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: numberGameCubit.answerPicked
                            ? AppColors.amberColor
                            : AppColors.greyColor),
                    child: const Center(
                        child: Text(
                      'Check Now',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15.0, 10, 0),
                  child: Container(
                    height: 165,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Center(
                          child: !numberGameCubit.answerPicked
                              ? SizedBox(
                                  // height: 60,
                                  width: size.width,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 1,
                                      runSpacing: 10,
                                      children: List.generate(
                                        numberGameCubit.pickNumber.length,
                                        (index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            child: SizedBox(
                                              height: 60,
                                              width: 50,
                                              // color: Colors.amber,
                                              child: Draggable(
                                                data: numberGameCubit
                                                    .pickNumber[index],
                                                feedback: Container(
                                                  height: 60,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade300,
                                                      border: Border.all(
                                                          color: Colors.black),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Center(
                                                      child: Text(
                                                    numberGameCubit
                                                        .pickNumber[index]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                        decoration:
                                                            TextDecoration
                                                                .none),
                                                  )),
                                                ),
                                                childWhenDragging:
                                                    const SizedBox(),
                                                child: Container(
                                                  height: 60,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade300,
                                                      border: Border.all(
                                                          color: Colors.black),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Center(
                                                      child: Text(
                                                    numberGameCubit
                                                        .pickNumber[index]
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  )),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ))
                              : Text(
                                  'You have ${numberGameCubit.totalRightAnswer} Correct Answer')),
                    ),
                  )),
              if (!numberGameCubit.answerPicked)
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, top: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        numberGameCubit.selectRandomAnswer();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey, // Background color

                        elevation: 5, // Shadow under the button
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20), // Rounded corners
                        ),
                        textStyle: const TextStyle(
                            fontSize: 18, color: AppColors.blackColor),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Pick random number',
                            style: TextStyle(
                                fontSize: 18, color: AppColors.blackColor),
                          ),
                          Icon(
                            Icons.shuffle_sharp,
                            color: AppColors.amberColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String getLevelTitle({required BuildContext context}) {
    NumberGameCubit numberGameCubit = context.read<NumberGameCubit>();

    switch (numberGameCubit.currentLevel) {
      case GameLevel.level_1:
        return 'Level 1';
      case GameLevel.level_2:
        return 'Level 2';
      case GameLevel.level_3:
        return 'Level 3';
      default:
        return 'Level 1';
    }
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => NumberGameCubit(),
      child: BlocBuilder<NumberGameCubit, NumberGameState>(
        builder: (context, state) {
          return ResponsiveLayout(
            mobileBody: getScreen(context: context),
            tabletBody: const Center(
              child: Text('tablet'),
            ),
            webBody: getScreen(context: context, state: state),
          );
        },
      ),
    );
  }
}
