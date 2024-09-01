import 'dart:developer';

import 'package:dazll_demo/constants/app_colors.dart';
import 'package:dazll_demo/features/number_game/cubits/number_game_cubit.dart';
import 'package:dazll_demo/features/number_game/cubits/number_game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../resposinve.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  static const String myHomePage = '/MyHomePage';

  selectedAnswer(
      {required BuildContext context,
      required DragTargetDetails<Object?> details,
      required int index}) {
    NumberGameCubit numberGameCubit = context.read<NumberGameCubit>();
    if (numberGameCubit.answerNumber[index] == -1) {
      numberGameCubit.pickNumber.removeWhere(
        (element) {
          return element == int.parse(details.data.toString()) ? true : false;
        },
      );

      for (var i = 0; i < numberGameCubit.answerNumber.length; i++) {
        if (i == numberGameCubit.selectedItem) {
          numberGameCubit.answerNumber[i] = -1;
        }
      }
      numberGameCubit.answerNumber[index] = int.parse(details.data.toString());
    } else {
      numberGameCubit.answerNumber[numberGameCubit.selectedItem] =
          numberGameCubit.answerNumber[index];
      numberGameCubit.answerNumber[index] = int.parse(details.data.toString());
    }
    numberGameCubit.updateState();
  }

  Widget getScreen({required BuildContext context, NumberGameState? state}) {
    final size = MediaQuery.sizeOf(context);
    NumberGameCubit numberGameCubit = context.read<NumberGameCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height * 0.15,
              decoration: const BoxDecoration(),
            ),
            SizedBox(
              width: size.width,
              height: 65,
              child: ListView.builder(
                itemCount: numberGameCubit.randomNumber.length,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      height: 60,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: !numberGameCubit.trueAnswer
                              ? Text(numberGameCubit.randomNumber[index]
                                  .toString())
                              : const SizedBox()),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: size.width,
                height: 65,
                child: ListView.builder(
                  itemCount: numberGameCubit.randomNumber.length,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
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
                            builder: (context, candidateData, rejectedData) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  height: 60,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                      child:
                                          numberGameCubit.answerNumber[index] !=
                                                  -1
                                              ? Text(numberGameCubit
                                                  .answerNumber[index]
                                                  .toString())
                                              : const SizedBox(
                                                  child: Text('-1'),
                                                )),
                                ),
                              );
                            },
                            onAcceptWithDetails: (details) {
                              selectedAnswer(
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
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(8)),
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
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(8)),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: GestureDetector(
                onTap: () {
                  if (!numberGameCubit.answerNumber.contains(-1)) {
                    int totalRightAnswer = 0;
                    for (var i = 0;
                        i < numberGameCubit.randomNumber.length;
                        i++) {
                      if (numberGameCubit.randomNumber[i] ==
                          numberGameCubit.answerNumber[i]) {
                        totalRightAnswer += 1;
                      }
                    }
                    if (totalRightAnswer ==
                        numberGameCubit.answerNumber.length) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('You Win'),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'You Loss, ${totalRightAnswer == -1 ? 0 : totalRightAnswer} Correct Answer'),
                      ));
                      // numberGameCubit.restart();
                    }
                  }
                },
                child: Container(
                  height: 60,
                  width: size.width,
                  decoration: const BoxDecoration(color: AppColors.amberColor),
                  child: const Center(
                      child: Text(
                    'Check Now',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      child: SizedBox(
                        height: 60,
                        width: size.width,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: numberGameCubit.pickNumber.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: SizedBox(
                                      height: 60,
                                      width: 50,
                                      // color: Colors.amber,
                                      child: Draggable(
                                        data: numberGameCubit.pickNumber[index],
                                        feedback: Container(
                                          height: 60,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              border: Border.all(
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Center(
                                              child: Text(
                                            numberGameCubit.pickNumber[index]
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                decoration:
                                                    TextDecoration.none),
                                          )),
                                        ),
                                        childWhenDragging: const SizedBox(),
                                        child: Container(
                                          height: 60,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              border: Border.all(
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Center(
                                              child: Text(
                                            numberGameCubit.pickNumber[index]
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 20),
                                          )),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
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
              child: Text('Table'),
            ),
            webBody: getScreen(context: context, state: state),
          );
        },
      ),
    );
  }
}
