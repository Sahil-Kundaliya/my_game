import 'package:dazll_demo/constants/app_colors.dart';
import 'package:dazll_demo/features/home/cubits/home_cubit.dart';
import 'package:dazll_demo/features/home/cubits/home_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../number_game/screens/number_game.dart';
import '../../thumb_game/screens/thumb_page.dart';

class GameMenuScreen extends StatelessWidget {
  const GameMenuScreen({super.key});
  static const String gameMenuScreen = '/GameMenuScreen';

  selecteGame({required int gameIndex, required BuildContext context}) {
    switch (gameIndex) {
      case 0:
        Navigator.pushNamed(context, NumberGameScreen.numberGameScreen);
      case 1:
        Navigator.pushNamed(context, ThumbGameScreen.thumbGameScreen);
        break;
      default:
        Navigator.pushNamed(context, NumberGameScreen.numberGameScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is HomeShowGamesState) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Game Menu'),
              ),
              body: SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    context.read<HomeCubit>().allGames.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: GestureDetector(
                          onTap: () {
                            selecteGame(gameIndex: index, context: context);
                          },
                          child: Container(
                            height: 50,
                            width: size.width,
                            decoration: const BoxDecoration(
                                color: AppColors.amberColor),
                            child: Center(
                                child: Text(
                                    context.read<HomeCubit>().allGames[index])),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Game Menu'),
            ),
            body: const Center(
              child: Text('Game Menu'),
            ),
          );
        },
      ),
    );
  }
}
