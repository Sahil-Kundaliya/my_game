import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'resposinve.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> randomNumber = [1, 2, 3, 4, 5, 6];
  List<int> answerNumber = [-1, -1, -1, -1, -1, -1];
  List<int> pickNumber = [1, 2, 3, 4, 5, 6];
  bool trueAnswer = false;

  @override
  void initState() {
    super.initState();
    randomNumber.shuffle();
    // pickNumber.shuffle();
  }

  void restart() {
    answerNumber = [-1, -1, -1, -1, -1, -1];
    pickNumber = [1, 2, 3, 4, 5, 6];
  }

  Widget getScreen() {
    final size = MediaQuery.of(context).size;
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
              child: DragTarget(
                builder: (context, candidateData, rejectedData) {
                  return ListView.builder(
                    itemCount: randomNumber.length,
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
                              child: trueAnswer
                                  ? Text(randomNumber[index].toString())
                                  : const SizedBox()),
                        ),
                      );
                    },
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
                    bool answered = answerNumber[index] == -1 ? true : false;
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
                                      child: trueAnswer
                                          ? Text(randomNumber[index].toString())
                                          : const SizedBox()),
                                ),
                              );
                            },
                            onAcceptWithDetails: (details) {
                              pickNumber.removeWhere(
                                (element) {
                                  return element ==
                                          int.parse(details.data.toString())
                                      ? true
                                      : false;
                                },
                              );
                              answerNumber[index] =
                                  int.parse(details.data.toString());

                              if (randomNumber == answerNumber) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('You WIN'),
                                ));
                              } else if (!answerNumber.contains(-1)) {
                                int totalRightAnswer = -1;
                                for (var i = 0; i < randomNumber.length; i++) {
                                  if (randomNumber[i] == answerNumber[i]) {
                                    totalRightAnswer += 1;
                                  }
                                }
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      'You Loss, ${totalRightAnswer == -1 ? 0 : totalRightAnswer} coreet answer'),
                                ));
                                restart();
                              }

                              setState(() {});
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
                                          answerNumber[index].toString(),
                                          style: const TextStyle(fontSize: 20),
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
                      child: Container(
                        height: 60,
                        width: size.width,
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: pickNumber.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Container(
                                      height: 60,
                                      width: 50,
                                      // color: Colors.amber,
                                      child: Draggable(
                                        data: pickNumber[index],
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
                                            pickNumber[index].toString(),
                                            style:
                                                const TextStyle(fontSize: 20),
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
                                            pickNumber[index].toString(),
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
    return ResponsiveLayout(
      mobileBody: getScreen(),
      tabletBody: const Center(
        child: Text('Table'),
      ),
      webBody: getScreen(),
    );
  }
}
