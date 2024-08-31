import 'package:dazll_demo/features/number_game/cubits/number_game_cubit.dart';
import 'package:dazll_demo/features/number_game/cubits/number_game_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../resposinve.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  static const String myHomePage = '/MyHomePage';
  Widget getScreen({required BuildContext context, NumberGameState? state}) {
    final size = MediaQuery.sizeOf(context);
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
                itemCount: context.read<NumberGameCubit>().randomNumber.length,
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
                          child: !context.read<NumberGameCubit>().trueAnswer
                              ? Text(context
                                  .read<NumberGameCubit>()
                                  .randomNumber[index]
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
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    bool answered =
                        context.read<NumberGameCubit>().answerNumber[index] ==
                                -1
                            ? true
                            : false;
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
                                      child: context
                                              .read<NumberGameCubit>()
                                              .trueAnswer
                                          ? Text(context
                                              .read<NumberGameCubit>()
                                              .randomNumber[index]
                                              .toString())
                                          : const SizedBox()),
                                ),
                              );
                            },
                            onAcceptWithDetails: (details) {
                              context
                                  .read<NumberGameCubit>()
                                  .pickNumber
                                  .removeWhere(
                                (element) {
                                  return element ==
                                          int.parse(details.data.toString())
                                      ? true
                                      : false;
                                },
                              );
                              context
                                      .read<NumberGameCubit>()
                                      .answerNumber[index] =
                                  int.parse(details.data.toString());

                              if (!context
                                  .read<NumberGameCubit>()
                                  .answerNumber
                                  .contains(-1)) {
                                int totalRightAnswer = 0;
                                for (var i = 0;
                                    i <
                                        context
                                            .read<NumberGameCubit>()
                                            .randomNumber
                                            .length;
                                    i++) {
                                  if (context
                                          .read<NumberGameCubit>()
                                          .randomNumber[i] ==
                                      context
                                          .read<NumberGameCubit>()
                                          .answerNumber[i]) {
                                    totalRightAnswer += 1;
                                  }
                                }
                                if (totalRightAnswer ==
                                    context
                                        .read<NumberGameCubit>()
                                        .answerNumber
                                        .length) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('You WIN'),
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        'You Loss, ${totalRightAnswer == -1 ? 0 : totalRightAnswer} coreet answer'),
                                  ));
                                  context.read<NumberGameCubit>().restart();
                                }
                              }
                              context.read<NumberGameCubit>().cardPickked();
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
                                  child: true
                                      ? Text(
                                          context
                                              .read<NumberGameCubit>()
                                              .answerNumber[index]
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        )
                                      : const SizedBox()),
                            ),
                          );
                  },
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 10, right: 10),
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
                                itemCount: context
                                    .read<NumberGameCubit>()
                                    .pickNumber
                                    .length,
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
                                        data: context
                                            .read<NumberGameCubit>()
                                            .pickNumber[index],
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
                                            context
                                                .read<NumberGameCubit>()
                                                .pickNumber[index]
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
                                            context
                                                .read<NumberGameCubit>()
                                                .pickNumber[index]
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
